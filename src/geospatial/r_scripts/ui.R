# User Interface for R Shiny app.

library(shiny)

shinyUI(fluidPage(
  titlePanel("Interactive Leaflet Map"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", "Select Date Range:",
                     start = min(AIDF_Geo_LNl$Net_Implementation_End),
                     end = max(AIDF_Geo_LNl$Net_Implementation_End),
                     min = min(AIDF_Geo_LNl$Net_Implementation_End),
                     max = max(AIDF_Geo_LNl$Net_Implementation_End)),
      hr(),
      p("This mapping tool allows you to filter AIDF provider data based on Implementation End Date."),
      p("Adjust the date range using the slider to update the map."),
      p("The AIDF Provider map will be displayed below.")
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
))