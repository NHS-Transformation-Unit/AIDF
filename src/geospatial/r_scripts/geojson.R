
# Source config urls ------------------------------------------------------
source("../../src/geospatial/r_scripts/geojson_urls.R")


# Load geojson files ------------------------------------------------------

geojson_lsoa <- st_read(geojson_lsoa_url)
geojson_la <- st_read(geojson_la_url)
geojson_subicb <- st_read(geojson_subicb_url)
geojson_icb <- st_read(geojson_icb_url)
lsoa_lookup <- st_read(geojson_lsoa_lookup_url)