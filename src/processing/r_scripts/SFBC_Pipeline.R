# Pipeline script for running all of the SFBC ETL scripts

source("src/processing/r_scripts/SFBC_Packages.R")
source("src/processing/r_scripts/SFBC_Load.R")
source("src/processing/r_scripts/SFBC_ETL.R")
source("src/processing/r_scripts/SFBC_Clean.R")
source("src/processing/r_scripts/SFBC_Join.R")