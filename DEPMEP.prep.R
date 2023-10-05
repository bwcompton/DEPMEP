'DEPMEP.prep' <- function(streamsfile = 'streams_5a.shp', crossingsfile = 'depmep_points_preliminary.shp',
                          streams = TRUE, crossings = TRUE) {

   # DEPMEP.prep: Prepare streams data for DEPMEP
   # *** Run this on my laptop (takes 10 min for streams, 1 min for crossings) ***
   # We can't run modern R code on the cluster, so the files have to be copied locally first,
   # from  x:/Projects/DEP_Prep/Final/ to d:/GIS/DEPMEP/source/. Attend to ever-changing file names.
   # Source: (d:/GIS/DEPMEP/source/)
   #     massachusetts.shp       state outline
   # Arguments:
   #     streamsfile             Ethan's streams with attributes, dissolved (see note)
   #     crossingsfile           Ethan's road-stream crossings, with attributes
   #     streams                 if TRUE, process streams
   #     crossings               if TRUE, process crossings
   # Results: (d:/GIS/DEPMEP/results/)
   #     streams.shp
   #     crossings.shp
   #
   # Note: *** before running this with fresh streams data from Ethan, load streams shapefile into ArcGIS Pro
   #           and dissolve on fields cw, df, ws, acec, and bm (both options turned off)
   #
   # After running, use SFTP to delete the shapefiles in the DEPMEP folder on the GeoServer, then copy the shapefiles
   # to the DEPMEP folder. Deleting the files first seems to force the GeoServer to push the changes. You may need to
   # do Layers > (crossings or streams) > Reload feature type ... it's inconsistent. If you have to recreate the
   # layers, make sure Layers > (crossings or steams) > Tile Caching > application/vnd.mapbox-vector-tile is checked.
   #
   # B. Compton, 24 and 30-31 Aug 2023
   # 3 Oct 2023: add streams and crossings options



   library(sf)
   source('reproject_vectors.R')

   if(streams) {
      # ----- 1. Clip to state boundaries

      mass <- st_read('d:/GIS/DEPMEP/source/massachusetts.shp')
      mass2 <- st_buffer(mass, -100)
      streams <- st_read(paste0('d:/GIS/DEPMEP/source/', streamsfile))
      streams <- st_intersection(streams, mass2)
      streams[c('n_hq', 'MASS', 'COUNT', 'AREA', 'PERIMETER', 'HECTARES', 'STATE_NAME')] <- list(NULL)  # drop columns from mass and n_hq


      # ----- 2. Simplify

      # tol. total shapefile size
      # orig   40.2 MB
      # 1 m    20.6 MB  <-
      # 3 m    15.8 MB
      # 5 m    13.7 MB
      # 10 m   11.7 MB


      streams <- st_simplify(streams, dTolerance = 1)
      st_write(streams, 'd:/GIS/DEPMEP/working/streams.shp', delete_layer = TRUE)


      # ----- 3. Reproject streams to web Mercator

      reproject_vectors('d:/GIS/DEPMEP/working/streams.shp', 'd:/GIS/DEPMEP/results/streams.shp', mvt = TRUE)
   }

   if(crossings) {

      # ----- 4. Clean up columns in crossings

      culverts <- st_read(paste0('d:/GIS/DEPMEP/source/', crossingsfile))
      culverts[c('id', 'aquatic', 'cl_effect', 'cw_effect', 'n_hq')] <- list(NULL)    # drop columns we don't want
      st_write(culverts, 'd:/GIS/DEPMEP/working/crossings.shp', delete_layer = TRUE)


      # ----- 5. Reproject crossings to web Mercator

      reproject_vectors('d:/GIS/DEPMEP/working/crossings.shp', 'd:/GIS/DEPMEP/results/crossings.shp', mvt = TRUE)
   }

   cat(ifelse(streams, 'd:\\GIS\\DEPMEP\\results\\streams.shp', ''), ifelse(streams & crossings, ', and ', ''),
       ifelse(crossings, 'd:\\GIS\\DEPMEP\\results\\crossings.shp', ''),
       ifelse(streams & crossings, ' are', ' is'), ' ready to be posted on the GeoServer.\n', sep = '')
}
