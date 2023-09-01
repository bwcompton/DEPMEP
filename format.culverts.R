'format.culverts' <- function(x) {

   # Format popup for culverts
   # Specifically for DEPMEP project
   # Args:
   #     x     sf object for culverts or streams with hq and component fields
   # Result:
   #     formatted culverts popup for Leaflet
   # B. Compton, 18 Jul 2023
   # 30 Aug 2023: change a couple of field names



   x[, c('long', 'lat')] <- round(st_coordinates(x), 4)     # pull lat-long

   z <- paste0('<h4>Culvert/bridge</h4>MEP factor: ') |>
      paste0(factor(x$mep, levels = 1:8,
                    labels = c('baseline', paste0(c(10, 15, 20, 25, 30, 40, 50), '% above baseline'))), '</p>') |>
      paste0('<p>',
             factor(x$rp, levels = 1:5,
                    labels = c('Restoration potential: other',
                               paste0(c('Medium', 'High', 'Very high', 'Highest'), ' restoration potential')))) |>
      paste0('<br/><span style="color: gray">Critical Linkages percentile: ', x$cl_pct,
             '<br/>Coldwater Critical Linkages percentile: ', x$cw_pct, '</span></p>') |>
      paste0('<p>', fmt.hq(x), '</p>') |>
      paste0('<p style="color: gray">XYcode: ', x$xycode, '<br/>Lat-long: ', x$lat, ', ', x$long, '</p>') |>
      lapply(htmltools::HTML)

   return(z)
}
