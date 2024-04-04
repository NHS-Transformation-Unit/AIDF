<img src="images/TU_logo_large.png" alt="TU logo" width="200" align="right"/>

<br/>

<br/>

<br/>

# AIDF BI Support Geospatial Mapping Tool

<br/>

This repository contains the scripts for the creation of an interactive geospatial mapping tool developed to provide BI support to the NHS England Artificial Intelligence Diagnostic Fund (AIDF). More information on the AIDF is available [here](https://transform.england.nhs.uk/ai-lab/ai-lab-programmes/ai-in-imaging/ai-diagnostic-fund/).

Data related to each of the NHS Trust providers and Imaging Networks was collected from the Short Form Business Cases available on the [NHS Futures site](https://future.nhs.uk/NationalDiagnosticsProgramme/view?objectId=45347088).

This tool aims to visualise three aspects of the AIDF programme:

1. Key information related to the Imaging Networks and their respective NHS Trusts who are currently enrolled within the AIDF programme.
2. The imaging procedure modality of each Imaging Network's planned AIDF utilisation.
3. Geospatial visualisation of each Imaging Network's commissioning boundary and respective NHS Trust HQ locations.

The geospatial visualisations within this mapping tool have been created using the `leaflet()` functions and Shiny applications within the R programming language.

<br/>

## Using the Repo

This repository can be cloned to visualise the location and key information related to each Imaging Network and respective NHS Trusts currently enrolled in the AIDF programme.

Users will need to ensure their working directory is structured as outlined in the [Repo Structure](#repo-structure) section of this ReadMe. This can be completed using Git or by simply downloading a zipped version of the tool from this repository.

As well as the scripts included within this Git repository, there are three data files users will need to run the mapping tool, as well as an MSOA shapefile. These are outlined within the [`data`](#data) section of this ReadMe.

Following the cloning of this repository to the user's preferred IDE, and assuming all the constituent data files are located in the appropriate folder, the mapping tool can be ran by **knitting the `AIDF_Mapping_Tool.Rmd` document** found within the `src > r_scripts > geospatial` folder. The tool can then be visualised within the IDE or exported to an appropriate browser application.

In summary:

1. Extract this repository to your local files.
2. Ensure all necessary data files are in their respective locations as outlined in [`data`](#data) section.
3. Knit the `AIDF_Mapping_Tool.Rmd` file located within the `src > r_scripts > geospatial` folder.

More information on how to run the visualisation tool is available in the `documentation/guidance/running_the_tool.md` file.

<br/>

## Repo Structure

At present the structure of the repository is:

``` plaintext

├─── data
     └─── archived
          └─── raw SFBC
          └─── TU summaries
          └─── geospatial
     └─── geospatial
          └─── MSOA shapefile
     └─── processed SFBC
     
├─── images
└─── src
     └─── config
     └─── geospatial
          └─── r_scripts
               └─── implementation
               └─── modality
               └─── network
     └─── processing (archived)
          └─── r_scripts
```

For the purposes of running the model in the current build, the `raw SFBC` and `processing (archived)` folder can be ignored. These folders relate to earlier development work centred around processing the raw SFBC inputs into a single processed data file.

<br/>

### `data`
Where the extracted NHS Futures short form business case (SFBC) data will be saved for loading and processing. To run a simplified version of this tool, the user will only need to ensure that the processed SFBC and geospatial data files are in their respective folders. Data related to the raw SFBC and TU summary are archived in this latest iteration of the tool. 

The data files needed for the running of the tool are:

1. `trust_msoa_lookup.xlsx` - a lookup table for linking NHS Trusts to Middle Layer Super Output Areas (MSOA) based on aggregated patient attendance from each MSOA. This data is accessible via the Office for Health Improvement and Disparities NHS Acute Hospital Trust Catchment Populations work available [here](https://app.powerbi.com/view?r=eyJrIjoiODZmNGQ0YzItZDAwZi00MzFiLWE4NzAtMzVmNTUwMThmMTVlIiwidCI6ImVlNGUxNDk5LTRhMzUtNGIyZS1hZDQ3LTVmM2NmOWRlODY2NiIsImMiOjh9). The file is located in `src > data > geospatial`.
2. `MSOA shapefile` - a ShapeFile of each MSOA in the UK, available from the Office for National Statistics Open Geography Portal [here](https://geoportal.statistics.gov.uk/datasets/ons::msoa-2011-to-msoa-2021-to-local-authority-district-2022-lookup-for-england-and-wales/about).
3. `AIDF_Geo_Final.csv` - processed SFBC data are extracted and cleaned by the TU team from the raw SFBC files available on the NHS Futures site. The file is located in `src > data > processed SBFC`. Available upon request.

### `images`

Images such as TU logos and branding to add to outputs.

### `src`

All code is stored in `src`. This is subdivided into four modules:

1. `config`: Files for configuring the output such as the `theme.css` for the html output.
2. `geospatial`: Files for the creation of the geospatial html tool.
3. `processing (archived)`: Files for extracting data from SBFC files for the creation of the geospatial tool. These scripts remain from an older iteration of the model and are currently archived.
4. `requirements`: Requirements file for building the output html such as the `packages.R` script.

## Contributors

This repository has been created and developed by:

-   [Andy Wilson](https://github.com/ASW-Analyst)
-   [Elliot Royle](https://github.com/elliotroyle)
