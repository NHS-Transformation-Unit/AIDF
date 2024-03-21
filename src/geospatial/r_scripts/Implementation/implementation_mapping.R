# Implementation Mapping Outputs

## Loading processed AIDF short form business case data

AIDF_Geo_Final <- read.csv(paste0(here(),"/data/Processed SFBC/AIDF_Geo_Final.csv"))

AIDF_Geo_Final <- AIDF_Geo_Final %>%
  rename("Network Name 1" = Network.Name.1,
         "Network Name 2" = Network.Name.2,
         "Org code" = Org.code,
         )

## Merging the constituent data into one source

OHID_Lookup_Path <- (paste0(here(), "/data/Geospatial/trust_msoa_lookup.xlsx"))
OHID_Lookup <- read_xlsx(OHID_Lookup_Path)

AIDF_Geo_Join <- left_join(OHID_Lookup, AIDF_Geo_Final, by = c("TrustCode" = "Org code"))

AIDF_Geo_LNl <- AIDF_Geo_Join %>%
  mutate(Status = ifelse(!is.na(SFBC_ID), "Live", "Not Live"))

## Merging the final AIFG_Geo df and OHID shape file

OHID_merge <- left_join(OHID_msoa_shp, AIDF_Geo_LNl, by = c("TrustCd" = "TrustCode"))

## Filtering the shape files based on the value in `Status`

OHID_shp_NL <- OHID_merge %>%
  filter(Status == "Not Live")

OHID_shp_L <- OHID_merge %>%
  filter(Status == "Live")

## Formatting the date fields correctly for use in R shiny app

OHID_shp_dates <- OHID_shp_L %>%
  mutate(Net_Implementation_Start = as.Date(Net_Implementation_Start, format = "%d/%m/%Y"),
         Net_Implementation_End = as.Date(Net_Implementation_End, format = "%d/%m/%Y"))