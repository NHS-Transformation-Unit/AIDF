# AIDF Map 2 (X-Ray) ---------------------------------------------------------

## Merging the constituent data into one source

OHID_Lookup_Path <- (paste0(here(), "/data/Geospatial/trust_msoa_lookup.xlsx"))
OHID_Lookup <- read_xlsx(OHID_Lookup_Path)

AIDF_Geo_Join <- left_join(OHID_Lookup, AIDF_Geo_Final, by = c("TrustCode" = "Org code"))

AIDF_Geo_LNl <- AIDF_Geo_Join %>%
  mutate(Status = ifelse(!is.na(SFBC_ID), "Live", "Not Live"))

## Merging the final df and OHID shape file

OHID_merge <- left_join(OHID_msoa_shp, AIDF_Geo_LNl, by = c("TrustCd" = "TrustCode"))

# Filtering the shape files based on the value in `Status`

OHID_XRay <- OHID_merge %>%
  filter(Modality == "X-ray")

OHID_CT <- OHID_merge %>%
  filter(Modality == "CT Scan")

## Creating the colour palette
color_palette <- colorFactor(
  palette = c("#b15928", "#1f78b4", "#b2df8a", "#33a02c", "#cab2d6", "#e31a1c", "#fdbf6f", "#ff7f00", "#6a3d9a", "#fb9a99", "#c51b7d"),
  domain = AIDF_Geo_LNl$`Network Name 1`)

## Creating the base leaflet map

AIDF_Map_2 <- leaflet()

AIDF_Map_2 <- AIDF_Map_2 %>%
  addTiles(urlTemplate = "") %>%
  htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")

## Adding non-live provider layers for the NHS region geojson file
AIDF_Map_2 <- AIDF_Map_2 %>%
  addPolygons(
    data = OHID_merge,
    fillColor = "lightgrey",
    fillOpacity = 0.05,
    color = "rgba(46, 139, 87, 0.5)",
    weight = 1.25,
    stroke = TRUE,
    group = "NL Providers")

## Adding live provider layers for the NHS region geojson file
AIDF_Map_2 <- AIDF_Map_2 %>%
  addPolygons(
    data = OHID_XRay,
    color = "red",
    opacity = 0.8,
    weight = 1.25,
    stroke = TRUE,
    group = "X-Ray",
    popup = ~paste(
      "Trust: ", Trust, "<br>",
      "Network Name: ", `Network Name 1`, "<br>",
      "Region: ", Region, "<br>",
      "Modality: ", Modality, "<br>",
      "Body Part: ", `Body_Part`, "<br>",
      "Implementation End Date: ", `Net_Implementation_End`
    )
  )

## Adding live provider layers for the NHS region geojson file
AIDF_Map_2 <- AIDF_Map_2 %>%
  addPolygons(
    data = OHID_CT,
    color = "blue",
    opacity = 0.8,
    weight = 1.25,
    stroke = TRUE,
    group = "CT Scan",
    popup = ~paste(
      "Trust: ", Trust, "<br>",
      "Network Name: ", `Network Name 1`, "<br>",
      "Region: ", Region, "<br>",
      "Modality: ", Modality, "<br>",
      "Body Part: ", `Body_Part`, "<br>",
      "Implementation End Date: ", `Net_Implementation_End`
    )
  )

## Adding layer control
AIDF_Map_2 <- AIDF_Map_2 %>%
  addLayersControl(
    overlayGroups = c("X-Ray", "CT Scan"),  # Groups defined above
    options = layersControlOptions(collapsed = FALSE))

## Testing the map
print(AIDF_Map_2)