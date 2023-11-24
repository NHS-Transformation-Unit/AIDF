# Script for ETL of SFBC and creation of collated data source for geospatial mapping


#Packages for script


install.packages('stringr')

library(tidyverse)
library(readxl)
library(writexl)
library(ggridges)
library(stringr)


#Data load script - uses a series of functions to extract key pieces of information from numerous Short Form Business Cases (SFBC)


source("C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/src/processing/r_scripts/SFBC_Load.R")


# Data Extraction and Transformation


AIDF_Summary_File_Path <- "C:/Users/elliot.royle/OneDrive - Midlands and Lancashire CSU/Git/AIDF/data/TU Summaries/AIDF_Network_Summary.xlsx"

Raw_AIDF_Summary <- read_excel(AIDF_Summary_File_Path)

result$SFBC_ID <- str_split_fixed(result$FileName, "\\.", 2)[, 1]

result_wide <- pivot_wider(
  data = result,
  names_from = Field1,
  values_from = Field2
)

capitalise_NHS <- function(x) {
  gsub("\\bNHS\\b", "NHS", x, ignore.case = TRUE)
}

AIDF_df <- result_wide %>%
  mutate(`Network Name 1` = sub("\\\\.*","", `Network Name`)) %>%
  mutate(`Network Name 2` = sub(".*\\\\", "", `Network Name`)) %>%
  mutate(Trust = str_to_title(Trust)) %>%
  select(c(3, 4, 15, 16, 7, 8))

AIDF_df$Trust <- capitalise_NHS(AIDF_df$Trust)
  

E1_df <- AIDF_df %>%
  filter(`Network Name 1` == "Norfolk, Suffolk & North Essex")

E2_df <- AIDF_df %>%
  filter(`Network Name 1` == "Herts West Essex, Bedford Luton and Mid and South Essex systems")

EM1_df <- AIDF_df %>%
  filter(`SFBC_ID` == "EM1_SFBC")

HNY_df <- AIDF_df %>%
  filter(`SFBC_ID` == "HNY_SFBC")

NEL1_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NEL1_SFBC")

NENC_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NENC_SFBC")

NWCM_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NWCM_SFBC")

NWGM_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NWGM_SFBC")

NWL1_df <- AIDF_df %>%
  filter(`SFBC_ID` == "NWL1_SFBC")

SE2_df <- AIDF_df %>%
  filter(`SFBC_ID` == "SE2_SFBC")

SW1_df <- AIDF_df %>%
  filter(`SFBC_ID` == "SW1_SFBC")

# Cleaning C&M

CM_Row <- 8
CM_Column <- "Trust"
CM_Value <- "Mersey and West Lancashire Teaching Hospitals NHS Trust"

NWCM_df[CM_Row, CM_Column] <- CM_Value

#Cleaning EM1

EM1_Row <- 7
EM1_Column <- "Trust"
EM1_Value <- "University Hospitals of Leicester NHS Trust"

EM1_df[EM1_Row, EM1_Column] <- EM1_Value

# Cleaning GM

GM_Trusts <- c("Bolton NHS Foundation Trust",
               "Manchester University NHS Foundation Trust",
               "Northern Care Alliance NHS Foundation Trust",
               "Tameside and Glossop Integrated Care NHS Foundation Trust",
               "The Christie NHS Foundation Trust",
               "Stockport NHS Foundation Trust",
               "Wrightington, Wigan and Leigh NHS Foundation Trust", 
               "Blank")

GM_Remove <- 8

NWGM_df <- NWGM_df %>% 
  mutate(Trust = GM_Trusts) %>%
  mutate(Region = "North West") %>%
  mutate(`Network Name 1` = "Greater Manchester") %>%
  mutate(`Network Name 2` = "North West 2") %>%
  filter(row_number() != GM_Remove)

#Cleaning HNY

HNY_Row <- c(1, 2, 3)
HNY_Column <- "Trust"
HNY_Value <- c("Hull University Teaching Hospitals NHS Trust",
               "York and Scarborough Teaching Hospitals NHS Foundation Trust",
               "Northern Lincolnshire and Goole NHS Foundation Trust")

HNY_df[HNY_Row, HNY_Column] <- HNY_Value

# Cleaning North East London

remove_NELCA <- 4
NEL1_df <- NEL1_df[-remove_NELCA, ]

#Cleaning NWL1

remove_NWL1 <- c(3, 5, 6, 7)
NWL1_df <- NWL1_df[remove_NWL1, ]

#Cleaning SE2

SE2_Dupli <- 5
SE2_df <- rbind(SE2_df, SE2_df[SE2_Dupli, ], SE2_df[SE2_Dupli, ])

SE2_Row <- c(5, 6, 7)
SE2_Column <- "Trust"
SE2_Value <- c("University Hospitals Sussex NHS Foundation Trust",
               "Queen Victoria Hospital NHS Foundation Trust",
               "Surrey & Sussex Healthcare NHS Trust")

SE2_df[SE2_Row, SE2_Column] <- SE2_Value








