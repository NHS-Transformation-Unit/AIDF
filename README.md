<img src="images/TU_logo_large.png" alt="TU logo" width="200" align="right"/>

# AIDF BI Support Geospatial Mapping Tool

This repository contains the scripts for the creation of an interactive geospatial mapping tool developed to provide BI support the NHS England Artificial Intelligence Diagnostic Fund (AIDF).

<br/>

## Using the Repo

This repository contains all scripts necessary for the creation of the AIDF Geospatial Mapping Tool. Due to Information Governance, all files included in the `Data` folder used in the creation of this tool have been omitted from this repo. The following data sets/files will need to be sourced by any analyst looking to recreate this tool:

-   MSOA Shapefile and Trust to MSOA Lookup file accessed via the Office for Health Improvement & Disparities' NHS Acute (Hospital) Trust Catchment Populations Dashboard available [here](https://app.powerbi.com/view?r=eyJrIjoiODZmNGQ0YzItZDAwZi00MzFiLWE4NzAtMzVmNTUwMThmMTVlIiwidCI6ImVlNGUxNDk5LTRhMzUtNGIyZS1hZDQ3LTVmM2NmOWRlODY2NiIsImMiOjh9).
-   NHS Acute Trust site location data pulled from the National Commissioning Data Repository (script available upon request).
-   Short Form Business Cases for all Trusts participating in the AIDF initiative available [here](https://future.nhs.uk/NationalDiagnosticsProgramme/view?objectID=45347088).
-   Supplementary AIDF Trust data sourced directly from NHS England AIDF Programme team.


<br/>

## Repo Structure

At present the structure of the repository is:

To be edited.

``` plaintext

├───data
├───images
└───src
    ├───config
    ├───geospatial
      ├───r_scripts
    ├───processing
      ├───r_scripts
    └───requirements
    
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
