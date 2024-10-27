#' Top-Performing Suburbs Based on Average Annual Growth
#'
#' Identifies the top-performing suburbs with the highest average annual growth rate over a specified period.
#'
#' @param data Data frame containing property data with columns 'Locality', 'year', and 'median_price'.
#' @param start_year Numeric value indicating the start year of the analysis period.
#' @param end_year Numeric value indicating the end year of the analysis period.
#' @param top_n Numeric value specifying the number of top-performing suburbs to return. Default is 5.
#'
#' @return A data frame with columns 'Locality' and 'avg_annual_growth_rate', showing the top `top_n` suburbs.
#' @examples
#' top_performing_suburbs(property_data, 2013, 2023, top_n = 10)


top_performing_suburbs <- function(property_data, start_year, end_year, top_n = 5) {
  period_data <- subset(data, year >= start_year & year <= end_year)
  growth_data <- aggregate(median_price ~ Locality, data = period_data, function(x) mean(diff(log(x))) * 100)
  colnames(growth_data)[2] <- "avg_annual_growth_rate"
  return(head(growth_data[order(-growth_data$avg_annual_growth_rate), ], top_n))
}
