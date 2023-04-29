dataframe_to_map2 <-  function(data, data_world, fill, fill_color, legend_title, title, lg_pos) {
  if (is.null(data)) {
    stop("Error: Data not found")
  }
  if (is.null(data_world)) {
    stop("Error: data_world not found")
  }
  
  if (is.character(fill)) {
    # The value of the `fill` argument is a color.
  } else {
    # The value of the `fill` argument is not a color.
  }
  
  if (legend_title == "") {
    warning("The 'legend_title' argument must not be empty.")
  }
  
  if (title == "") {
    warning("The 'title' argument must not be empty.")
  }
  
  ggplot(data) +
    geom_raster(aes(x = x, y = y, fill = fill)) +
    geom_sf(data = data_world) +
    create_color_scale3(colors = fill_color, legend_title = legend_title) +
    theme_bw() +
    coord_sf(xlim = c(80, 95), ylim = c(5, 23), expand = FALSE) +
    xlab("Longitude") + ylab("Latitude") +
    ggtitle(title) +
    theme(plot.title = element_text(size = 10, face = "bold"),
          axis.title = element_text(size = 10),
          axis.text = element_text(size = 10),
          legend.position = lg_pos,
          panel.background = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())
} 

dataframe_to_map2(sst1,world, oce::oceColorsTemperature(128), legend_title = "sst",
                  fill = sst1$Sea.Surface.Temperature, title = "ss",
                  lg_pos = "bottom")

dataframe_to_map2(chl1,world, oce::oceColorsChlorophyll(128), legend_title = "chl_conc",
                  fill = chl1$Chlorophyll.Concentration..OCI.Algorithm, title = "chl",
                  lg_pos = "bottom")


