# DEPMEP.prep
# Prepare streams data for DEPMEP. Run this on my laptop. Takes 10-15 min.
# We can't run modern R code on the cluster, so the files have to be copied locally first.
# Source:
#     massachusetts.shp       state outline
#     streams_5a.shp          Ethan's streams with attributes, dissolved (see note)
#     crossings.shp           Ethan's road-stream crossings, with attributes
# Results:
#     d:\depmep\results\streams.shp
#     d:\GIS\DEPMEP\results\crossings.shp
# Note: *** before running this with fresh data from Ethan, load streams_5.shp into ArcGIS Pro
#           and dissolve on all fields (both options turned off)
# B. Compton, 24 Aug 2023



library(sf)
source('reproject_vectors.R')


# ----- 1. Clip to state boundaries

mass <- st_read('d:/GIS/DEPMEP/source/massachusetts.shp')
mass2 <- st_buffer(mass, -100)
streams <- st_read('d:/GIS/DEPMEP/source/streams_5a.shp')
streams <- st_intersection(streams, mass2)
streams[c('MASS', 'COUNT', 'AREA', 'PERIMETER', 'HECTARES', 'STATE_NAME')] <- list(NULL)  # drop columns from mass


# ----- 2. Simplify

streams <- st_simplify(streams, dTolerance = 10)
st_write(streams, 'd:/GIS/DEPMEP/working/streams.shp', delete_layer = TRUE)


# ----- 3. Reproject streams to web Mercator

reproject_vectors('d:/GIS/DEPMEP/streams.shp', 'd:/GIS/DEPMEP/results/streams.shp', mvt = TRUE)


# ----- 4. Reproject crossings to web Mercator

reproject_vectors('d:/GIS/DEPMEP/working/crossings.shp', 'd:/GIS/DEPMEP/results/crossings.shp', mvt = TRUE)
cat('d:\\GIS\\DEPMEP\\results\\streams.shp and d:\\GIS\\DEPMEP\\results\\crossings.shp are ready to be
    moved to the GeoServer.\n')
