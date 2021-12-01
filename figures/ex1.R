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



nc$share <- 100000 * nc$SID74 / nc$BIR74
# quantization breaks of the rate
bks <- mf_get_breaks(x = nc$share, breaks =  "quantile", nbreaks =  5)
# correct the breaks to use the global rate as limit of class
global_rate <- sum(nc$SID74) * 100000 / sum(nc$BIR74)
bks[4] <- global_rate
# get a color palette
cols <- mf_get_pal(n = c(3,2), palette = c("Mint", "Burg"))


bb <- st_bbox(nc)
nframe <- 200
sx <- seq(bb[1]+10000, bb[3]-10000, length.out = nframe)
sy <- rep(4257339, nframe)
pt <- st_as_sf(data.frame(X = sx, Y = sy), coords = c("X","Y"))

library(mapsf)
x <- mf_theme("iceberg")
for(i in 1:nframe){
  gfe <- fisheye(g, centre = pt[i,], method = 'log', k = 3)
  ncfe <- fisheye(nc, centre = pt[i, ], method = 'log', k = 3)
  # mf_init(ncfe, theme = "iceberg", export = "png", filename = sprintf("fig/img%06d.png", i), width = 800, res = 100)
  png(sprintf("fig/img%06d.png", i), width = 400, height = 350, res = 100)
  mf_theme("iceberg")
  mf_map(ncfe, var = "share", type = "choro", breaks = bks, pal = cols,
         lwd = .2, add = F, leg_pos = NA)
  mf_map(gfe, col = c('green'),lwd = .3, add = T)
  mf_legend(type = "choro", pos = "bottomleft2", val = bks, pal = cols, val_rnd = 0, title = "", cex = .7)
  mf_title("Sudden Infant Death Syndrome in North Carolina, 1974-1978",line = .9, cex = .7)
  mf_credits("per 100,000 live births.\nSource: North Carolina SIDS data set")
  dev.off()
}
ncfe

x

#
# library(sf)
# ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
# nc <- st_transform(ncraw, 3857)
#   ncfe <- fisheye(nc, centre = nc[39, ], method = 'log', k = 4)
# plot(st_geometry(ncfe), col = "grey70", lwd = .2)
# plot(st_geometry(ncfe[39,]), col = NA, lwd = 2, border = "red", add = TRUE)
# ncfe
#

