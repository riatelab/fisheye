library(sf)
library(fisheye)
ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
bb <- st_bbox(ncraw)
graw <- st_graticule(lon = seq(bb[1], bb[3], by = .2),
                     lat = seq(bb[2], bb[4], by = .2 ),
                     ndiscr = 100000)
g <- st_transform(graw, 3857)
nc <- st_transform(ncraw, 3857)
g <- st_crop(g, nc)



bb <- st_bbox(nc)
pt <- st_as_sf(data.frame(X = -8790936, Y =4242585), coords = c("X","Y"))
mf_map(nc)
library(mapsf)
x <- mf_theme("iceberg")

nframe = 10
k <- seq(10,0.000001, length.out = nframe)


k <- seq(7,0,by = -.05)

for(i in 1:length(k)){
  gfe <- fisheye(g, centre = pt, method = 'log', k = k[i])
  ncfe <- fisheye(nc, centre = pt, method = 'log', k = k[i])
  # mf_init(ncfe, theme = "iceberg", export = "png", filename = sprintf("fig/img%06d.png", i), width = 800, res = 100)
  png(sprintf("fig2/img%06d.png", i), width = 400, height = 350, res = 100)
  mf_theme("iceberg")
  mf_map(ncfe)
  mf_map(gfe, col = c('green'),lwd = .3, add = T)
  # mf_legend(type = "choro", pos = "bottomleft2", val = bks, pal = cols, val_rnd = 0, title = "", cex = .7)
  mf_title(paste0("k = ", k[i]),line = .9, cex = .7)
  # mf_credits("per 100,000 live births.\nSource: North Carolina SIDS data set")
  dev.off()
}
