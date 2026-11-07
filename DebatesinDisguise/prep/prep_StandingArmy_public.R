# load package

library(tidyverse)
library(quanteda)
library(conflicted)

conflicts_prefer(dplyr::filter)

# load data

raw_data <-
  read_csv("prep/debate_in_magazines.csv")

# target

target_subject <- "Standing Armies"

df_army <-
  raw_data |>
  filter(subject == target_subject) |>
  mutate(
    stance_on_army = stance_on_army_tmp |> str_squish() |> str_to_lower(),
    text = text |>
      str_replace_all("[’‘]", "'") |>
      stringi::stri_replace_all_fixed("ſ", "s") |>
      str_squish()
  )

df_army <-
  df_army |>
  filter(stance_on_army %in% c("pro_army", "anti_army")) |>
  mutate(
    stance_on_army = factor(
      stance_on_army,
      levels = c("pro_army", "anti_army")
    ),
    doc_id = paste0(source_1, "_", row_number())
  ) |>
  select(
    doc_id,
    source_1,
    subject,
    stance_on_agenda,
    stance_on_army,
    party,
    speaker_disguised_name,
    text
  )

# stopwords ----
load_stopwords <- function(
  path = "prep/config/stopwords.yml",
  groups = "common"
) {
  cfg <- yaml::read_yaml(path)

  custom <- cfg[groups] |>
    unlist(use.names = FALSE) |>
    stringr::str_to_lower() |>
    unique()

  keep <- if (is.null(cfg$keep)) character(0) else cfg$keep

  list(
    custom = setdiff(custom, keep),
    base = setdiff(quanteda::stopwords("en"), keep)
  )
}

sw <- load_stopwords(groups = "common")

# multiword expression ----
load_compounds <- function(
  path = "prep/config/stopwords.yml",
  groups = "common"
) {
  cfg <- yaml::read_yaml(path)

  cfg$compounds[groups] |>
    unlist(use.names = FALSE) |>
    stringr::str_to_lower() |>
    unique()
}

comp <- load_compounds(groups = "common")

# corpus ----

corp <-
  corpus(df_army, docid_field = "doc_id", text_field = "text")


# tokens ----
tok_base <-
  corp |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  tokens_tolower() |>
  tokens_compound(pattern = phrase(comp))

tok_pad <-
  tok_base |>
  tokens_remove(c(sw$base, sw$custom), padding = TRUE)

tok <- # dfm
  tok_base |>
  tokens_remove(c(sw$base, sw$custom))

# dfm ----
dfm_raw <- tok |>
  dfm()

dfm_stem <- tok |>
  tokens_wordstem() |>
  dfm()

# save ----

saveRDS(
  list(
    df = df_army,
    corp = corp,
    tok_base = tok_base,
    tok_pad = tok_pad,
    tok = tok,
    dfm_raw = dfm_raw,
    dfm_stem = dfm_stem,
    sw = sw,
    comp = comp,
    meta = list(
      date = Sys.Date(),
      target_subject = target_subject,
      quanteda = as.character(packageVersion("quanteda"))
    )
  ),
  file = "prep/prep_standingarmy.rds"
)
