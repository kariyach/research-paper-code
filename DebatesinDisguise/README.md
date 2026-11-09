# Code & Data

This repository contains the R code used to generate figures for the conference presentation, "Debates in Disguise: The Gentleman's Magazine and The London Magazine around the 1740s."

To support code reuse and data validation, this project outlines its purpose, usage, and dependencies. Please note that the underlying data is not included due to copyright restrictions. This repository primarily focuses on data preprocessing for quantitative text analysis and figure generation. Consequently, the results are not fully reproducible without the original data.

## Environment & Dependencies

This code was developed and tested using the following environment:

- **R version 4.6.0**

### Key Packages
The following primary packages are required to run the code:

| Package | Version | Description |
| :--- | :--- | :--- |
| tidyverse | 2.0.0 | Data manipulation and visualization (includes ggplot2, dplyr, etc.) |
| quanteda | 4.5.0 | Quantitative text analysis |
| quanteda.textstats | 0.96 | Textual statistics for quanteda |
| tidytext | 0.4.3 | Text data manipulation |

*Note*: Other dependent packages required by the above packages will be installed

## Data structure

The original CSV files are not included in this repository due to copyright restrictions. The following table lists the column names and their descriptions for reference.

| Column | Description |
|:---|:---|
| `year` | Year of the debate |
| `month` | Month of the debate |
| `day` | Day of the debate |
| `house` | House in which the debate took place |
| `source_1` | Primary source |
| `source_2` | Secondary source |
| `Yale_pages` | Page numbers in the Yale edition |
| `source_vol` | Source volume |
| `source_year` | Publication year of the source |
| `source_month` | Publication month of the source |
| `source_start` | Starting page of the source |
| `source_end` | Ending page of the source |
| `subject` | Subject identifier |
| `subject_full` | Full description of the subject |
| `speaker` | Speaker |
| `speaker_disguised_name` | Disguised name of the speaker |
| `stance_on_agenda` | Position on the agenda |
| `stance_on_army_tmp` | Position on the standing army |
| `party` | Political party or affiliation |
| `order` | Order of the speech |
| `text` | Speech text |
| `note` | Notes |