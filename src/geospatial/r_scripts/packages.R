install.packages("here")
install.packages("tidyverse")
install.packages("leaflet")
install.packages("openxlsx")
install.packages("sf")
install.packages("plotly")
install.packages("readxl")
install.packages("htmltools")
install.packages("shiny")
install.packages("readxl")

packages <- c("here",
              "tidyverse",
              "leaflet",
              "openxlsx",
              "sf",
              "plotly",
              "readxl",
              "htmltools",
              "shiny",
              "readxl")

lapply(packages, library, character.only=TRUE)