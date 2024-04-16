# Packages used in the across both Processing and Geospatial scripts.

packages <- c("here",
              "purrr",
              "tidyverse",
              "tidyr",
              "stringr",
              "openxlsx",
              "sf",
              "plotly",
              "readxl",
              "htmltools",
              "shiny",
              "readxl",
              "dplyr", 
              "crosstalk",
              "leaflet")

lapply(packages, library, character.only=TRUE)