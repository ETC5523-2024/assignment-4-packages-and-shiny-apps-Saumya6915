
# MelbournePrices

<!-- badges: start -->
<!-- badges: end -->

## Goal

The MelbournePrices package provides tools to analyze trends and price volatility in Melbourne's housing market from 2013 to 2023.
Designed for investors, analysts, and policymakers, it offers insights into annual growth rates, top-performing suburbs, market stability, and overall trends, helping users make informed decisions in the real estate market.

## Usage Guide

1. **Annual Price Growth**: Useful for tracking how property prices in a specific suburb have changed year-over-year.

2. **Top-Performing Suburbs**: Helps identify suburbs with the highest annual growth over a selected period.

3. **Price Volatility**: Indicates market stability within a suburb.

4. **Market Trends Summary**: Offers an overview of the property market's general trends.

Each function is designed to help users gain insights into Melbourne’s dynamic property market and make informed decisions. 


## Installation

You can install the development version of **MelbournePrices** from [GitHub](https://github.com/) with:

```{r}
remotes::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-Saumya6915")
```
OR click on this [link](https://github.com/ETC5523-2024/assignment-4-packages-and-shiny-apps-Saumya6915) for the same.


### Install remotes package if you haven't

```{r}
install.packages("remotes")
```

## Usage 

Here's a quick guide to get you started with some core functions:

```{r}
library(MelbournePrices)
data("property_data", package = "MelbournePrices")
```
### Annual Price Growth for a Suburb
```{r}
annual_growth <- annual_price_growth(property_data, "ABBOTSFORD")
head(annual_growth)
```
### Identifying Top-Performing Suburbs
```{r}
top_suburbs <- top_performing_suburbs(property_data, 2013, 2023, top_n = 5)
top_suburbs
```
# Calculating Price Volatility for a Suburb
```{r}
volatility <- price_volatility(property_data, "ABBOTSFORD")
volatility
```
# Summarizing Market Trends by Year
```{r}
annual_trends <- market_trends_by_year(property_data)
head(annual_trends)
```
Detailed examples with solutions can be found in vignette("MelbournePrices").

## Getting help 

If you encounter a clear bug or have questions about using this package, 
please reach out via email at [scha0310@student.monash.edu](mailto:scha0310@student.monash.edu) or post in the RStudio Community Forum. 

