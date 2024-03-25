
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
