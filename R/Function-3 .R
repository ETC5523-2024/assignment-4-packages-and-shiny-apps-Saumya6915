

#' Calculate Price Volatility for a Locality
#'
#' Measures the volatility of property prices over the available period for a specified locality.
#'
#' @param data Data frame containing property data with columns 'Locality' and 'median_price'.
#' @param locality Character string specifying the name of the locality for which to measure volatility.
#'
#' @return A list with 'Locality' and 'Price Volatility', representing the standard deviation of prices for the locality.
#' @examples
#' price_volatility(property_data, "ABBOTSFORD")


price_volatility <- function(data, locality) {
  subset <- data[data$Locality == locality, ]
  volatility <- sd(subset$median_price, na.rm = TRUE)
  return(list(Locality = locality, Price_Volatility = volatility))
}
