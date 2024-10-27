## code to prepare `DATASET` dataset goes here

library(readxl)
library(tidyverse)
library(dplyr)
library(tidyr)

property_data_wide <- read_excel("data-raw/Houses-by-suburb-2013-2023.xlsx")


### Cleaning of the data

property_data_wide$`2013` <- as.numeric(property_data$`2013`)
property_data_wide$`2014` <- as.numeric(property_data$`2014`)
property_data_wide$`2015` <- as.numeric(property_data$`2015`)
property_data_wide$`2016` <- as.numeric(property_data$`2016`)
property_data_wide$`2017` <- as.numeric(property_data$`2017`)
property_data_wide$`2018` <- as.numeric(property_data$`2018`)
property_data_wide$`2019` <- as.numeric(property_data$`2019`)
property_data_wide$`Prelim` <- as.numeric(property_data$`Prelim`)
property_data_wide$`13-23` <- as.numeric(property_data$`13-23`)
property_data_wide$`PA` <- as.numeric(property_data$`PA`)


property_data <- property_data_wide %>%
  pivot_longer(
    cols = starts_with("20"),  # Select columns for each year
    names_to = "year",           # Create a new 'year' column
    values_to = "median_price"    # Rename values column
  ) %>%
  mutate(year = as.integer(year))

glimpse(property_data)

usethis::use_data(property_data, overwrite = TRUE)
usethis::use_data(property_data_wide, overwrite = TRUE)
