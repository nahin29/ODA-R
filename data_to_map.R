create_color_scale3 <- function(colors = NULL, legend_title) {
  if (n <- length(colors)) {
    scale_fill_gradientn(colors = colors, values = seq(0, 1, length.out = n),
                         legend_title)
  } else {
    scale_fill_gradient2(low = "white", mid = "lightgreen",high = "seagreen")
  }
}


dataframe_to_map <- function(data, data_world, fill,fill_color, legend_title, title, lg_pos){
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



dataframe_to_map(sst1, world, oce::oceColorsTemperature(128),
                 title = "SST", legend_title = "sst",
                 fill = sst1$Sea.Surface.Temperature,
                 lg_pos = "bottom")
