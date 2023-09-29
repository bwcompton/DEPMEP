'format.culverts' <- function(x) {

   # Format popup for culverts
   # Specifically for DEPMEP project
   # Args:
   #     x     sf object for culverts or streams with hq and component fields
   # Result:
   #     formatted culverts popup for Leaflet
   # B. Compton, 18 Jul 2023
   # 30 Aug 2023: change a couple of field names
   # 21 Sep 2023: crazy new way of displaying percentiles
   # 29 Sep 2023: new display format: rearrange and add link to NAACC survey



   x[, c('long', 'lat')] <- round(st_coordinates(x), 4)     # pull lat-long

   cl <- cut(101 - x$cl_pct, breaks = c(0, 5, 10, 20, 25, 101), labels = c(5:2, 0), right = FALSE)
   cw <- cut(101 - x$cw_pct, breaks = c(0, 10, 20, 30, 40, 101), labels = c(5:2, 0), right = FALSE)

   clt <- cut(101 - x$cl_pct, breaks = c(0, 5, 10, 20, 25), labels = c('top 5%', 'top 5-10%', 'top 10-20%',
                                                                           'top 20-25%'), right = FALSE)
   cwt <- cut(101 - x$cw_pct, breaks = c(0, 10, 20, 30, 40), labels = c('top 10%', 'top 10-20%',
                                                                            'top 20-30%','top 30-40%'), right = FALSE)


   z <- paste0('<h4>Culvert/bridge</h4>MEP factor: ') |>
      paste0(factor(x$mep, levels = 1:8,
                    labels = c('baseline', paste0(c(10, 15, 20, 25, 30, 40, 50), '% above baseline'))), '</p>') |>

      paste0('<p>',
             factor(x$rp, levels = 1:5,
                    labels = c('Restoration potential: other',
                               paste0(c('Medium', 'High', 'Very high', 'Highest'), ' restoration potential')))) |>
      paste0('<span style="color: gray">',
             ifelse(x$rp == cl, paste0('<br/>Critical Linkages: ', clt), ''),
             ifelse(x$rp == cw, paste0('<br/>Coldwater Critical Linkages: ', cwt), ''),
             '</span></p>') |>

      paste0('<p>', fmt.hq(x), '</p>') |>

      paste0('<span style="color: gray">Critical Linkages percentile: ', x$cl_pct,
             '<br/>Coldwater Critical Linkages percentile: ', x$cw_pct, '</span>') |>
      paste0('<br/><span style="color: gray">XYcode: ', x$xycode, '<br/>Lat-long: ', x$lat, ', ', x$long, '</span>') |>
      paste0('<br/><br/><a href="https://naacc.org/naacc_display_crossing.cfm?aqId=88233"
             target="_blank" rel="noopener noreferrer">NAACC survey</a>') |>
      lapply(htmltools::HTML)

   return(z)
}
