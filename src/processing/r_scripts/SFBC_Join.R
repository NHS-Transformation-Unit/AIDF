# Joining SFBC, AIDF network summary and NCDR location df

## Preparing the different files to be joined to

AIDF_Summary_File_Path <- paste0(here(),"/data/TU Summaries/AIDF_Network_Summary.xlsx") 
NHS_Trust_Location_File_Path <- paste0(here(),"/data/Geospatial/NCDR_Reference_Locations.xlsx")

AIDF_Ref_Raw <- read_excel(AIDF_Summary_File_Path)
NHS_Trust_Lookup <- read_excel(NHS_Trust_Location_File_Path)


## Cleaning the NHS Trust Lookup

NHS_Trust_Lookup <- NHS_Trust_Lookup %>%
  select(c(1, 11, 15, 16))

names(NHS_Trust_Lookup)[names(NHS_Trust_Lookup) == "ODS_Code"] <- "Org code"

## Cleaning the AIDF Summary

AIDF_Ref_Proc <- AIDF_Ref_Raw %>%
  select(c(1, 3, 4, 5, 6))

AIDF_Ref_Remove <- 11

AIDF_Ref_Proc <- AIDF_Ref_Proc %>% 
  filter(row_number() != AIDF_Ref_Remove)

## Joining the files

AIDF_Expanded <- left_join(AIDF_Proc, AIDF_Ref_Proc, by = "SFBC_ID")

AIDF_Geo_Final <- left_join(AIDF_Expanded, NHS_Trust_Lookup, by = "Org code")

## Changing the geospatial fields to numerical

AIDF_Geo_Final <- AIDF_Geo_Final %>%
  mutate(Latitude_1m = as.numeric(Latitude_1m),
         Longitude_1m = as.numeric(Longitude_1m))

## Writing the final AIDF Geo file output

write.csv(AIDF_Geo_Final, paste0(here(),"/data/Processed SFBC/AIDF_Geo_Final.csv"))