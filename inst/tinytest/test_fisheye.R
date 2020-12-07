suppressPackageStartupMessages(library(sf))
nc <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
nc <- st_transform(nc, 3857)
nc1 <- nc[1,]
ncmp <- st_cast(nc, "MULTIPOLYGON")
suppressWarnings(ncp <- st_cast(nc, "POLYGON"))
ncml <- st_cast(nc, "MULTILINESTRING")
suppressWarnings(ncl <- st_cast(ncml, "LINESTRING"))
suppressWarnings(ncpt <- st_cast(ncl, "POINT"))

expect_silent(fisheye(ncmp, nc1, "log", 1))
expect_silent(fisheye(ncml, nc1, "log", 1))
expect_silent(fisheye(ncl,  nc1, "log", 1))
expect_silent(fisheye(ncp,  nc1, "log", 1))
expect_silent(fisheye(ncpt, nc1, "sqrt"))

# test garbage input
expect_error(fisheye(ncmp, nc1, "logs", 1))
