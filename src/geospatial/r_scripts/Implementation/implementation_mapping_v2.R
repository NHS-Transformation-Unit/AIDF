
# Implementation Mapping Outputs

# Load AIDF data
AIDF_Geo_Final <- read.csv(paste0(here(),"/data/processed SFBC/AIDF_Geo_Final.csv")) %>%
  rename("Network Name 1" = Network.Name.1,
         "Network Name 2" = Network.Name.2,
         "Org code" = Org.code)

# Load OHID lookup data
OHID_Lookup_Path <- (paste0(here(), "/data/geospatial/trust_msoa_lookup.xlsx"))
OHID_Lookup <- read_xlsx(OHID_Lookup_Path)

# Merge AIDF and OHID data
AIDF_Geo_Join <- left_join(OHID_Lookup, AIDF_Geo_Final, by = c("TrustCode" = "Org code"))

# Add status column
AIDF_Geo_LNl <- AIDF_Geo_Join %>%
  mutate(Status = ifelse(!is.na(SFBC_ID), "Live", "Not Live"))

# Merge final data with OHID shape file
OHID_merge <- left_join(OHID_msoa_shp, AIDF_Geo_LNl, by = c("TrustCd" = "TrustCode"))

# Filter shape files based on Status
OHID_shp_NL <- OHID_merge %>%
  filter(Status == "Not Live")

OHID_shp_L <- OHID_merge %>%
  filter(Status == "Live")

# Format date fields
OHID_shp_dates <- OHID_shp_L %>%
  mutate(Net_Implementation_Start = as.Date(Net_Implementation_Start, format = "%d/%m/%Y"),
         Net_Implementation_End = as.Date(Net_Implementation_End, format = "%d/%m/%Y"))

color_palette <- colorFactor(
  palette = c("#b15928", "#34baeb", "#262626", "#33a02c", "#cab2d6", "#e31a1c", "#fdbf6f", "#ff7f00", "#6a3d9a", "#fb9a99", "#c51b7d", "#3458eb"),
  domain = unique(OHID_shp_dates$`Network Name 1`)
)

# Create a SharedData object
OHID_shp_shared <- SharedData$new(OHID_shp_dates)

imp_slider <- filter_slider("implementation_end_filter", "Implementation End Date Range", OHID_shp_shared, ~Net_Implementation_End)

# Creating the base leaflet map
imp_mapping <- leaflet() %>%
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
    data = OHID_shp_shared,
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

imp_output <- tagList(imp_slider, imp_mapping)
