# Define UI
ui <- fluidPage(
  uiOutput("leaflet_output"),
  
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
                          "YIC"))
  
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
  
  # Define E1_Map leaflet output
  output$E1_Geo <- renderLeaflet({
    E1_Map <- leaflet()
    
    E1_Map <- E1_Map %>%
      addProviderTiles("CartoDB.Positron")
    
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
  
  # Define E2_Map leaflet output
  output$E2_Geo <- renderLeaflet({
    E2_Map <- leaflet()
    
    E2_Map <- E2_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    E2_Map <- E2_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    E2_Map <- E2_Map %>%
      addPolygons(
        data = E2_Geo,
        color = "#33a02c",
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
    
    #### Adding provider HQ circle markers
    
    E2_Map <- E2_Map %>%
      addCircleMarkers(
        data = E2_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#33a02c",
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
  
  # Define EM1_Map leaflet output
  output$EM1_Geo <- renderLeaflet({
    EM1_Map <- leaflet()
    
    EM1_Map <- EM1_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    EM1_Map <- EM1_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    EM1_Map <- EM1_Map %>%
      addPolygons(
        data = EM1_Geo,
        color = "#34baeb",
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
    
    #### Adding provider HQ circle markers
    
    EM1_Map <- EM1_Map %>%
      addCircleMarkers(
        data = EM1_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#34baeb",
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
  
  # Define HNY_Map leaflet output
  output$HNY_Geo <- renderLeaflet({
    HNY_Map <- leaflet()
    
    HNY_Map <- HNY_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    HNY_Map <- HNY_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    HNY_Map <- HNY_Map %>%
      addPolygons(
        data = HNY_Geo,
        color = "#cab2d6",
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
    
    #### Adding provider HQ circle markers
    
    HNY_Map <- HNY_Map %>%
      addCircleMarkers(
        data = HNY_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#cab2d6",
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
  
  # Define NEL1_Geo leaflet output
  output$NEL1_Geo <- renderLeaflet({
    NEL1_Map <- leaflet()
    
    NEL1_Map <- NEL1_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    NEL1_Map <- NEL1_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    NEL1_Map <- NEL1_Map %>%
      addPolygons(
        data = NEL1_Geo,
        color = "#ff7f00",
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
    
    #### Adding provider HQ circle markers
    
    NEL1_Map <- NEL1_Map %>%
      addCircleMarkers(
        data = NEL1_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#ff7f00",
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
  
  # Define NENC_Geo leaflet output
  output$NENC_Geo <- renderLeaflet({
    NENC_Map <- leaflet()
    
    NENC_Map <- NENC_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    NENC_Map <- NENC_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    NENC_Map <- NENC_Map %>%
      addPolygons(
        data = NENC_Geo,
        color = "#fdbf6f",
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
    
    #### Adding provider HQ circle markers
    
    NENC_Map <- NENC_Map %>%
      addCircleMarkers(
        data = NENC_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#fdbf6f",
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
  
  # Define NWGM_Geo leaflet output
  output$NWGM_Geo <- renderLeaflet({
    NWGM_Map <- leaflet()
    
    NWGM_Map <- NWGM_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    NWGM_Map <- NWGM_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    NWGM_Map <- NWGM_Map %>%
      addPolygons(
        data = NWGM_Geo,
        color = "#b2df8a",
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
    
    #### Adding provider HQ circle markers
    
    NWGM_Map <- NWGM_Map %>%
      addCircleMarkers(
        data = NWGM_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#b2df8a",
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
  
  # Define NWL1_Geo leaflet output
  output$NWL1_Geo <- renderLeaflet({
    NWL1_Map <- leaflet()
    
    NWL1_Map <- NWL1_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    NWL1_Map <- NWL1_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    NWL1_Map <- NWL1_Map %>%
      addPolygons(
        data = NWL1_Geo,
        color = "#6a3d9a",
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
    
    #### Adding provider HQ circle markers
    
    NWL1_Map <- NWL1_Map %>%
      addCircleMarkers(
        data = NWL1_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#6a3d9a",
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
  
  # Define SE2_Geo leaflet output
  output$SE2_Geo <- renderLeaflet({
    SE2_Map <- leaflet()
    
    SE2_Map <- SE2_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    SE2_Map <- SE2_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    SE2_Map <- SE2_Map %>%
      addPolygons(
        data = SE2_Geo,
        color = "#c51b7d",
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
    
    #### Adding provider HQ circle markers
    
    SE2_Map <- SE2_Map %>%
      addCircleMarkers(
        data = SE2_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#c51b7d",
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
  
  # Define SW1_Geo leaflet output
  output$SW1_Geo <- renderLeaflet({
    SW1_Map <- leaflet()
    
    SW1_Map <- SW1_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    SW1_Map <- SW1_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    SW1_Map <- SW1_Map %>%
      addPolygons(
        data = SW1_Geo,
        color = "#fb9a99",
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
    
    #### Adding provider HQ circle markers
    
    SW1_Map <- SW1_Map %>%
      addCircleMarkers(
        data = SW1_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#fb9a99",
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
  
  # Define YIC_Geo leaflet output
  output$YIC_Geo <- renderLeaflet({
    YIC_Map <- leaflet()
    
    YIC_Map <- YIC_Map %>%
      addProviderTiles("CartoDB.Positron")
    
    YIC_Map <- YIC_Map %>%
      addTiles(urlTemplate = "") %>%
      htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")
    
    #### Adding provider boundary polygons
    YIC_Map <- YIC_Map %>%
      addPolygons(
        data = YIC_Geo,
        color = "#3458eb",
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
    
    #### Adding provider HQ circle markers
    
    YIC_Map <- YIC_Map %>%
      addCircleMarkers(
        data = YIC_Geo,
        lng = ~Longitude_1m,
        lat = ~Latitude_1m,
        color = "#3458eb",
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
  
}

shinyApp(ui = ui, server = server)