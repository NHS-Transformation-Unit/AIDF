# Modality Mapping Outputs

## Map visualising all modalities

### Filtering OHID_Merge df to visualise each specific modality

OHID_XRay <- OHID_merge %>%
  filter(Modality == "X-ray")

OHID_CT <- OHID_merge %>%
  filter(Modality == "CT Scan")

OHID_Both <- OHID_merge %>%
  filter(Modality == "CT Scan and X-Ray")

### Creating the base leaflet map

AIDF_Map_2 <- leaflet()

AIDF_Map_2 <- AIDF_Map_2 %>%
  addTiles(urlTemplate = "") %>%
  htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")

### Adding non-live provider layers as a background layer

AIDF_Map_2 <- AIDF_Map_2 %>%
  addPolygons(
    data = OHID_merge,
    fillColor = "lightgrey",
    fillOpacity = 0.05,
    color = "rgba(46, 139, 87, 0.5)",
    weight = 1.25,
    stroke = TRUE,
    group = "NL Providers")

### Adding a layer for providers utilising X-Ray

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

### Adding a layer for providers utilising CT Scans

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
      "Body Part: ", `Body_Part`, "<br>",
      "Implementation End Date: ", `Net_Implementation_End`
    )
  )

### Adding a layer for providers utilising both X-Ray and CT Scans

AIDF_Map_2 <- AIDF_Map_2 %>%
  addPolygons(
    data = OHID_Both,
    color = "orange",
    opacity = 0.8,
    weight = 1.25,
    stroke = TRUE,
    group = "CT Scan and X-Ray",
    popup = ~paste(
      "Trust: ", Trust, "<br>",
      "Network Name: ", `Network Name 1`, "<br>",
      "Region: ", Region, "<br>",
      "Body Part: ", `Body_Part`, "<br>",
      "Implementation End Date: ", `Net_Implementation_End`
    )
  )

### Adding layer control
AIDF_Map_2 <- AIDF_Map_2 %>%
  addLayersControl(
    overlayGroups = c("X-Ray", "CT Scan", "CT Scan and X-Ray"),
    options = layersControlOptions(collapsed = FALSE))

## Map visualising X-ray only

### Filtering OHID_Merge df to visualise only X-Rays

OHID_XRay_Map <- OHID_merge %>%
  filter(X_Ray == "Yes")

### Creating the base leaflet map

AIDF_Map_3 <- leaflet()

AIDF_Map_3 <- AIDF_Map_3 %>%
  addTiles(urlTemplate = "") %>%
  htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")

### Adding non-live provider layers as a background layer

AIDF_Map_3 <- AIDF_Map_3 %>%
  addPolygons(
    data = OHID_merge,
    fillColor = "lightgrey",
    fillOpacity = 0.05,
    color = "rgba(46, 139, 87, 0.5)",
    weight = 1.25,
    stroke = TRUE,
    group = "NL Providers")

### Adding a layer for providers utilising X-Ray

AIDF_Map_3 <- AIDF_Map_3 %>%
  addPolygons(
    data = OHID_XRay_Map,
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

## Map visualising CT Scans only

### Filtering OHID_Merge df to visualise only CT scans

OHID_CT_Map <- OHID_merge %>%
  filter(CT_Scan == "Yes")

### Creating the base leaflet map

AIDF_Map_4 <- leaflet()

AIDF_Map_4 <- AIDF_Map_4 %>%
  addTiles(urlTemplate = "") %>%
  htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")

### Adding non-live provider layers as a background layer

AIDF_Map_4 <- AIDF_Map_4 %>%
  addPolygons(
    data = OHID_merge,
    fillColor = "lightgrey",
    fillOpacity = 0.05,
    color = "rgba(46, 139, 87, 0.5)",
    weight = 1.25,
    stroke = TRUE,
    group = "NL Providers")

### Adding a layer for providers utilising X-Ray

AIDF_Map_4 <- AIDF_Map_4 %>%
  addPolygons(
    data = OHID_CT_Map,
    color = "blue",
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