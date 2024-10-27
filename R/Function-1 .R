#' Calculate Annual Price Growth for a Locality
#'
#' This function calculates the annual growth rate of the median property price for a specified locality.
#'
#' @param property_data Data frame containing property data with columns 'Locality', 'year', and 'median_price'.
#' @param locality Character string specifying the name of the locality for which to calculate annual growth.
#'
#' @return A data frame with columns 'year', 'median_price', and 'annual_growth_rate' representing the annual price growth rate.
#' @examples
#' annual_price_growth(property_data, "ABBOTSFORD")
annual_price_growth <- function(property_data, locality) {
  print("property_data type:")
  print(class(property_data))
  print("property_data columns:")
  print(names(property_data))

  # Filter data for the selected locality
  subset <- property_data[property_data$Locality == locality, ]
  print("Subset after filtering by locality:")
  print(head(subset))  # Check the first few rows to ensure filtering works

  # Sort by year and calculate annual growth rate
  subset <- subset[order(subset$year), ]
  subset$annual_growth_rate <- c(NA, diff(subset$median_price) / head(subset$median_price, -1) * 100)

  # Return the result with selected columns
  return(subset[, c("year", "median_price", "annual_growth_rate")])
}



