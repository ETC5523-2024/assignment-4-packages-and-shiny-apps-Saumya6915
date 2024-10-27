#' Property Sales Data for Melbourne Suburbs in wide format (2013-2023)
#'
#' A data set containing property sales statistics for various suburbs in Melbourne from 2013 to 2023.
#' It includes median property prices for each year and other calculated fields like preliminary values,
#' percentage changes, and annual growth rates.
#'
#' @format A data frame with 787 rows and 16 variables:
#' \describe{
#'   \item{Locality}{Name of the suburb (character)}
#'   \item{2013}{Median property price in 2013 (numeric, in AUD)}
#'   \item{2014}{Median property price in 2014 (numeric, in AUD)}
#'   \item{2015}{Median property price in 2015 (numeric, in AUD)}
#'   \item{2016}{Median property price in 2016 (numeric, in AUD)}
#'   \item{2017}{Median property price in 2017 (numeric, in AUD)}
#'   \item{2018}{Median property price in 2018 (numeric, in AUD)}
#'   \item{2019}{Median property price in 2019 (numeric, in AUD)}
#'   \item{2020}{Median property price in 2020 (numeric, in AUD)}
#'   \item{2021}{Median property price in 2021 (numeric, in AUD)}
#'   \item{2022}{Median property price in 2022 (numeric, in AUD)}
#'   \item{2023}{Median property price in 2023 (numeric, in AUD)}
#'   \item{Prelim}{Preliminary property price for 2023 (numeric, in AUD)}
#'   \item{22-23}{Percentage change in median property price from 2022 to 2023 (numeric)}
#'   \item{13-23}{Percentage change in median property price from 2013 to 2023 (numeric)}
#'   \item{PA}{Average annual growth rate of the property price over the period (numeric)}
#' }
#' @source Victoria State Government, Property Sales Statistics dataset (2013-2023). Available from: \url{https://www.land.vic.gov.au/valuations/resources-and-reports/property-sales-statistics}
"property_data_wide"
