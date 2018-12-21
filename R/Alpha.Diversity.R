Alpha.Diversity <-
function(phylo, metrics=c("Observed", "Shannon", "Simpson", "PD", "PE", "PQE"), Normalize=TRUE) {
	alpha.div.nopd <- estimate_richness(phylo, split = TRUE) 
	tot.reads <- apply(as.data.frame(otu_table(phylo)),1,sum)
	com.tab <- as.data.frame(otu_table(phylo))/tot.reads  
	if (Normalize) {
		PD <- apply(com.tab, 1, function(x) AllenH(x, 0, phy_tree(phylo)))
		PE <- apply(com.tab, 1, function(x) AllenH(x, 1, phy_tree(phylo)))
		PQE <- apply(com.tab, 1, function(x) AllenH(x, 2, phy_tree(phylo)))
	} else {
		PD <- pd(as.data.frame(otu_table(phylo)),phy_tree(phylo))
		PE <- apply(com.tab, 1, function(x) AllenH(x, 1, phy_tree(phylo), Normalize=FALSE))
		PQE <- apply(com.tab, 1, function(x) AllenH(x, 2, phy_tree(phylo), Normalize=FALSE))
	}
	alpha.div <- t(cbind(cbind(cbind(alpha.div.nopd,PD),PQE),PE))
	alpha.div <- t(alpha.div[metrics,])
	return(alpha.div)
}
