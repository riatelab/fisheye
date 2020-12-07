# library(sf)
# ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
# nc <- st_transform(ncraw, 3857)
# ncfe <- fisheye(nc, centre = nc[47, ], method = 'log', k = 0.0001)
# plot(st_geometry(ncfe), col = "grey70", lwd = .2)
# plot(st_geometry(ncfe[47,]), col = NA, lwd = 2, border = "red", add = TRUE)
#
#
#
# ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
# bb <- st_bbox(ncraw)
# graw <- st_graticule(lon = seq(bb[1], bb[3], by = .2),
#                      lat = seq(bb[2], bb[4], by = .2 ),
#                      ndiscr = 100000)
# g <- st_transform(graw, 3857)
# nc <- st_transform(ncraw, 3857)
# g <- st_crop(g, nc)
#
#
# par(mfrow= c(2,1), mar = c(0,0,0,0))
# plot(st_geometry(nc), col = c("grey70"),lwd = .2, add = F)
# plot(st_geometry(nc[100,]),  col = NA, lwd = 2, border = "red", add = T)
# plot(st_geometry(g), col = c('blue'),lwd = .1, add = T)
#
# gfe <- fisheye(g, centre = nc[100, ], method = 'log', k = 0.0001)
# ncfe <- fisheye(nc, centre = nc[100, ], method = 'log', k = 0.0001)
# plot(st_geometry(ncfe), col = c("grey70"),lwd = .2, add = F)
# plot(st_geometry(ncfe[100,]),  col = NA, lwd = 2, border = "red", add = T)
# plot(st_geometry(gfe), col = c('blue'),lwd = .1, add = T)

#
# library(sf)
# ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
# nc <- st_transform(ncraw, 3857)
#   ncfe <- fisheye(nc, centre = nc[39, ], method = 'log', k = 4)
# plot(st_geometry(ncfe), col = "grey70", lwd = .2)
# plot(st_geometry(ncfe[39,]), col = NA, lwd = 2, border = "red", add = TRUE)
# ncfe
#

