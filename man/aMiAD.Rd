\name{aMiAD}
\alias{aMiAD}
\title{
Adaptive Microbiome Alpha-diversity-based Association Analysis
}
\description{
This function tests the association between microbial diversity in a community and a host trait of interest with or without covariate adjustments (e.g., age and gender). For the host trait of interest, a continuous (e.g., BMI) or binary (e.g., disease status, treatment/placebo) trait can be handled.
}
\usage{
aMiAD(alpha, Y, cov = NULL, model = c("gaussian", "binomial"), n.perm = 5000)
}
\arguments{
  \item{alpha}{
A matrix for alpha-diversity metrics. Format: rows are samples and columns are alpha-diversity metrics (See ?Alpha.Diversity).
}
  \item{Y}{
A numeric vector for a continuous or a binary trait of interest.
}
  \item{cov}{
A matrix (or vector) for covariate adjustment(s). Format: rows are samples and columns are covariate variables. Default is Null.
}
  \item{model}{
"gaussian" is for a continuous trait and "binomial" is for a binary trait.
}
  \item{n.perm}{
The number of permutations. Default is 5000.
}
}
\value{
$ItembyItem.out - Item-by-item α-diversity-based association analyses. 

$aMiAD.out - aMiAD. 'p-value' and 'aMiDivES' are the p-value and microbial diversity effect score estimated by aMiAD.  

* Hypothesis testing - 'p-value < 0.05' indicates that microbial diversity is statistically significantly associated with a host trait.

* Effect estimation - 'aMiDivES' represents the effect direction and size of the microbial diversity on a host trait. 'aMiDivES > 0' and 'aMiDivES < 0'indicate positive and negative associations, respectively (e.g., if a binary trait is coded as 0 for the non-diseased population and 1 for the diseased population and 'aMiDivES < 0', aMiAD estimates that the diseased population has lower microbial diversity than the non-diseased population.
}
\references{
Koh H. An adaptive microbiome alpha-diversity-based association analysis method. Sci Rep 2018; 8(18026) 
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
# in 'phyloseq' (https://joey711.github.io/phyloseq/) to control varying 
# total reads per sample. This implementation is recommended.
set.seed(100)
rare.biom <- rarefy_even_depth(sim.biom, rngseed=TRUE)

# Create alpha-diversity metrics 
alpha <- Alpha.Diversity(sim.biom)

# Import a binary trait and covariate adjustments.
y <- sample_data(sim.biom)$y
x1 <- sample_data(sim.biom)$x1
x2 <- sample_data(sim.biom)$x2

# Run aMiAD
fit <- aMiAD(alpha, y, cov=cbind(x1,x2), model = "binomial")
fit

# Plot aMiAD
aMiAD.plot(fit, filename = "Figure1A.pdf", fig.title = "A")

}
