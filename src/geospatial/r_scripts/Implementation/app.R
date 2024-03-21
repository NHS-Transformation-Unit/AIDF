# Implementation Mapping Shiny application

## Designing the user interface of the implementation mapping Shiny application

ui <- fluidPage(
  tags$style(HTML(".irs-from {display: none;}")),
  leafletOutput("map", height = "650px"),  
  sliderInput("date_range", "Select Implementation End Date Range:",
              min = as.Date("2023-11-30"),
              max = max(OHID_shp_dates$Net_Implementation_End),
              value = max(OHID_shp_dates$Net_Implementation_End),
              step = 1,
              animate = animationOptions(interval = 150),
              width = "775px",
              timeFormat = "%Y-%m-%d"),
  
  tags$script("
    $(document).on('shiny:value', function(event) {
      // Disable the handle corresponding to the minimum value
      $('.irs-slider.single').eq(0).prop('disabled', true);
    });
  ")
)

## Defining server logic
server <- function(input, output) {
  color_palette <- colorFactor(
    palette = c("#b15928", "#34baeb", "#262626", "#33a02c", "#cab2d6", "#e31a1c", "#fdbf6f", "#ff7f00", "#6a3d9a", "#fb9a99", "#c51b7d", "#3458eb"),
    domain = OHID_shp_dates$`Network Name 1`
  )
  
  ### Reactive expression to filter data based on selected date range
  filtered_data <- reactive({
    print(input$date_range)
    
    OHID_shp_dates_filtered <- subset(OHID_shp_dates, 
                                      Net_Implementation_End >= as.Date("2023-11-30") & 
                                        Net_Implementation_End <= input$date_range[1])
    
    print(OHID_shp_dates_filtered)
    
    OHID_shp_dates_filtered
  })
  
  ### Creating the base leaflet map
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

## Running the completed application
shinyApp(ui = ui, server = server)