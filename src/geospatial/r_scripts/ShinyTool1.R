# Define UI
ui <- fluidPage(
  tags$style(HTML(".irs-from {display: none;}")),  # Hide label for minimum value
  leafletOutput("map", height = "600px"),  # Set the height here, for example, to 600 pixels
  sliderInput("date_range", "Select Implementation End Date Range:",
              min = min(OHID_shp_dates$Net_Implementation_End),
              max = max(OHID_shp_dates$Net_Implementation_End),
              value = c(min(OHID_shp_dates$Net_Implementation_End), max(OHID_shp_dates$Net_Implementation_End)),
              step = 1,
              animate = TRUE,
              timeFormat = "%Y-%m-%d")  # Set disable to TRUE for the minimum value
)

# Add JavaScript to disable the minimum value
ui <- tagAppendChild(ui, tags$script("
  $(document).on('shiny:value', function(event) {
    // Disable the handle corresponding to the minimum value
    $('.irs-slider.single').eq(0).prop('disabled', true);
  });
"))

# Define server logic
server <- function(input, output) {
  # Define color palette
  color_palette <- colorFactor(
    palette = c("#b15928", "#34baeb", "#b2df8a", "#33a02c", "#cab2d6", "#e31a1c", "#fdbf6f", "#ff7f00", "#6a3d9a", "#fb9a99", "#c51b7d", "#3458eb"),
    domain = OHID_shp_dates$`Network Name 1`
  )
  
  # Reactive expression to filter data based on selected date range
  filtered_data <- reactive({
    # Filter data based on selected date range
    OHID_shp_dates_filtered <- subset(OHID_shp_dates, 
                                      Net_Implementation_End >= input$date_range[1] & 
                                        Net_Implementation_End <= input$date_range[2])
    OHID_shp_dates_filtered
  })
  
  # Creating the base leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
        function(el, x) {
          el.style.backgroundColor = 'white';
        }
      ") %>%
      addPolygons(
        data = OHID_merge,
        fillColor = "lightgrey",
        fillOpacity = 0.05,
        color = "rgba(46, 139, 87, 0.5)",
        weight = 1.25,
        stroke = TRUE,
        group = "NL Providers"
      ) %>%
      addLayersControl(
        overlayGroups = c("NL Providers"),
        options = layersControlOptions(collapsed = FALSE)
      ) %>%
      addPolygons(
        data = filtered_data(),
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
        overlayGroups = c("Live Providers"),
        options = layersControlOptions(collapsed = FALSE)
      )
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)