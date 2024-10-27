library(shiny)
library(ggplot2)
library(dplyr)
library(shinydashboard)

# Load property data from your package
data("property_data", package = "MelbournePrices")  # Replace with your actual package name

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = HTML("<b>Melbourne Property Insights</b>")),  # Updated title with bold styling

  dashboardSidebar(
    sidebarMenu(
      menuItem("Annual Price Growth", tabName = "growth", icon = icon("chart-line")),
      menuItem("Top-Performing Suburbs", tabName = "top_suburbs", icon = icon("fire")),
      menuItem("Price Volatility", tabName = "volatility", icon = icon("bolt")),
      menuItem("Market Trends Summary", tabName = "trends", icon = icon("table"))
    )
  ),

  dashboardBody(
    tags$head(tags$style(HTML('
      /* Header and Sidebar Customization */
      .skin-blue .main-header .logo {
        background-color: #2a3f54;
        color: white;
        font-weight: bold;
      }
      .skin-blue .main-sidebar {
        background-color: #2a3f54;
      }
      .skin-blue .main-header .navbar {
        background-color: #2a3f54;
      }
      /* Content Panel Customization */
      .content-wrapper, .right-side {
        background-color: #f3f6fa;
      }
    '))),

    tabItems(
      # Annual Price Growth Tab
      tabItem(tabName = "growth",
              h2("Annual Price Growth for a Locality"),
              selectInput("locality_growth", "Choose a Locality:", choices = unique(property_data$Locality)),
              plotOutput("growthPlot"),
              tableOutput("growthTable"),
              br(),
              p("This plot shows the year-over-year growth rate of property prices for the selected locality, helping users understand price appreciation or depreciation trends over time.")
      ),

      # Top-Performing Suburbs Tab
      tabItem(tabName = "top_suburbs",
              h2("Top-Performing Suburbs by Average Annual Growth"),
              numericInput("start_year", "Start Year:", min = min(property_data$year), max = max(property_data$year), value = 2013),
              numericInput("end_year", "End Year:", min = min(property_data$year), max = max(property_data$year), value = 2023),
              numericInput("top_n", "Number of Top Suburbs:", value = 5, min = 1),
              actionButton("generate", "Generate Output"),  # Action button to trigger output
              tableOutput("topSuburbsTable"),
              br(),
              p("This table lists the top-performing suburbs based on average annual growth rate, calculated over the selected time period.")
      ),


      # Price Volatility Tab
      tabItem(tabName = "volatility",
              h2("Price Volatility for a Locality"),
              selectInput("locality_volatility", "Choose a Locality:", choices = unique(property_data$Locality)),
              verbatimTextOutput("volatilityOutput"),
              br(),
              p("The price volatility is calculated as the standard deviation of property prices over time for the selected locality. High volatility may indicate fluctuating demand, while low volatility suggests stability.")
      ),

      # Market Trends Summary Tab
      tabItem(tabName = "trends",
              h2("Market Trends Summary"),
              sliderInput("year_range", "Select Year Range:",
                          min = min(property_data$year), max = max(property_data$year),
                          value = c(min(property_data$year), max(property_data$year)),
                          sep = "", step = 1),  # Set step to 1 for whole numbers
              plotOutput("trendsPlot"),
              tableOutput("trendsTable"),
              br(),
              p("This summary provides yearly statistics including average median price, average growth rate, and locality count, showing the overall trends in Melbourne’s property market over the selected years.")
      )
    )
  )
)

# Define Server

server <- function(input, output, session) {
  # Ensure year column is numeric
  property_data$year <- as.numeric(property_data$year)

  # Annual Price Growth for a Locality
  growth_data <- reactive({
    annual_price_growth(property_data, input$locality_growth)
  })

  output$growthPlot <- renderPlot({
    ggplot(growth_data(), aes(x = year, y = annual_growth_rate)) +
      geom_line(color = "blue", size = 1) +
      geom_point(color = "blue") +
      labs(title = paste("Annual Growth Rate for", input$locality_growth),
           x = "Year", y = "Growth Rate (%)") +
      theme_minimal()
  })

  output$growthTable <- renderTable({
    growth_data() %>%
      select(year, median_price, annual_growth_rate) %>%
      rename(Year = year, `Median Price (AUD)` = median_price, `Annual Growth Rate (%)` = annual_growth_rate)
  })

  # Top-Performing Suburbs by Average Annual Growth
  top_suburbs <- eventReactive(input$generate, {
    start_year <- as.numeric(input$start_year)
    end_year <- as.numeric(input$end_year)
    top_n <- as.numeric(input$top_n)

    # Handle invalid inputs
    if (is.na(start_year) || is.na(end_year) || is.na(top_n)) {
      return(data.frame(Error = "Please enter valid numeric values."))
    }

    # Calculate top-performing suburbs
    top_performing_suburbs(property_data, start_year, end_year, top_n)
  })

  output$topSuburbsTable <- renderTable({
    data <- top_suburbs()
    if (nrow(data) == 0) {
      return(data.frame(Message = "No data available for the selected period."))
    }
    data
  })

  # Price Volatility for a Locality
  volatility <- reactive({
    price_volatility(property_data, input$locality_volatility)
  })

  output$volatilityOutput <- renderPrint({
    volatility()
  })

  # Market Trends Summary with Year Range Filter
  trends_data <- reactive({
    full_trends_data <- market_trends_by_year(property_data)
    full_trends_data %>%
      filter(year >= input$year_range[1], year <= input$year_range[2])
  })

  output$trendsPlot <- renderPlot({
    ggplot(trends_data(), aes(x = year)) +
      geom_line(aes(y = avg_median_price), color = "darkgreen", size = 1) +
      geom_line(aes(y = avg_growth_rate * 10000), color = "blue", size = 1, linetype = "dashed") +  # Scaled for visualization
      labs(title = "Market Trends by Year",
           x = "Year", y = "Avg Median Price (AUD)",
           caption = "Note: Growth rate scaled for visualization") +
      scale_y_continuous(sec.axis = sec_axis(~./10000, name = "Avg Growth Rate (%)")) +
      theme_minimal()
  })

  output$trendsTable <- renderTable({
    trends_data() %>%
      select(year, avg_median_price, avg_growth_rate, locality_count) %>%
      rename(Year = year, `Average Median Price (AUD)` = avg_median_price,
             `Average Growth Rate (%)` = avg_growth_rate, `Locality Count` = locality_count)
  })
}


# Run the application
shinyApp(ui = ui, server = server)
