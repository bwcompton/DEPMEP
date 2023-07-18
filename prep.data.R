# prep DEPMEP data for GeoServer
# B. Compton, 17 Jul 2023
# what a fucking mess--we can't run modern R code on the cluster, so the files have to be copied locally first
# copy X:\Projects\DEP_Prep\Intermediate\streams_05_FAKE.* d:\temp\



source('reproject_vectors.R')
library(sf)

reproject_vectors('d:/temp/streams_05_FAKE.shp', 'd:/temp/depmep_streams.shp', mvt = TRUE)
