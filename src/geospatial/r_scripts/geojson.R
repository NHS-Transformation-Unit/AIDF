# Source config urls ------------------------------------------------------
source("../../src/geospatial/r_scripts/geojson_urls.R")


# Load geojson files ------------------------------------------------------

geojson_la <- st_read(geojson_la_url)
geojson_icb <- st_read(geojson_icb_url)
geojson_regions <- st_read(geojson_region)