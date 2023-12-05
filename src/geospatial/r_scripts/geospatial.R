# AIDF Map ---------------------------------------------------------

## Create a color palette or choose one from RColorBrewer
color_palette <- colorFactor(
  palette = "Set2",  # You can choose a different palette
  domain = AIDF_Geo_Final$`Network Name 1`
)

## Create a leaflet map
AIDF_Map <- leaflet() %>%
  addTiles()  # Add default map tiles

## Add layers for each geojson file
AIDF_Map <- AIDF_Map %>%
  addPolygons(
    data = geojson_icb,
    fillColor = "green",
    fillOpacity = 0.4,
    color = "white",
    weight = 1,
    group = "ICB"  # Group for layer control
  ) %>%
  addPolygons(
    data = geojson_regions,
    fillColor = "lightblue",
    fillOpacity = 0.4,
    color = "white",
    weight = 1,
    group = "Regions"  # Group for layer control
  )

## Add layer control
AIDF_Map <- AIDF_Map %>%
  addLayersControl(
    overlayGroups = c("ICB", "Regions"),  # Groups defined above
    options = layersControlOptions(collapsed = FALSE)
  )

## Plot NHS Trust sites
AIDF_Map <- AIDF_Map %>%
  addCircleMarkers(
    data = AIDF_Geo_Final,
    lat = ~Latitude_1m,
    lng = ~Longitude_1m,
    radius = 5,  # Adjust the radius as needed
    color = ~color_palette(`Network Name 1`), # Color based on Imaging Network 1
    fillOpacity = 0.8,
    popup = ~paste(
      "Trust: ", Trust, "<br>",
      "Network Name: ", `Network Name 1`, "<br>",
      "Region: ", Region, "<br>",
      "Modality: ", Modality, "<br>",
      "Body Part: ", `Body_Part`, "<br>",
      "Implementation End Date: ", `Net_Implementation_End`),
    group = "Network Name 1",  # Group for layer control
    options = popupOptions(zIndex = 1000)
  )

## Print the map
print(AIDF_Map)