
# Filtering network shapefile inputs

E1_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "Norfolk, Suffolk & North Essex")

E2_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "Herts West Essex, Bedford Luton and Mid and South Essex systems")

EM1_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "EMRAD")

HNY_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "Hull and North Yorkshire")

NEL1_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "North East London")

NENC_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "North East and North Cumbria")

NWCM_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "Cheshire and Mersey Radiology Imaging Network")

NWGM_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "Greater Manchester")

NWL1_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "North West London")

SE2_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "Surrey, Sussex and Frimley Imaging Network")

SW1_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "PENRAD")

YIC_Geo <- OHID_shp_dates %>%
  filter(`Network Name 1` == "YIC")

# Network Mapping outputs

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

E1_Map <- createLeafletMap(data = E1_Geo, color = "#e31a1c")
E2_Map <- createLeafletMap(data = E2_Geo, color = "#33a02c")
EM1_Map <- createLeafletMap(data = EM1_Geo, color = "#34baeb")
HNY_Map <- createLeafletMap(data = HNY_Geo, color = "#cab2d6")
NEL1_Map <- createLeafletMap(data = NEL1_Geo, color = "#ff7f00")
NENC_Map <- createLeafletMap(data = NENC_Geo, color = "#fdbf6f")
NWCM_Map <- createLeafletMap(data = NWCM_Geo, color = "#b15928")
NWGM_Map <- createLeafletMap(data = NWGM_Geo, color = "#262626")
NWL1_Map <- createLeafletMap(data = NWL1_Geo, color = "#6a3d9a")
SE2_Map <- createLeafletMap(data = SE2_Geo, color = "#c51b7d")
SW1_Map <- createLeafletMap(data = SW1_Geo, color = "#fb9a99")
YIC_Map <- createLeafletMap(data = YIC_Geo, color = "#3458eb")
