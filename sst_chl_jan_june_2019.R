# Load required libraries
library(raster)
library(ncdf4)
library(stringr)


# --- creating a custom function to convert multiple netcdf file to raster
# --- ah! this is such a sweet moment when you overcome an error after countless tries. and
# --- happens to me. 

nc_to_tif <- function(nc_dir, var_name, tif_dir) {
  # Set the working directory to the location of the NetCDF files
  setwd(nc_dir)
  
  #listing the nc files
  nc_files <- list.files(pattern = "*.nc")
  
  #loop through the nc files
  for (i in seq_along(nc_files)) {
    #the ice breaking part of this function/code
    #read nc data
    nc <- nc_open(nc_files[i])
    
    #set the dimension
    nx <- nc$dim$lon$len
    ny <- nc$dim$lat$len
    
    # Get the variable name
    var <- ncvar_get(nc, var_name)
    
    # Create a raster brick from the variable
    r <-
      raster(
        var,
        xmn = min(nc$dim$lon$vals),
        xmx = max(nc$dim$lon$vals),
        ymn = min(nc$dim$lat$vals),
        ymx = max(nc$dim$lat$vals),
        crs = "+proj=longlat +datum=WGS84"
      )
    
    # Create the output filename
    tif_file <-
      paste0(tif_dir, "/", gsub(".nc", ".tif", nc_files[i]))
    
    # Save the raster object as a GeoTIFF file
    writeRaster(r,
                filename = tif_file,
                overwrite = TRUE,
                format = "GTiff")
    
    # Close the NetCDF file
    nc_close(nc)
  }
  
}

# --- now convert netcdf to raster using nc_to_tif function

# --- for sea surface temperature data
nc_to_tif(
  "C:/ocean/data/sst/sst_2019_jan_to_june/requested_files",
  "sst",
  "C:/ocean/data/sst/sst_2019_jan_to_june"
)


# --- for ocean color (chlorophyll concentration data)
nc_to_tif(
  "C:/ocean/data/Chlorophyll/chlorophyll_2019_jan_june/requested_files",
  "chlor_a",
  "C:/ocean/data/Chlorophyll/chlorophyll_2019_jan_june"
)




# --- limit z and y axis
setwd("C:/ocean/data/sst/sst_2019_jan_to_june")

library(raster)
library(rasterVis)

sst_19 <- list.files(pattern = "*.tif")

sst_19_1 <- raster(sst_19[1])

extent(sst_19_1) <- extent(77.22082, 100.2492, 1.410841, 23.16916)

sst_19_1 <- rotate(sst_19_1)

plot(sst_19_1)


# --- now create a function to set the limit of x and y axis and show them in plot window

tif_plot <- function(tif_dir, xmin, xmax, ymin, ymax) {
  setwd(tif_dir)
  
  tif_list <- list.files(pattern = "*.tif")
  
  for (i in seq_along(tif_list)) {
    tif <- raster(tif_list[i])
    
    extent(tif) <- extent(xmin, xmax, ymin, ymax)
    
    tif <- flip(tif, direction = "y")
    
    raster::plot(tif)
  }
}

# -- now time to execute the function

# -- sst data
tif_plot("C:/ocean/data/sst/sst_2019_jan_to_june",
         77.22082,
         100.2492,
         1.410841,
         23.16916)


# -- chlorophyll data
tif_plot(
  "C:/ocean/data/Chlorophyll/chlorophyll_2019_jan_june",
  77.22082,
  100.2492,
  1.410841,
  23.16916
)








