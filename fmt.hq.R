'fmt.hq' <- function(x) {

   # Format habitat quality data
   # B. Compton, 17 Jul 2023




 #  x$df <- rep(0:2, dim(x)[1])[1:(dim(x)[1])]   # fill in missing data with random shit
 #  x$ws <- rep(0:1, dim(x)[1])[1:(dim(x)[1])]



   f <- factor(x$hq, labels = c('General habitat quality', 'High habitat quality', 'Highest habitat quality'))
   g <- c(ifelse(x$cw, 'Coldwater stream', ''),
          ifelse(x$df == 1, 'Accessible diadramous fish run', ''),
          ifelse(x$df == 2, 'Inaccessible diadramous fish run', ''),
          ifelse(x$ws, 'Wild and Scenic river', ''),
          ifelse(x$acec, 'ACEC', ''),
          ifelse(x$bm, 'BioMap aquatic core', ''))
   g <- matrix(g, dim(x)[1], 6)
   #h <- apply(g, 1, FUN = paste, collapse = ',')
   a <- c(as.list(as.data.frame(g)), list(sep = ','))
   h <- do.call(paste, args = a)

   h <- gsub(',+', ', ', h)
   h <- gsub('^, |, $', '', h)

   # h <- gsub(',+', ', ', h)
   # h <- gsub('^, ', '', h)
   # h <- gsub(', $', '', h)
   # h <- paste0('(', h, ')')
   h <- paste0('<p style="color: gray">(', h, ')</p>')

   z <- paste0('<strong>Stream</strong><br/>', f, '<br/>', h) |>
      lapply(htmltools::HTML)

   return(z)
}
