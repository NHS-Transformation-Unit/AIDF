# Packages used in the across both Processing and Geospatial scripts.

install.packages("pandoc")

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
              "shiny",
              "htmlwidgets", 
              "pandoc")

lapply(packages, library, character.only=TRUE)
