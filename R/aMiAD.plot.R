aMiAD.plot <-
function (fit, filename = "filename.pdf", fig.title = "figtitle") 
{
    out <- as.data.frame(rbind(round(fit$ItembyItem.out[, c(1, 
        5)], 3), round(fit$aMiAD.out[c(1, 5)], 3)))
    es <- out[, 2]
    ind.neg <- which(es < 0)
    ind.pos <- which(es >= 0)
    cols <- rep(NA, length(es))
    cols[ind.neg] <- "lightgreen"
    cols[ind.pos] <- "lightpink"
    if (es[length(es)] < 0) 
        cols[length(es)] <- "green2"
    if (es[length(es)] >= 0) 
        cols[length(es)] <- "red2"
    pvs <- out[, 1]
    ind.zero <- which(pvs == 0)
    pvs[ind.zero] <- "<.001"
    names.arg.v <- c(paste("Richness\n", "(p:", pvs[1], ")", 
        sep = ""), paste("Shannon\n", "(p:", pvs[2], ")", sep = ""), 
        paste("Simpson\n", "(p:", pvs[3], ")", sep = ""), paste("PD\n", 
            "(p:", pvs[4], ")", sep = ""), paste("PE\n", "(p:", 
            pvs[5], ")", sep = ""), paste("PQE\n", "(p:", pvs[6], 
            ")", sep = ""), paste("aMiAD\n", "(p:", pvs[7], ")", 
            sep = ""))
    pdf(file = filename, width = 4, height = 3.5)
    par(mai = c(1.1, 0.7, 0.4, 0.2))
    par(oma = c(0, 0, 0.5, 0))
    barplot(es, names.arg = names.arg.v, ylim = c(-ceiling(max(abs(es)) * 
        1.1), ceiling(max(abs(es)) * 1.1)), col = cols, xpd = FALSE, 
        axes = TRUE, cex.names = 0.7, axis.lty = 1, ylab = "MiDivES", 
        space = 1, las = 2, tck = -0.02, cex.axis = 0.7, cex.lab = 0.7, 
        mgp = c(2, 1, 0), srt = 45)
    title(fig.title, adj = 0.06, outer = TRUE, line = -1, cex.main = 1.5)
    graphics.off()
}
