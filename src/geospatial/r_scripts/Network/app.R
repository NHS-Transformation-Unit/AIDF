
# Implementation Mapping Shiny application

## Shiny application user interface

ui <- fluidPage(
  uiOutput("leaflet_output"),
  
  selectInput("map_select", "Select Imaging Network:",
              choices = c("Norfolk, Suffolk & North Essex", 
                          "Herts West Essex, Bedford Luton and Mid and South Essex", 
                          "East Midlands (EMRAD)", 
                          "Hull and North Yorkshire", 
                          "North East London",
                          "North East and North Cumbria", 
                          "Cheshire and Mersey", 
                          "Greater Manchester", 
                          "North West London", 
                          "Surrey, Sussex and Frimley",
                          "South West (PENRAD)",
                          "Yorkshire Imaging Collaborative"))
  
)

### Shiny application server logic

server <- function(input, output, session) {
  
  ### Generate leaflet output based on selection
  
  output$leaflet_output <- renderUI({
    selected_map <- switch(input$map_select,
                           "Norfolk, Suffolk & North Essex" = "E1_Geo",
                           "Herts West Essex, Bedford Luton and Mid and South Essex" = "E2_Geo",
                           "East Midlands (EMRAD)" = "EM1_Geo",
                           "Hull and North Yorkshire" = "HNY_Geo",
                           "North East London" = "NEL1_Geo",
                           "North East and North Cumbria" = "NENC_Geo",
                           "Cheshire and Mersey" = "NWCM_Geo",
                           "Greater Manchester" = "NWGM_Geo",
                           "North West London" = "NWL1_Geo",
                           "Surrey, Sussex and Frimley" = "SE2_Geo",
                           "South West (PENRAD)" = "SW1_Geo",
                           "Yorkshire Imaging Collaborative" = "YIC_Geo"
    )
    leafletOutput(selected_map)
  })
  
  createLeafletMap <- function(data, color) {
    map <- leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
      function(el, x) {
        el.style.backgroundColor = 'white';
      }
    ") %>%
      addPolygons(
        data = data,
        color = color,
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
        data = data,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = color,
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
    
    return(map)
  }
  
  output$E1_Geo <- renderLeaflet({
    E1_Map <- createLeafletMap(data = E1_Geo, color = "#e31a1c")
  })
  
  output$E2_Geo <- renderLeaflet({
    E2_Map <- createLeafletMap(data = E2_Geo, color = "#33a02c")
  })
  
  output$EM1_Geo <- renderLeaflet({
    EM1_Map <- createLeafletMap(data = EM1_Geo, color = "#34baeb")
  })
  
  output$HNY_Geo <- renderLeaflet({
    HNY_Map <- createLeafletMap(data = HNY_Geo, color = "#cab2d6")
  })
  
  output$NEL1_Geo <- renderLeaflet({
    NEL1_Map <- createLeafletMap(data = NEL1_Geo, color = "#ff7f00")
  })
  
  output$NENC_Geo <- renderLeaflet({
    NENC_Map <- createLeafletMap(data = NENC_Geo, color = "#fdbf6f")
  })
  
  output$NWCM_Geo <- renderLeaflet({
    NWCM_Map <- createLeafletMap(data = NWCM_Geo, color = "#b15928")
  })
  
  output$NWGM_Geo <- renderLeaflet({
    NWGM_Map <- createLeafletMap(data = NWGM_Geo, color = "#262626")
  })
  
  output$NWL1_Geo <- renderLeaflet({
    NWL1_Map <- createLeafletMap(data = NWL1_Geo, color = "#6a3d9a")
  })
  
  output$SE2_Geo <- renderLeaflet({
    SE2_Map <- createLeafletMap(data = SE2_Geo, color = "#c51b7d")
  })
  
  output$SW1_Geo <- renderLeaflet({
    SW1_Map <- createLeafletMap(data = SW1_Geo, color = "#fb9a99")
  })
  
  output$YIC_Geo <- renderLeaflet({
    YIC_Map <- createLeafletMap(data = YIC_Geo, color = "#3458eb")
  })
  
}

## Running the completed application
shinyApp(ui = ui, server = server)

#htmlwidgets::saveWidget(ui, "../geospatial/r_scripts/network/network.html", selfcontained = TRUE)
