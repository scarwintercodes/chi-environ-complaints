#install.packages(c("httr", "jsonlite", "tidyverse", "sf")) #enable API requests, data analysis, spatial processing
library(sf)
library(jsonlite)
library(httr)
library(tidyverse)

#API call from Visual Crossing
res <-GET("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Chicago?unitGroup=us&key=AMUYTVER39XM8FVY84ZLQSDHS&contentType=json")
res

#extract JSON format and preview
rawToChar(res$content)

data <- fromJSON(rawToChar(res$content))
names(data)

######################################

## load CDPH data
cdph <- GET("https://data.cityofchicago.org/resource/fypr-ksnz.json")
cdph

rawToChar(cdph$content)
cdph_data <- fromJSON(rawToChar(cdph$content))
