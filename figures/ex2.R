# library(osmdata)
#
# # define a bounding box
# q0 <- opq(bbox = c(2.2247, 48.8188, 2.4611, 48.9019))
#
# # extract Paris boundaries
# q1 <- add_osm_feature(opq = q0, key = 'name', value = "Paris")
# res1 <- osmdata_sf(q1)
# paris <- st_geometry(res1$osm_multipolygons[1,])
#
# # extract the Seine river
# q2 <- add_osm_feature(opq = q0, key = 'name', value = "La Seine")
# res2 <- osmdata_sf(q2)
# seine1 <- st_geometry(res2$osm_multilines)
# q2b <- add_osm_feature(opq = q0, key = 'name',
#                        value = "La Seine - Bras de la Monnaie")
# res2b <- osmdata_sf(q2b)
# seine2 <- st_geometry(res2b$osm_lines)
#
# # extract Parks and Cemetaries
# q3 <- add_osm_feature(opq = q0, key = 'leisure', value = "park")
# res3 <- osmdata_sf(q3)
# parc1 <- st_geometry(res3$osm_polygons)
# parc2 <- st_geometry(res3$osm_multipolygons)
# q4 <- add_osm_feature(opq = q0, key = 'landuse', value = "cemetery")
# res4 <- osmdata_sf(q4)
# parc3 <- st_geometry(res4$osm_polygons)
#
# # extract Quartiers
# q5 <- add_osm_feature(opq = q0, key = 'admin_level', value = "10")
# res5 <- osmdata_sf(q5)
# quartier <- res5$osm_multipolygons
#
# # extract Bars & Pubs
# q6 <- add_osm_feature(opq = q0, key = 'amenity', value = "bar")
# res6 <- osmdata_sf(q6)
# bar <- res6$osm_points
# q7 <- add_osm_feature(opq = q0, key = 'amenity', value = "pub")
# res7 <- osmdata_sf(q7)
# pub <- res7$osm_points
#
#
#
#
# # use Lambert 93 projection (the french cartographic projection) for all layers
# parc1 <- st_transform(parc1, 2154)
# parc2 <- st_transform(parc2, 2154)
# parc3 <- st_transform(parc3, 2154)
# paris <- st_transform(paris, 2154)
# seine1 <- st_transform(seine1, 2154)
# seine2 <- st_transform(seine2, 2154)
# quartier <- st_transform(quartier, 2154)
# bar <- st_transform(bar, 2154)
# pub <- st_transform(pub, 2154)
#
#
# # make layers pretty
# ## Parcs and cemetaries are merged into a single layer, we only keep objects
# ## greater than 1 ha
# parc <- do.call(c, list(parc1, parc2, parc3))
# parc <- st_union(x = st_buffer(parc,0), by_feature = F)
# parc <- st_cast(parc, "POLYGON")
# parc <- parc[st_area(parc)>=set_units(10000, "m^2")]
# parc <- st_intersection(x = parc, y = paris)
#
# ## We only keep the part of the river within Paris boundaries
# seine <- st_intersection(x = seine1, y = paris)
# seine <- c(st_cast(seine[1])[2:5], seine[2])
# seine <-c(seine, seine2)
#
# plot(seine)
#
# ## We only keep the bars and pubs within Paris boundaries
# bar <- bar[!is.na(bar$name),]
# pub <- pub[!is.na(pub$name),]
# bars <- rbind(bar[,"name"], pub[,"name"])
# bars <- st_intersection(x = bars, y = paris)
#
# ## We only keep the Paris quartiers
# quartier <- quartier[substr(quartier$ref.TRIRIS,1,2)==75,]
#
#
# save(list= c("paris", "quartier", "seine", "parc", "bars"),
#      file = "paname.RData", compress = "xz")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# library(sf)
# library(osmdata)
# load(file = "/home/tim/Documents/prj/pts/paname.RData")
# paris <- st_sf(geometry =paris)
# parc <- st_sf(geometry = parc)
# seine <- st_sf(geometry = seine)
#
#
# name <- "Paris"
# # streetsLarge <- getbb(name) %>%
# #   opq() %>%
# #   add_osm_feature(key = "highway",
# #                   value = c("Motorway", "trunk", "primary",
# #                             "secondary", "tertiary"),
# #                   match_case = FALSE, value_exact = FALSE) %>%
# #   osmdata_sf()
# # streetsLarge <- unique_osmdata(streetsLarge)
# # streetsLarge <- streetsLarge$osm_lines
# # streetsLarge <- st_transform(streetsLarge, 2154)
# # streetsLarge <- st_sf(geometry = streetsLarge)
# # streetsLarge <- st_intersection(streetsLarge, paris)
# # s1 <- st_buffer(x = streetsLarge, dist = 20)
# # s2 <- st_union(s1)
# # s3 <- st_buffer(x = s2, dist = -10)
# # streetsLarge <- st_sf(s3)
#
#
#
# streetsAll <- getbb(name) %>%
#   opq() %>%
#   add_osm_feature(key = "highway",
#                   match_case = FALSE,
#                   value_exact = FALSE) %>%
#   osmdata_sf()
# streetsAll <- unique_osmdata(streetsAll)
# streetsAll <- streetsAll$osm_lines
# streetsAll <- st_transform(streetsAll, 2154)
# streetsAll <- st_sf(geometry = st_geometry(streetsAll))
# streetsAll <- st_intersection(streetsAll, paris)
# streetsAll <- st_union(x = streetsAll, by_feature = FALSE)
# streetsAll <- st_sf(streetsAll)
#
#
#
#
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
# plot(st_geometry(streetsAll), col = "#FBEDDA", border = NA, lwd = 0.4, add=T)
#
#
# library(sf)
# library(osrm)
# library(maptiles)
# bb <- st_bbox(c(xmin = 643069.1, ymin = 6857478.4,
#                 xmax = 661079.5, ymax = 6867081.9),
#               crs = 2154)
# osm <- get_tiles(x = bb, provider = "CartoDB.PositronNoLabels", crop = TRUE, zoom = 13)
# pts <- st_as_sf(data.frame(x = c(648883.4, 654708.1),
#                            y = c(6859631, 6864869)),
#                 coords = c("x","y"), crs = 2154)
#
# car <- osrmRoute(src = pts[1,], dst = pts[2,], returnclass = "sf", osrm.profile = "car", overview = "full")
# bike <- osrmRoute(src = pts[1,], dst = pts[2,], returnclass = "sf", osrm.profile = "bike", overview = "full")
# foot <- osrmRoute(src = pts[1,], dst = pts[2,], returnclass = "sf", osrm.profile = "foot", overview = "full")
#
# png("osrm.png", width = 1511, height = 842)
# par(mar = c(0,0,0,0))
# plot_tiles(osm)
# plot(car$geometry, add = T, col = "navy", lwd = 5)
# plot(bike$geometry, add = T, col = "tomato", lwd = 4)
# plot(foot$geometry, add = T, col = "darkgreen", lwd = 1.5)
#
# legend(x = 652828.5,
#        y = 6862128,
#        legend =
#          c(paste0("car (", round(car$duration,0), "min)"),
#            paste0("bike (", round(bike$duration,0), "min)"),
#            paste0("foot (", round(foot$duration,0), "min)")),
#        col=c("navy", "tomato", "darkgreen"),
#        lty=c(1,1,1), cex=1.2,
#        box.lty=0, lwd = c(5,4,1.5))
#
# dev.off()
# locator(1)
#
# locator(1)
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
