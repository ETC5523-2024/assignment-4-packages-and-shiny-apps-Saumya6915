
#' Summarize Market Trends by Year
#'
#' Aggregates annual statistics, such as average median price, average growth rate, and the number of localities tracked, by year.
#'
#' @param data Data frame containing property data with columns 'year', 'median_price', and 'Locality'.
#'
#' @return A data frame with columns 'year', 'avg_median_price', 'avg_growth_rate', and 'locality_count', summarizing trends per year.
#' @examples
#' market_trends_by_year(property_data)

market_trends_by_year <- function(data) {
  avg_growth <- function(x) mean(diff(log(x)), na.rm = TRUE) * 100
  summary <- aggregate(median_price ~ year, data, function(x) c(mean(x), avg_growth(x)))
  summary <- do.call(data.frame, summary)
  colnames(summary) <- c("year", "avg_median_price", "avg_growth_rate")
  summary$locality_count <- aggregate(Locality ~ year, data, function(x) length(unique(x)))$Locality
  return(summary)
}
