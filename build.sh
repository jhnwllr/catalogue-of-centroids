#!/bin/bash

# cd /mnt/c/Users/ftw712/Desktop/catalogue-of-centroids

# Rscript.exe --vanilla sources/Australia/extraction/extraction_PCLI.R
# Rscript.exe --vanilla sources/GeoNames/extraction/extraction_PCLI.R
# Rscript.exe --vanilla sources/GeoNames/extraction/extraction_ADM1.R
# Rscript.exe --vanilla sources/CoordinateCleaner/extraction/extraction_PCLI.R
# Rscript.exe --vanilla sources/CoordinateCleaner/extraction/extraction_ADM1.R
# Rscript.exe --vanilla sources/TGN/extraction/extraction_PCLI.R
# Rscript.exe --vanilla sources/geoLocate/extraction/extraction_PCLI.R


Rscript.exe --vanilla R/combine.R
# Rscript.exe --vanilla R/stats.R




