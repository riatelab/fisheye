
# fisheye <img src="man/figures/logo.png" align="right" width="140"/>

<!-- badges: start -->

![CRAN version](https://www.r-pkg.org/badges/version-ago/fisheye)
![R-CMD-check](https://github.com/riatelab/fisheye/workflows/R-CMD-check/badge.svg)
[![codecov](https://codecov.io/gh/riatelab/fisheye/branch/main/graph/badge.svg)](https://app.codecov.io/gh/riatelab/fisheye?branch=main)

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
library(fisheye)
library(mapsf)
#> Le chargement a nécessité le package : sf
#> Linking to GEOS 3.9.0, GDAL 3.2.2, PROJ 7.1.0; sf_use_s2() is TRUE
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

|                                                                                                                                                                                                                         |                                                                                                                                                                                                                                                         |                 |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------|
| <img src="https://www.researchgate.net/profile/Alan-Werritty/publication/233273202/figure/fig4/AS:551042708238336@1508390227134/Map-with-azimuthal-logarithmic-distance-scale-Bunge-1962-p-54-Source.png" width="300"/> | Hägerstrand, T. (1957). Migration and Area: A Survey of a Sample of Swedish Migration Fields and Hypothetical Considerations of their Genesis. Lund Studies in Geography, Series B, Human Geography, Department of Geography, University of Lund, Lund. |                 |
| <img src="https://indiemaps.com/images/lensTool/snyderMagnifyingGlass.png" width="300"/>                                                                                                                                | Snyder, J.P. (1987). “Magnifying-Glass” Azimuthal Map Projections. The American Cartographer, 14:1, 61-68, DOI: 10.1559/152304087783875318                                                                                                              |                 |
| <img src="https://www.researchgate.net/profile/Angeliki-Tsorlini/publication/281551626/figure/fig4/AS:284635918553100@1444873900134/Argentoratum-Strasbourg-by-Conrad-Morant-1548.png" width="300"/>                    | Boutoura, C., Tsioukas, V., & Tsorlini, A. (2012). Experimenting “fisheye-lens functions” in studying digitally particular historic maps. e-Perimetron (ISSN 1790 - 3769). 7. 111-123.                                                                  | custom software |
| <img src="https://roughan.info/img/log_azimuthal.png" width="300"/>                                                                                                                                                     | Roughan, M. (2017). Log-azimuthal maps. <https://roughan.info/math/log-az/>                                                                                                                                                                             | MATLAB          |
| <img src="https://pbs.twimg.com/card_img/1480258248250957838/33fZ0EY7?format=jpg&amp;name=small" width="300"/>                                                                                                          | Rivière, P. (2018). The Log-Azimuthal projection. <https://observablehq.com/@fil/log-azimuthal>                                                                                                                                                         | javascript      |
| <img src="https://pbs.twimg.com/card_img/1481616883723952128/JjRbL0mx?format=jpg&amp;name=small" width="300"/>                                                                                                          | Jansen, T. (2018). “Magnifying-Glass” projections. <https://observablehq.com/@toja/magnifying-glass-projections>                                                                                                                                        | javascript      |
| <img src="https://pbs.twimg.com/media/E9o_YvcWQAYvT2s?format=jpg&amp;name=4096x4096" width="300"/>                                                                                                                      | Sahasrabuddhe, R., Lambiotte, R., & Alessandretti, L. (2021). From centre to centres: polycentric structures in individual mobility. arXiv preprint arXiv:2108.08113.                                                                                   | python          |
