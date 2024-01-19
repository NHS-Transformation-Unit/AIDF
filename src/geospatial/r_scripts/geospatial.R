# AIDF Map ---------------------------------------------------------

install.packages("leaflet")
install.packages("readxl")
install.packages("dplyr")
library(leaflet)
library(readxl)
library(dplyr)

## Merging the shapefile and colour data into one source

OHID_Lookup_Path <- (paste0(here(),"/data/Geospatial/trust_msoa_lookup.xlsx"))
OHID_Lookup <- read_xlsx(OHID_Lookup_Path)

AIDF_Geo_Join <- left_join(OHID_Lookup, AIDF_Geo_Final, by = c("TrustCode" = "Org code"))

## Creating the colour palette
color_palette <- colorFactor(
  palette = c("#b15928", "#1f78b4", "#b2df8a", "#33a02c", "#cab2d6", "#e31a1c", "#fdbf6f", "#ff7f00", "#6a3d9a", "#fb9a99", "#c51b7d"),
  domain = AIDF_Geo_Final$`Network Name 1`)

## Creating the base leaflet map
AIDF_Map <- leaflet() %>%
  addProviderTiles("CartoDB.Positron")

## Adding layers for the NHS region geojson file
AIDF_Map <- AIDF_Map %>%
   addPolygons(
    data = OHID_msoa_shp,
    fillColor = "lightblue",
    fillOpacity = 0.25,
    color = "rgba(46, 139, 87, 0.5)",
    weight = 1.25,
    stroke = TRUE,
    group = "Providers")

## Adding layer control
AIDF_Map <- AIDF_Map %>%
  addLayersControl(
    overlayGroups = c("Providers"),  # Groups defined above
    options = layersControlOptions(collapsed = FALSE))

## Plotting NHS Trust sites
AIDF_Map <- AIDF_Map %>%
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
      "Implementation End Date: ", `Net_Implementation_End`
    ),
    group = "Network Name 1",
    options = popupOptions(zIndex = 1000))

## Testing the map
print(AIDF_Map)