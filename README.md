
# fisheye <img src="man/figures/logo.png" align="right" width="140"/>

<!-- badges: start -->

![CRAN version](https://www.r-pkg.org/badges/version-ago/fisheye)
[![codecov](https://codecov.io/gh/riatelab/fisheye/branch/main/graph/badge.svg)](https://app.codecov.io/gh/riatelab/fisheye?branch=main)
[![R-CMD-check](https://github.com/riatelab/fisheye/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/riatelab/fisheye/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of fisheye is to create base maps focusing on a specific
location using an azimuthal logarithmic distance transformation.

## Installation

You can install the released version of `fisheye` from
[CRAN](https://cran.r-project.org/package=fisheye) with:

``` r
install.packages("fisheye")
```

Alternatively, you can install the development version of `fisheye` from
GitHub with:

``` r
remotes::install_github("riatelab/fisheye")
```

## Example

This is a basic example:

``` r
library(sf)
#> Linking to GEOS 3.11.1, GDAL 3.6.2, PROJ 9.1.1; sf_use_s2() is TRUE
library(fisheye)
library(mapsf)
# Import dataset
ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
nc <- st_transform(ncraw, 3857)
par(mfrow = c(1,2))
mf_map(nc, col ="grey90")
mf_map(nc[51, ], add = TRUE, col = "grey40")
mf_title("Original Map")
# transform the basemap
nc_fe  <- fisheye(nc, centre = nc[51, ])
mf_map(nc_fe, col ="grey90")
mf_map(nc_fe[51, ], add = TRUE, col = "grey40")
mf_title("Log-Azimuthal Projection")
```

<img src="man/figures/README-example-1.png" width="100%" />

<img src="man/figures/README-example2-1.png" width="100%" />

See a more detailed example
[here](https://github.com/rcarto/fisheye-example/):

![](https://raw.githubusercontent.com/rCarto/fisheye-example/main/gif/mob.gif)

## References

- Hägerstrand, T. (1957). Migration and Area: A Survey of a Sample of
  Swedish Migration Fields and Hypothetical Considerations of their
  Genesis. Lund Studies in Geography, Series B, Human Geography,
  Department of Geography, University of Lund, Lund.

- Snyder, J.P. (1987). “Magnifying-Glass” Azimuthal Map Projections. The
  American Cartographer, 14:1, 61-68,
  <https://doi.org/10.1559/152304087783875318>

- Fairbairn, D., & Taylor, G. (1995). Developing a variable-scale map
  projection for urban areas. Computers & Geosciences, 21:9, 1053-1064,
  <https://doi.org/10.1016/0098-3004(95)00041-6>

- Boutoura, C., Tsioukas, V., & Tsorlini, A. (2012). Experimenting
  “fisheye-lens functions” in studying digitally particular historic
  maps. e-Perimetron (ISSN 1790 - 3769). 7. 111-123.
  <http://www.e-perimetron.org/Vol_7_3/Boutoura_et_al.pdf>

- Roughan, M. (2017). Log-azimuthal maps.
  <https://roughan.info/math/log-az/>

- Rivière, P. (2018). The Log-Azimuthal projection.
  <https://observablehq.com/@fil/log-azimuthal>

- Jansen, T. (2018). “Magnifying-Glass” projections.
  <https://observablehq.com/@toja/magnifying-glass-projections>

- Sahasrabuddhe, R., Lambiotte, R., & Alessandretti, L. (2021). From
  centre to centres: polycentric structures in individual mobility.
  <https://arxiv.org/pdf/2108.08113.pdf>
