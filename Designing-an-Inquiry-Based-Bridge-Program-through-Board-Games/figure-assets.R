library(tidyverse)
library(paletteer)

# Import data
df <-
  read_csv("data/monopoly.csv")

# Prepare data
df <-
  df |>
  mutate(
    category = factor(category, levels = c("A", "B", "C")),
    term = factor(term, levels = sort(unique(term)))
  )

# Create the figure
df |>
  ggplot(aes(x = category, y = asset, fill = category)) +
  geom_boxplot(alpha = 0.8) +
  geom_point() +
  scale_fill_paletteer_d("PNWColors::Sunset2") +
  labs(
    # title = "Figure. 1",
    x = "",
    y = "Asset"
  ) +
  facet_wrap(~term)
