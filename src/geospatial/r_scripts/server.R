# Server script for R Shiny app.

library(shiny)
library(leaflet)

shinyServer(function(input, output) {
  # Load your data here (replace `YOUR_DATA.csv` with your actual data file)
  AIDF_Geo_Final <- read.csv("YOUR_DATA.csv")
  
  # Reactive expression to filter data based on selected date range
  filtered_data <- reactive({
    subset(AIDF_Geo_Final, Implementation_End_Date >= input$date_range[1] & Implementation_End_Date <= input$date_range[2])
  })
  
  # Render the leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(data = filtered_data(),
                       ~Longitude_1m, ~Latitude_1m,
                       popup = ~paste(
                         "Trust: ", Trust, "<br>",
                         "Network Name: ", `Network Name 1`, "<br>",
                         "Region: ", Region, "<br>",
                         "Modality: ", Modality, "<br>",
                         "Body Part: ", `Body_Part`, "<br>",
                         "Implementation End Date: ", Implementation_End_Date
                       ))
  })
})