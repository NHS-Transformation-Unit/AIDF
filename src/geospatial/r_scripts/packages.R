packages <- c("here",
              "tidyverse",
              "leaflet",
              "openxlsx",
              "sf",
              "plotly",
              "readxl",
              "htmltools",
              "shiny")


lapply(packages, library, character.only=TRUE)