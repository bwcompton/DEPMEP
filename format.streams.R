'format.streams' <- function(x) {

   # Format popup for streams
   # Specifically for DEPMEP project
   # Args:
   #     x     sf object for culverts or streams with hq and component fields
   # Result:
   #     formatted streams popup for Leaflet
   # B. Compton, 18 Jul 2023



   x$df <- rep(0:2, dim(x)[1])[1:(dim(x)[1])]   # fill in missing data with random shit ****** FOR TESTING ***********
   x$ws <- rep(0:1, dim(x)[1])[1:(dim(x)[1])]

   h <- fmt.hq(x)
   z <- paste0('<h4>Stream</h4>', h) |>
      lapply(htmltools::HTML)

   return(z)
}
