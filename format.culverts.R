'format.culverts' <- function(x) {

   # Format popup for culverts
   # Specifically for DEPMEP project
   # Args:
   #     x     sf object for culverts or streams with hq and component fields
   # Result:
   #     formatted culverts popup for Leaflet
   # B. Compton, 18 Jul 2023



   #####
   x$hq <- sample(1:3, dim(x)[1], replace = TRUE)  # make up a bunch of fake data ****** FOR TESTING ***********
   x$cw <- sample(0:1, dim(x)[1], replace = TRUE)
   x$df <- sample(0:2, dim(x)[1], replace = TRUE)
   x$ws <- sample(0:1, dim(x)[1], replace = TRUE)
   x$acec <- sample(0:1, dim(x)[1], replace = TRUE)
   x$bm <- sample(0:1, dim(x)[1], replace = TRUE)

   x$rp <- sample(1:5, dim(x)[1], replace = TRUE)
   x$cl <- sample(1:100, dim(x)[1], replace = TRUE)
   x$cwcl <- sample(1:100, dim(x)[1], replace = TRUE)

   x$mep <- sample(1:8, dim(x)[1], replace = TRUE)

   x$xycode <- 'xy4127968670187835'
   #####



   x[, c('long', 'lat')] <- round(st_coordinates(x), 4)     # pull lat-long


   z <- paste0('<h4>Culvert/bridge</h4>MEP factor: ') |>
      paste0(factor(x$mep, levels = 1:8,
                    labels = c('baseline', paste0(c(10, 15, 20, 25, 30, 40, 50), '% above baseline'))), '</p>') |>
      paste0('<p>',
             factor(x$rp, levels = 1:5,
                    labels = c('Other restoration potential',
                               paste0(c('Highest', 'Very high', 'High', 'Medium'), ' restoration potential')))) |>
      paste0('<br/><span style="color: gray">Critical Linkages percentile: ', x$cl,
             '<br/>Coldwater Critical Linkages percentile: ', x$cwcl, '</span></p>') |>
      paste0('<p>', fmt.hq(x), '</p>') |>
      paste0('<p style="color: gray">XYcode: ', x$xycode, '<br/>Lat-long: ', x$lat, ', ', x$long, '</p>') |>
      lapply(htmltools::HTML)

   return(z)
}
