# Script for ETL of SFBC and creation of collated data source for geospatial mapping
# Elliot Royle - 22/11/2023


#Packages for script


library(tidyverse)
library(readxl)
library(writexl)
library(ggridges)


# Data Extraction

AIDF_Summary_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/TU Summaries/AIDF_Network_Summary.xlsx"

E1_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/E1_SFBC.xlsx"
EM1_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/EM1_SFBC.xlsx"
HNY_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/HNY_SFBC.xlsx"
NEL1_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/NEL1_SFBC.xlsx"
NENC_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/NENC_SFBC.xlsx"
NWCM_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/NWCM_SFBC.xlsx"
NWGM_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/NWGM_SFBC.xlsx"
NWL1_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/NWL1_SFBC.xlsx"
SE1_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/SE1_SFBC.xlsx"
SW1_Raw_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/Raw SFBC/SW1_SFBC.xlsx"

AIDF_Summary <- read_excel(AIDF_Summary_File_Path)

E1_Raw <- read_excel(E1_Raw_File_Path)
EM1_Raw <- read_excel(EM1_Raw_File_Path)
HNY_Raw <- read_excel(HNY_Raw_File_Path)
NEL1_Raw <- read_excel(NEL1_Raw_File_Path)
NENC_Raw <- read_excel(NENC_Raw_File_Path)
NWCM_Raw <- read_excel(NWCM_Raw_File_Path)
NWGM_Raw <- read_excel(NWGM_Raw_File_Path)
NWL1_Raw <- read_excel(NWL1_Raw_File_Path)
SE1_Raw <- read_excel(SE1_Raw_File_Path)
SW1_Raw <- read_excel(SW1_Raw_File_Path)
