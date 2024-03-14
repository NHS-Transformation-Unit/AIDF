## Creating the colour palette
color_palette <- colorFactor(
  palette = c("#b15928", "#34baeb", "#b2df8a", "#33a02c", "#cab2d6", "#e31a1c", "#fdbf6f", "#ff7f00", "#6a3d9a", "#fb9a99", "#c51b7d", "#3458eb"),
  domain = OHID_shp_dates$`Network Name 1`)

## Creating separate shape file inputs for the different network maps

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

## Creating the different network leaflet outputs

### Norfolk, Suffolk & North Essex

#### Creating the base leaflet map

E1_Map <- leaflet()

E1_Map <- E1_Map %>%
  addTiles(urlTemplate = "") %>%
  htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")

#### Adding provider boundary polygons
E1_Map <- E1_Map %>%
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
  )

#### Adding provider HQ circle markers

E1_Map <- E1_Map %>%
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

### Herts West Essex, Bedford Luton and Mid and South Essex systems

#### Creating the base leaflet map

E2_Map <- leaflet()

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

### EMRAD
#### Creating the base leaflet map

EM1_Map <- leaflet()

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

### Hull and North Yorkshire
#### Creating the base leaflet map

HNY_Map <- leaflet()

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

### North East London
#### Creating the base leaflet map

NEL1_Map <- leaflet()

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

### North East and North Cumbria
#### Creating the base leaflet map

NENC_Map <- leaflet()

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

### Cheshire and Mersey Radiology Imaging Network
#### Creating the base leaflet map

NWCM_Map <- leaflet()

NWCM_Map <- NWCM_Map %>%
  addTiles(urlTemplate = "") %>%
  htmlwidgets::onRender("
    function(el, x) {
      el.style.backgroundColor = 'white';
    }
  ")

#### Adding provider boundary polygons
NWCM_Map <- NWCM_Map %>%
  addPolygons(
    data = NWCM_Geo,
    color = "#b15928",
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

NWCM_Map <- NWCM_Map %>%
  addCircleMarkers(
    data = NWCM_Geo,
    lng = ~Longitude_1m,
    lat = ~Latitude_1m,
    color = "#b15928",
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

### Greater Manchester

#### Creating the base leaflet map

NWGM_Map <- leaflet()

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

### North West London

#### Creating the base leaflet map

NWL1_Map <- leaflet()

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

### Surrey, Sussex and Frimley Imaging Network

#### Creating the base leaflet map

SE2_Map <- leaflet()

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

### PENRAD

#### Creating the base leaflet map

SW1_Map <- leaflet()

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

### YIC

#### Creating the base leaflet map

YIC_Map <- leaflet()

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