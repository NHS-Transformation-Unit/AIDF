<img src="images/TU_logo_large.png" alt="TU logo" width="200" align="right"/>

# AIDF BI Support Geospatial Mapping Tool

This repository contains the scripts for the creation of an interactive geospatial mapping tool developed to provide BI support the NHS England Artificial Intelligence Diagnostic Fund (AIDF). Data related to each of the NHS Trust providers and Imaging Networks was collected from the Short Form Business Cases available on the [NHS Futures site](https://future.nhs.uk/NationalDiagnosticsProgramme/view?objectId=45347088).

This tool aims to visualise three aspects of the AIDF programme:

1. Key information related to the Imaging Networks and their respective NHS Trusts who are currently enrolled within the AIDF programme.
2. The imaging procedure modality of each Imaging Network's planned AIDF utilisation.
3. Geospatial visualisation of each Imaging Network's commissioning boundary and respective NHS Trust HQ locations.

The geospatial visualisations within this mapping tool have been created using the `leaflet()` functions and Shiny applications within the R programming language.

<br/>

## Using the Repo

Users will need to ensure their working directory is structured as outlined in the [Repo Structure](#repo-structure) section of this ReadMe. As well as the scripts included within this Git repo, there are X data files users will need to run the mapping tool. These are outlined within the [`data`](#data) section of this ReadMe.

<br/>

## Repo Structure

At present the structure of the repository is:

To be edited.

``` plaintext

├─── data
     └─── geospatial
          └─── MSOA shapefile
     └─── processed SFBC
     └─── raw SFBC
     └─── TU summaries
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

<br/>

### `data`
Where the extracted NHS Futures short form business case (SFBC) data will be saved for loading and processing.

### `images`

Images such as TU logos and branding to add to outputs.

### `src`

All code is stored in src. This is subdivided into three modules:

1. `config`: Files for configuring the output such as the `theme.css` for the html output.
2. `geospatial`: Files for the creation of the geospatial html tool.
3. `processing`: Files for extracting data from SBFC files for the creation of the geospatial tool.
4. `requirements`: Requirements file for building the output html such as the `packages.R` script.

## Contributors

This repository has been created and developed by:

-   [Andy Wilson](https://github.com/ASW-Analyst)
-   [Elliot Royle](https://github.com/elliotroyle)
