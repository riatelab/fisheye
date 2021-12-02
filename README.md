
# fisheye

<!-- badges: start -->

![R-CMD-check](https://github.com/riatelab/fisheye/workflows/R-CMD-check/badge.svg)
[![codecov](https://codecov.io/gh/riatelab/fisheye/branch/main/graph/badge.svg)](https://app.codecov.io/gh/riatelab/fisheye?branch=main)
<!-- badges: end -->

The goal of fisheye is to create base maps focusing on a specific
location using an azimuthal logarithmic distance transformation.

## Installation

You can install the development version of fisheye from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("riatelab/fisheye")
```

## Example

This is a basic example:

``` r
library(fisheye)
library(mapsf)
#> Le chargement a nécessité le package : sf
#> Linking to GEOS 3.9.0, GDAL 3.2.2, PROJ 7.1.0
ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
nc <- st_transform(ncraw, 3857)
mf_map(nc, col ="grey90")
mf_map(nc[51, ], add = TRUE, col = "grey40")
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r
nc_fe  <- fisheye(nc, centre = nc[51, ])
mf_map(nc_fe, col ="grey90")
mf_map(nc_fe[51, ], add = TRUE, col = "grey40")
```

<img src="man/figures/README-example-2.png" width="100%" />

A more detailed example:

``` r
library(sf)
library(fisheye)
library(mapsf)

# data import
ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
nc <- st_transform(ncraw, 3857)
center <- st_centroid(st_geometry(nc[51, ]))


buf_size <- c(
  seq(100,1000, 100),
  seq(1000,10000,1000),
  seq(10000, 100000, 10000)
)
lb <- vector("list", length(buf_size))
for (i in seq_along(lb)){
  lb[[i]] <- st_buffer(center, buf_size[i])
}
buf <- st_sf(geom = do.call(c, lb))


mf_init(nc)
mf_map(nc, col ="grey90", border = "white", add = TRUE)
mf_map(buf, add = TRUE, border = "red", col = NA, lwd = .4, lty = 3)
mf_map(buf[c(10,20,30), ], add = TRUE, border = "red", col = NA, 
       lwd = 1, lty = 1)
mf_map(center, pch = 20, add = TRUE)
for (i in c(20, 30)){
  text(x = st_coordinates(center)[1,1], 
       y = st_bbox(buf[i, ])[4], 
       labels = paste0(round(buf_size[i]/1000, 0),  "km")
  )
}
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r

buffe <- fisheye(buf, centre = center, method = "log", k = 1)
ncfe  <- fisheye(nc, centre = center, method = "log", k = 1)
mf_init(buffe)
mf_map(ncfe, add = TRUE)
mf_map(buffe, add = TRUE, border = "red", col = NA, lwd = .4, lty = 3)
mf_map(buffe[c(1,10,20,30), ], add = TRUE, border = "red", col = NA, 
       lwd = 1, lty = 1)
points(0,0,pch = 20)
for (i in c(1,10,20,30)){
  text(x = 0, 
       y = st_bbox(buffe[i, ])[4], 
       labels = paste0(signif(buf_size[i]/1000, 0),  "km")
  )
}
```

<img src="man/figures/README-unnamed-chunk-2-2.png" width="100%" />

An even more detailed example:
![](https://raw.githubusercontent.com/rCarto/fisheye-example/main/gif/mob.gif)
<https://rcarto.github.io/fisheye-example/>

## References

Hägerstrand, T. (1957) Migration and Area: A Survey of a Sample of
Swedish Migration Fields and Hypothetical Considerations of their
Genesis, Lund Studies in Geography, Series B, Human Geography,
Department of Geography, University of Lund, Lund.

[Boutoura, Chryssoula & Tsioukas, Vassileios & Tsorlini, Angeliki.
(2012). Experimenting “fisheye-lens functions” in studying digitally
particular historic maps. e-Perimetron (ISSN 1790 - 3769). 7.
111-123.](http://www.e-perimetron.org/Vol_7_3/Boutoura_et_al.pdf)

Rivière, Philippe. (2018). The Log-Azimuthal projection.
<https://observablehq.com/@fil/log-azimuthal>

Matthew Roughan. (2017). Log-azimuthal maps.
<https://roughan.info/math/log-az/>
