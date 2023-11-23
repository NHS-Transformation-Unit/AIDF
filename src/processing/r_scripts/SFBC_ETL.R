# Script for ETL of SFBC and creation of collated data source for geospatial mapping
# Elliot Royle - 22/11/2023


#Packages for script


library(tidyverse)
library(readxl)
library(writexl)
library(ggridges)


#Data load script - using a series of functions to extract key pieces of information from numerous Short Form Business Cases (SFBC)


source("C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/src/processing/r_scripts/SFBC_Load.R")


# Data Extraction


AIDF_Summary_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/TU Summaries/AIDF_Network_Summary.xlsx"


