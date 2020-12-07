# library(sf)
# library(lwgeom)
# library(osmdata)
# load(file = "/home/tim/Documents/prj/pts/paname.RData")
#
#
# name <- "Paris"
# streets <- getbb(name) %>%
#   opq() %>%
#   add_osm_feature(key = "highway",
#                   value = c("Motorway", "trunk", "primary",
#                             "secondary", "tertiary"),
#                   match_case = FALSE, value_exact = FALSE) %>%
#   osmdata_sf()
#
# place$osm_points
# place <- getbb(name) %>%
#   opq() %>%
#   add_osm_feature(key = "place",
#                   value = "suburb",
#                   match_case = FALSE, value_exact = FALSE) %>%
#   osmdata_sf()
#
# placept <- place$osm_points
# pp <- (placept[!is.na(placept$name)& is.na(placept$addr.postcode),])
# pp <- st_transform(pp, 2154)
# pp <- st_intersection(pp, paris)
#
#
# paris <- st_sf(geometry =paris)
# parc <- st_sf(geometry = parc)
# seine <- st_sf(geometry = seine)
#
# streets <- st_sf(geometry = streets)
# streets_paris <- st_intersection(streets, paris)
#
# s1 <- st_buffer(x = streets_paris, dist = 20)
# s2 <- st_union(s1)
# s3 <- st_buffer(x = s2, dist = -10)
# street <- st_sf(s3)
#
# bars$id <- 1:nrow(bars)
#
#
# bb <- st_bbox(st_tran)
#
# bb <-st_bbox(st_transform(paris, 4326))
# graw <- st_graticule(lon = seq(bb[1], bb[3], by = .005),
#                      lat = seq(bb[2], bb[4], by = .005 ),
#                      ndiscr = 1000000)
# g <- st_transform(graw, 2154)
# g <- st_crop(g, paris)
#
# g <- st_make_grid(x = paris, cellsize = 250)
# g <- st_intersection(g, paris)
# g <- st_segmentize(g, 10)
# g <- st_sf(geometry = g)
# g <- st_cast(g, "MULTIPOLYGON")
# par(mar = c(0,0,1.2,0))
# plot(st_geometry(paris), col = "#D9D0C9", border = NA, bg = "#FBEDDA")
# plot(st_geometry(parc), col = "#CDEBB2", border = NA, add=T)
# plot(st_geometry(seine), col = "#AAD3DF", add=T, lwd = 4)
# plot(st_geometry(street), col = "#FBEDDA", border = NA, lwd = 0.4, add=T)
# plot(st_geometry(bars), add=T, col = "goldenrod4", pch = 21, cex = 0.4)
# plot(st_geometry(quartier), col = NA, lwd = 0.2, add=T)
# plot(st_geometry(bars[292,]), add=T, col = "red", pch = 21, cex = 2)
# plot(paris, add=T, lwd = 0.7)
# labelLayer(pp, txt="name", overlap = F)
#
# dep <- st_read("/home/tim/Téléchargements/magrit-templates-carto-master/france_departements/layers/DEPT.geojson")
# dep <- st_transform(dep, 2154)
#
# centre <- bars[292, ]
# method = "log"
# k <- .005
# parisfe <- fisheye(paris, centre, method, k)
# parcfe <- fisheye(parc, centre, method, k)
# seinefe <- fisheye(seine, centre, method, k)
# streetfe <- fisheye(street, centre, method, k)
# barsfe <- fisheye(bars, centre, method, k)
# quartierfe <- fisheye(quartier, centre, method, k)
# ppfe <- fisheye(pp, centre, method, k)
# gfe <- fisheye(g, centre, method, k)
# depfe <- fisheye(dep, centre, method, k)
# par(mar = c(0,0,1.2,0))
# plot(st_geometry(parisfe), col = "#D9D0C9", border = NA, bg = "#FBEDDA")
# plot(depfe$geometry, add = F, col = "#D9D0C9", lwd = .4)
# plot(st_geometry(parcfe), col = "#CDEBB2", border = NA, add=T)
# plot(st_geometry(seinefe), col = "#AAD3DF", add=T, lwd = 4)
# plot(st_geometry(streetfe), col = "#FBEDDA", border = NA, lwd = 0.4, add=T)
# # plot(gfe$geometry, add = T, lwd = .2,col = NA, border = 'white')
# # plot(st_geometry(barsfe), add=T, col = "goldenrod4", pch = 21, cex = 0.4)
# plot(st_geometry(parisfe), add=T, lwd = 0.7)
#
# # library(cartography)
# # labelLayer(ppfe, txt="name")
# # points(0,0,pch = 21, cex = 1)
