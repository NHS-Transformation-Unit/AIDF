# Load geojson files ------------------------------------------------------

OHID_msoa_path <- (paste0(here(),"/data/Geospatial/MSOA Shapefile/FPTP_AllAd22_Gen.shp"))
OHID_msoa_shp <- st_read(OHID_msoa_path)

OHID_msoa_shp <- st_transform(OHID_msoa_shp, 4326)