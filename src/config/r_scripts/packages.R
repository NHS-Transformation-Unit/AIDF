# Packages used in the across both Processing and Geospatial scripts.

packages <- c("here",
              "purrr",
              "tidyverse",
              "tidyr",
              "stringr",
              "leaflet",
              "openxlsx",
              "sf",
              "plotly",
              "readxl",
              "htmltools",
              "shiny",
              "readxl",
              "dplyr", 
              "shiny")

lapply(packages, library, character.only=TRUE)
