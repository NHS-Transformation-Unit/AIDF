# AIDF Map 3 (Old) ---------------------------------------------------------

color_palette <- colorFactor(
  palette = c("#b15928", "#1f78b4", "#b2df8a", "#33a02c", "#cab2d6", "#e31a1c", "#fdbf6f", "#ff7f00", "#6a3d9a", "#fb9a99", "#c51b7d"),
  domain = AIDF_Geo_Final$`Network Name 1`)

## Creating the base leaflet map
AIDF_Map_Old <- leaflet() %>%
  addProviderTiles("Stadia.AlidadeSmooth")

## Adding layers for the NHS region geojson file
AIDF_Map_Old <- AIDF_Map_Old %>%
  addPolygons(
    data = geojson_regions,
    fillColor = "lightblue",
    fillOpacity = 0,
    color = "rgba(46, 139, 87, 0.5)",
    weight = 1.25,
    stroke = TRUE,
    group = "Regions")

## Adding layer control
AIDF_Map_Old <- AIDF_Map_Old %>%
  addLayersControl(
    overlayGroups = c("Regions"),  # Groups defined above
    options = layersControlOptions(collapsed = FALSE))

## Plotting NHS Trust sites
AIDF_Map_Old <- AIDF_Map_Old %>%
  addCircleMarkers(
    data = AIDF_Geo_Final,
    lat = ~Latitude_1m,
    lng = ~Longitude_1m,
    radius = 5,
    color = ~color_palette(`Network Name 1`),
    fillOpacity = 0.8,
    popup = ~paste(
      "Trust: ", Trust, "<br>",
      "Network Name: ", `Network Name 1`, "<br>",
      "Region: ", Region, "<br>",
      "Modality: ", Modality, "<br>",
      "Body Part: ", `Body_Part`, "<br>",
      "Implementation End Date: ", `Net_Implementation_End`),
    group = "Network Name 1",
    options = popupOptions(zIndex = 1000))

## Testing the map
print(AIDF_Map_Old)