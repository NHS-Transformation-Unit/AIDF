install.packages("here")
install.packages("sf")

library(here)
library(sf)

shp_path <- (paste0(here(),"/data/Geospatial/MSOA Shapefile/FPTP_AllAd22_Gen.shp"))
OHID_msoa_shp <- st_read(OHID_msoa_shp)

geojson_path <- (paste0(here(),"/data/Geospatial/OHID_MSOA.geojson"))
st_write(OHID_msoa_shp, geojson_path, driver = "GeoJSON")