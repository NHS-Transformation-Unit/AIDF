# Server script for R Shiny app.

library(shiny)
library(leaflet)

shinyServer(function(input, output) {
  
  ## Creating the colour palette
  color_palette <- colorFactor(
    palette = c("#b15928", "#1f78b4", "#b2df8a", "#33a02c", "#cab2d6", "#e31a1c", "#fdbf6f", "#ff7f00", "#6a3d9a", "#fb9a99", "#c51b7d"),
    domain = AIDF_Geo_LNl$`Network Name 1`
  )
  
  ## Extracting unique values from Net_Implementation_End
  unique_dates <- unique(AIDF_Geo_LNl$Net_Implementation_End)
  
  ## Defining initial date index
  initial_date_index <- 1
  
  ## Creating the base leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      htmlwidgets::onRender("
        function(el, x) {
          el.style.backgroundColor = 'white';
        }
      ") %>%
      addPolygons(
        data = AIDF_Geo_LNl,
        color = ~color_palette(`Network Name 1`),
        opacity = 0.8,
        weight = 1.25,
        stroke = TRUE,
        group = "Live Providers",
        popup = ~paste(
          "Trust: ", Trust, "<br>",
          "Network Name: ", `Network Name 1`, "<br>",
          "Region: ", Region, "<br>",
          "Modality: ", Modality, "<br>",
          "Body Part: ", `Body_Part`, "<br>",
          "Implementation End Date: ", `Net_Implementation_End`
        )
      ) %>%
      addLayersControl(
        overlayGroups = c("Live Providers"),  # Groups defined above
        options = layersControlOptions(collapsed = FALSE)
      )
  })
  
  ## Slider input for date selection
  output$dateslider <- renderUI({
    sliderInput("date",
                "Implementation End Date:",
                min = 1, max = length(unique_dates), value = initial_date_index,
                step = 1)
  })
  
  ## Filter data based on selected date
  selected_date_data <- reactive({
    if (input$date > 0) {
      selected_date <- unique_dates[input$date]
      filtered_data <- AIDF_Geo_LNl[AIDF_Geo_LNl$Net_Implementation_End == selected_date, ]
      filtered_data
    } else {
      AIDF_Geo_LNl  # Return the original data if no date is selected
    }
  })
  
  ## Update map based on selected date
  observe({
    leafletProxy("map", data = selected_date_data()) %>%
      clearShapes() %>%
      addPolygons(
        color = ~color_palette(`Network Name 1`),
        opacity = 0.8,
        weight = 1.25,
        stroke = TRUE,
        group = "Live Providers",
        popup = ~paste(
          "Trust: ", Trust, "<br>",
          "Network Name: ", `Network Name 1`, "<br>",
          "Region: ", Region, "<br>",
          "Modality: ", Modality, "<br>",
          "Body Part: ", `Body_Part`, "<br>",
          "Implementation End Date: ", `Net_Implementation_End`
        )
      )
  })
})