<img src="images/TU_logo_large.png" alt="TU logo" width="200" align="right"/>

# AIDF BI Support Geospatial Mapping Tool

This repository contains the scripts for the creation of an interactive geospatial mapping tool developed to provide BI support the NHS England Artificial Intelligence Diagnostic Fund..

<br/>

## Using the Repo

To be written.

<br/>

## Repo Structure

At present the structure of the repository is:

To be edited.

``` plaintext

├───data
├───images
└───src
    ├───config
    ├───processing
      ├───r_scripts
      └───sql_scripts
    └───requirements
    
```

<br/>

### `data`
Where the extract of NHS Futures short form business case (SFBC) data will be saved for loading and processing.

### `images`

Images such as TU logos and branding to add to outputs.

### `src`

All code is stored in src. This is subdivided into three modules:

1. `config`: Files for configuring the output such as the `theme.css` for the html output.
2. `processing`: Files for extracting data from SBFC files for the creation of the geospatial tool.
3. `geospatial`: Files for the creation of the geospatial html tool.
4. `requirements`: Requirements file for building the output html such as the `packages.R` script.

## Contributors

This repository has been created and developed by:

-   [Andy Wilson](https://github.com/ASW-Analyst)
-   [Elliot Royle](https://github.com/elliotroyle)