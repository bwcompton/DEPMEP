reproject_vectors <- function(from, to = from, mvt = FALSE) {

# Reproject vector data (with existing CRS) to Web Mercator
# Works with point, line, poly, or whatever
# Arguments:
#    from   source data
#    to     destination (default: replace source)
#	  mvt	   if TRUE, use epsg:900913; if FALSE, use epsg:3857
#			   they're actually the same projection
# B. Compton, 1 and 8 Jun 2023
# 17 Jul 2023: add mvt option



   epsg <- ifelse(mvt, '900913', '3857')

   st_read(from) |>
   st_transform(st_crs(paste0('+init=epsg:', epsg))) |>
         st_write(to, delete_layer = TRUE)
}



# reproject_vectors('d:/gis/towns.shp', 'd:/gis/forLeaflet/towns.shp')
# reproject_vectors('d:/gis/massachusetts.shp', 'd:/gis/forLeaflet/massachusetts.shp')
# reproject_vectors('d:/gis/ecoregions.shp', 'd:/gis/forLeaflet/ecoregions.shp')
# reproject_vectors('d:/gis/watersheds.shp', 'd:/gis/forLeaflet/watersheds.shp')


