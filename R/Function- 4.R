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
  # Define a helper function to calculate the average growth rate
  avg_growth <- function(x) mean(diff(log(x)), na.rm = TRUE) * 100

  # Calculate the average median price per year
  avg_price_summary <- aggregate(median_price ~ year, data = data, mean)
  colnames(avg_price_summary)[2] <- "avg_median_price"

  # Calculate the average growth rate per year
  avg_growth_summary <- aggregate(median_price ~ year, data = data, avg_growth)
  colnames(avg_growth_summary)[2] <- "avg_growth_rate"

  # Calculate the count of unique localities per year
  locality_count_summary <- aggregate(Locality ~ year, data = data, function(x) length(unique(x)))
  colnames(locality_count_summary)[2] <- "locality_count"

  # Merge the summaries by year to create a single data frame
  summary <- merge(avg_price_summary, avg_growth_summary, by = "year")
  summary <- merge(summary, locality_count_summary, by = "year")

  return(summary)
}

