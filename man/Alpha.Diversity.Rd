\name{Alpha.Diversity}
\alias{Alpha.Diversity}
\title{
Alpha diversity
}
\description{
This function creates alpha-diversity metrics.
}
\usage{
Alpha.Diversity(phylo, metrics = c("Observed", "Shannon", "Simpson", "PD", "PE" ,"PQE"), Normalize=TRUE)
}
\arguments{
  \item{phylo}{
A microbiome data in 'phyloseq' format.
}
  \item{metrics}{
A vector of alpha-diversity metrics to be created. 'Observed', 'Shannon' (Shannon, 1948), 'Simpson' (Simpson, 1949), 'PD' (Faith, 1992), 'Chao1' (Chao, 1984), 'ACE' (Chao and Lee, 1992), 'PQE' (Rao, 1982; Warwick and Clarke, 1995) and 'PE' (Allen et al., 2009) are available alpha-diversity metrics. Default is c("Observed", "Shannon", "Simpson", "PD", "PE", "PQE").
}
  \item{Normalize}{
If TRUE (default), diversity is not affected by the height of the tree. If FALSE, it is proportional to the height of the tree.
}
}
\references{
Koh H. An adaptive microbiome alpha-diversity-based association analysis method. Sci Rep 2018; 8(18026) 

Allen B, Kon M, Bar-Yam Y. A new phylogenetic diversity measure generalizing the Shannon index and its application to phyllostomid bats. Am Nat 2009; 174(2): 236-43.

Chao A. Non-parametric estimation of the number of classes in a population. Scand J Stat 1984; 11: 265-70.

Chao A, Lee S. Estimating the number of classes via sample coverage. J Am Stat Assoc 1992; 87: 210-17.

Faith DP. Conservation evaluation and phylogenetic diversity. Biol Conserv 1992; 61: 1-10.

Rao CR. Diversity and dissimilarity coefficients: a unified approach. Theor Popul Biol 1982; 21(1): 24-43.

Shannon CE. A mathematical theory of communication. Bell Syst Tech J 1948; 27: 379-423 and 623-56.

Simpson EH. Measurement of diversity. Nature 1949; 163(688).

Warwick RM, Clarke KR. New 'biodiversity' measures reveal a decrease in taxonomic distinctness with increasing stress. Mar Ecol Prog Ser 1995; 129(1): 301-5.
}
\author{
Hyunwook Koh
}

\examples{
library(phyloseq)
library(picante)
library(entropart)
library(vegan)

# Import example microbiome data
data(sim.biom)

# Rarefy the microbiome data using the function, rarefy_even_depth, 
# in 'phyloseq' (https://joey711.github.io/phyloseq/) due to control varying 
# total reads per sample. This implementation is recommended.
set.seed(100)
rare.biom <- rarefy_even_depth(sim.biom, rngseed=TRUE)

# Create alpha-diversity metrics 
Alpha.Diversity(sim.biom)

}
