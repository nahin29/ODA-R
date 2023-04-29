library(raster)
library(rasterVis)
library(tidyverse)
library("rnaturalearth")
library("rnaturalearthdata")
library(oce)

nc_to_dataframe <- function(netcdf_data, xy = T, ...) {
  if (missing(netcdf_data)) {
    print("where is your data huh?")
  } else {
    chl_conc <- raster(netcdf_data)
    chl_conc <- raster::as.data.frame(chl_conc, xy = xy)
    return(chl_conc)
  }
}
