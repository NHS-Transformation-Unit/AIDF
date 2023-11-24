# Script for ETL of SFBC data files


#Packages for script


library(tidyverse)
library(readxl)
library(writexl)
library(ggridges)
library(stringr)


#Data processing script - takes data extracted using the 'SFBC_Load.R' script and cleans the outputs


source("C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/src/processing/r_scripts/SFBC_ETL.R")


# Preparing the different files to be joined to


AIDF_Summary_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/TU Summaries/AIDF_Network_Summary.xlsx"
NHS_Trust_Location_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Geospatial/NHSTrust_Location.xlsx"

AIDF_Ref_Raw <- read_excel(AIDF_Summary_File_Path)
NHS_Trust_Lookup <- read_excel(NHS_Trust_Location_File_Path)


# Cleaning the NHS Trust Lookup


NHS_Trust_Lookup <- NHS_Trust_Lookup %>%
  mutate(Name = str_to_title(Name)) %>%
  select(c(2, 1, 10, 11, 12))

NHS_Trust_Lookup$Name <- capitalise_NHS(NHS_Trust_Lookup$Name)


# Cleaning the AIDF Summary


AIDF_Ref_Proc <- AIDF_Ref_Raw %>%
  select(c(1, 3, 4, 5, 6))

AIDF_Ref_Remove <- 11

AIDF_Ref_Proc <- AIDF_Ref_Proc %>% 
  filter(row_number() != AIDF_Ref_Remove)


