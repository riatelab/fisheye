#' @title fisheye
#' @description This function transform an sf layer with a fisheye
#' transformation. Several methods are available. This is a visualisation
#' method that should not be used for geospatial calculation (area,
#' distances...).
#' The output sf object has no CRS as it is not relevant.
#'
#'
#' @param x an sf object (POINT, LINESTRING, MULTILINESTRING, POLYGON,
#' MULTIPOLYGON) to be transformed. This object needs to be projected
#' (no lon/lat).
#' @param centre an sf object, the center of the transformation. This object
#' must use the same projection as x.
#' @param method transfomation method, either 'log' or 'sqrt'. See Details.
#' @param k integer, factor to adjust the log transformation, higher values
#' soften the deformation. See Details.
#'
#' @details
#' The 'log' method transforms distances to \code{center} with:
#' \eqn{{d}' = \log(1 + 10^{-k} * d)}{%
#'  d' = log(1 + 10^(-k) * d)}
#' \cr
#' The 'sqrt' method transforms distances to \code{center} with:
#'  \eqn{{d}' = \sqrt(d)}{%
#'  d' = sqrt(d)}
#'
#' @return A transformed sf object is returned.
#' @importFrom sf st_coordinates st_centroid st_geometry st_geometry_type
#' st_linestring st_point st_crs st_crs<- st_geometry<-
#' @export
#'
#' @examples
#' library(sf)
#' ncraw <- st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
#' nc <- st_transform(ncraw, 3857)
#' ncfe <- fisheye(nc, centre = nc[100, ], method = 'log', k = 4)
#' plot(st_geometry(ncfe), col = "grey70", lwd = .2)
#' plot(st_geometry(ncfe[100,]), col = NA, lwd = 2, border = "red", add = TRUE)
fisheye <- function(x, centre, method = "log", k = 1){




  # center geometries around center
  centre <- st_coordinates(st_centroid(st_geometry(centre)))
  geom <- st_geometry(x)
  geom <- geom - c(centre[1], centre[2])
  pts <- st_coordinates(geom)




  # original distance
  dist <- sqrt((pts[,"X"]^2) + (pts[,"Y"]^2))
  # angle
  ta <- atan(pts[,"Y"] / pts[,"X"])


  # modified distances
  if (method == 'sqrt'){
    d <- sqrt(dist)
  } else if (method =="log"){
    # d <- log(1 + dist + min(dist)*2)
    d <- log(1 + 10^(-k) * dist)

  } else {
    stop("method should be either 'log' or 'sqrt'",
         call. = FALSE)
  }

  # get new coordinates
  sx <- sign(pts[,"X"])
  sx[sx==0] <- 1
  pts[,"X"] <- d * cos(ta) * sx
  pts[,"Y"] <- d * sin(ta) * sx



  # asigned new coordinates
  gtype <- st_geometry_type(x, by_geometry = FALSE)

  if(gtype == "MULTIPOLYGON"){
    uu <- unique(pts[, c("L1", "L2", "L3")])
    for (i in 1:nrow(uu)){
      geom[[rev(uu[i, ])]] <- pts[pts[,"L1"]==uu[i,"L1"] &
                                              pts[,"L2"]==uu[i,"L2"] &
                                              pts[,"L3"]==uu[i,"L3"], 1:2]
    }
  }
  if(gtype %in% c("POLYGON", "MULTILINESTRING")){
    uu <- unique(pts[, c("L1", "L2")])
    for (i in 1:nrow(uu)){
      geom[[rev(uu[i, ])]] <- pts[pts[,"L1"]==uu[i,"L1"] &
                                              pts[,"L2"]==uu[i,"L2"], 1:2]
    }
  }
  if(gtype %in% c("LINESTRING")){
    uu <- unique(pts[, c("L1")])
    for (i in 1:length(uu)){
      geom[[uu[i]]] <- st_linestring(pts[pts[,"L1"]==uu[i], 1:2])
    }
  }
  if(gtype %in% c("POINT")){
    for (i in 1:nrow(x)){
      geom[[i]] <- st_point(pts[i, 1:2])
    }
  }

  st_geometry(x) <- geom

  # update bbox
  cc <- st_coordinates(x)
  xmin <- min(cc[,1])
  xmax <- max(cc[,1])
  ymin <- min(cc[,2])
  ymax <- max(cc[,2])
  new_bb <- c(xmin, ymin, xmax, ymax)
  attr(new_bb, "class") = "bbox"
  attr(st_geometry(x), "bbox") = new_bb
  st_crs(x) <- NA

  return(x)
}
