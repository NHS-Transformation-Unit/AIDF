# Define UI
ui <- fluidPage(
  selectInput("map_select", "Select Imaging Network:",
              choices = c("Norfolk, Suffolk & North Essex", 
                          "Herts West Essex, Bedford Luton and Mid and South Essex systems", 
                          "EMRAD", 
                          "Hull and North Yorkshire", 
                          "North East London",
                          "North East and North Cumbria", 
                          "Cheshire and Mersey Radiology Imaging Network", 
                          "Greater Manchester", 
                          "North West London", 
                          "Surrey, Sussex and Frimley Imaging Network",
                          "PENRAD",
                          "YIC")),
  
  # Placeholder for leaflet output
  uiOutput("leaflet_output")
)

# Define server logic
server <- function(input, output, session) {
  # Generate leaflet output based on selection
  output$leaflet_output <- renderUI({
    selected_map <- switch(input$map_select,
                           "Norfolk, Suffolk & North Essex" = "E1_Geo",
                           "Herts West Essex, Bedford Luton and Mid and South Essex systems" = "E2_Geo",
                           "EMRAD" = "EM1_Geo",
                           "Hull and North Yorkshire" = "HNY_Geo",
                           "North East London" = "NEL1_Geo",
                           "North East and North Cumbria" = "NENC_Geo",
                           "Cheshire and Mersey Radiology Imaging Network" = "NWCM_Geo",
                           "Greater Manchester" = "NWGM_Geo",
                           "North West London" = "NWL1_Geo",
                           "Surrey, Sussex and Frimley Imaging Network" = "SE2_Geo",
                           "PENRAD" = "SW1_Geo",
                           "YIC" = "YIC_Geo"
    )
    leafletOutput(selected_map)
  })
  
  # Define leaflet maps
  output$E1_Geo <- renderLeaflet({
    E1_Map <- leaflet()
    
    # Add provider boundary polygons
    E1_Map <- E1_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
        function(el, x) {
          el.style.backgroundColor = 'white';
        }
      ") %>%
      addPolygons(
        data = E1_Geo,
        color = "#e31a1c",
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
      addCircleMarkers(
        data = E1_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#e31a1c",
        radius = 5,
        group = "NHS Trust Locations",
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
  
  # Define other leaflet maps in a similar way
  
}

shinyApp(ui = ui, server = server)