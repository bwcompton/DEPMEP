'fmt.hq' <- function(x) {

   # Format habitat quality data to insert into popups
   # Specifically for DEPMEP project
   # Args:
   #     x     sf object for culverts or streams with hq and component fields
   # Result:
   #     hq score over hq components, in need of HTML rendering
   # B. Compton, 17-18 Jul 2023



   f <- factor(x$hq, levels = 1:3, labels = c('General habitat quality', 'High habitat quality', 'Highest habitat quality'))
   g <- cbind(
      ifelse(x$bm, 'BioMap aquatic core', ''),
      ifelse(x$cw, 'Coldwater fisheries resource', ''),
      ifelse(x$df == 1, 'Accessible diadramous fish run', ''),
      ifelse(x$df == 2, 'Inaccessible diadramous fish run', ''),
      ifelse(x$acec, 'ACEC', ''),
      ifelse(x$ws, 'Wild and Scenic river', '')
   )

   a <- c(as.list(as.data.frame(g)), list(sep = ','))
   h <- do.call(paste, args = a)
   h <- gsub(',+', ', ', h)
   h <- gsub('^, |, $', '', h)
   h <- ifelse(x$hq == 1, '', paste0('<br/><span style="color: gray">(', h, ')</span>'))

   return(paste0(f, h))
}
