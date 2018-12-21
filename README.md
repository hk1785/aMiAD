# R package: aMiAD

Title: Adaptive Microbiome α-diversity-based Association Analysis (aMiAD)

Version: 2.0

Date: 2018-10-21

Author: Hyunwook Koh

Maintainer: Hyunwook Koh <hkoh7@jhu.edu>

Description: This sofware package provides facilities for the implementation of aMiAD which tests the association between microbial diversity and a host trait of interest. For the host trait of interest, a continuous (e.g., BMI) or a binary (e.g., disease status, treatment/placebo) trait can be handled.

NeedsCompilation: No

Depends: R(>= 3.2.3)

License: GPL-2

URL: https://github.com/hk1785/aMiAD

## Reference

* Koh H. An adaptive microbiome alpha-diversity-based association analysis method. _Sci Rep_ 2018; 8(18026) 
* DOI: https://doi.org/10.1038/s41598-018-36355-7

## Prerequites

phyloseq
```
source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")
```
picante
```
install.packages("picante")
```
entropart
```
install.packages("entropart")
```
vegan
```
install.packages("vegan")
```

## Installation

```
library(devtools)
install_github("hk1785/aMiAD", force=T)
```

## Data format

```
library(phyloseq)
URL: https://joey711.github.io/phyloseq/
```

----------------------------------------------------------------------------------------------------------------------------------------

# Manual


## :mag: Alpha.Diversity

### Description
This function creates α-diversity metrics.

### Usage
```
Alpha.Diversity(phylo, metrics = c("Observed", "Shannon", "Simpson", "PD", "PE", "PQE"), Normalize=TRUE)
```

### Arguments
* _phylo_ - A microbiome data in [phyloseq](https://joey711.github.io/phyloseq/) format.
* _metrics_ - A vector of α-diversity metrics to be created. 'Observed', 'Shannon' (Shannon, 1948), 'Simpson' (Simpson, 1949), 'PD' (Faith, 1992), 'Chao1' (Chao, 1984), 'ACE' (Chao and Lee, 1992), 'PQE' (Rao, 1982; Warwick and Clarke, 1995) and 'PE' (Allen et al., 2009) are available α-diversity metrics. Default is c("Observed", "Shannon", "Simpson", "PD", "PE", "PQE").
* _Normalize_ - If TRUE (default), diversity is not affected by the height of the tree. If FALSE, it is proportional to the height of the tree.
 
### References

* Koh H. An adaptive microbiome alpha-diversity-based association analysis method. _Sci Rep_ 2018; 8(18026) 
* Allen B, Kon M, Bar-Yam Y. A new phylogenetic diversity measure generalizing the Shannon index and its application to phyllostomid bats. _Am Nat_ 2009; 174(2): 236-43.
* Chao A. Non-parametric estimation of the number of classes in a population. _Scand J Stat_ 1984; 11: 265-70.
* Chao A, Lee S. Estimating the number of classes via sample coverage. _J Am Stat Assoc_ 1992; 87: 210-17.
* Faith DP. Conservation evaluation and phylogenetic diversity. _Biol Conserv_ 1992; 61: 1-10.
* Rao CR. Diversity and dissimilarity coefficients: a unified approach. _Theor Popul Biol_ 1982; 21(1): 24-43.
* Shannon CE. A mathematical theory of communication. _Bell Syst Tech J_ 1948; 27: 379-423 and 623-56.
* Simpson EH. Measurement of diversity. _Nature_ 1949; 163(688).
* Warwick RM, Clarke KR. New 'biodiversity' measures reveal a decrease in taxonomic distinctness with increasing stress. _Mar Ecol Prog Ser_ 1995; 129(1): 301-5.

### Examples
Import requisite R packages
```
library(aMiAD)
library(phyloseq)
library(picante)
library(entropart)
library(vegan)
```
Import example microbiome data
```
data(sim.biom)
```
Rarefy the microbiome data using the function _rarefy_even_depth_ in [phyloseq](https://joey711.github.io/phyloseq/) to control varying total reads per sample. This implementation is recommended.
```
set.seed(100)
rare.biom <- rarefy_even_depth(sim.biom, rngseed=TRUE)
```
Create α-diversity metrics 
```
Alpha.Diversity(sim.biom)
```


## :mag: aMiAD

### Description
This function tests the association bettwen microbial diversity in a community and a host trait of interest with or without covariate adjustments (e.g., age and gender). For the host traits of interest, continuous (e.g., BMI) or binary (e.g., disease status, treatment/placebo) traits can be handled.

### Usage
```
aMiAD(alpha, Y, cov = NULL, model = c("gaussian", "binomial"), n.perm = 5000)
```

### Arguments
* _alpha_ - A matrix for α-diversity metrics. Format: rows are samples and columns are α-diversity metrics.
* _Y_ - A numeric vector for continuous or binary traits of interest.
* _cov_ - A matrix (or vector) for covariate adjustment(s). Format: rows are samples and columns are covariate variables. Default is Null.
* _model_ - "gaussian" is for a continuous trait and "binomial" is for a binary trait.
* _n.perm_ - The number of permutations. Default is 5000.

### Values
_$ItembyItem.out_ - Item-by-item α-diversity-based association analyses. 

_$aMiAD.out_ - aMiAD. 'p-value' and 'aMiDivES' are the p-value and microbial diversity effect score estimated by aMiAD.  
*Hypothesis testing - 'p-value < 0.05' indicates that microbial diversity is significantly associated with a host trait of interest.
*Effect score estimation - 'aMiDivES' represents the effect direction and size of the microbial diversity on a host trait. 'aMiDivES > 0' and 'aMiDivES < 0'indicate positive and negative associations, respectively (e.g., if a binary trait is coded as 0 for the non-diseased population and 1 for the diseased population and 'aMiDivES < 0', aMiAD estimates that the diseased population has lower microbial diversity than the non-diseased population.)

### References
* Koh H. An adaptive microbiome alpha-diversity-based association analysis method. _Sci Rep_ 2018; 8(18026) 

### Examples
Import requisite R packages
```
library(aMiAD)
library(phyloseq)
library(picante)
library(entropart)
library(vegan)
```
Import example microbiome data
```
data(sim.biom)
```
Rarefy the microbiome data using the function _rarefy_even_depth_ in [phyloseq](https://joey711.github.io/phyloseq/) to control varying total reads per sample. This implementation is recommended.
```
set.seed(100)
rare.biom <- rarefy_even_depth(sim.biom, rngseed=TRUE)
```
Create α-diversity metrics 
```
alpha <- Alpha.Diversity(sim.biom)
```
Import a binary trait and covariate adjustments
```
y <- sample_data(sim.biom)$y
x1 <- sample_data(sim.biom)$x1
x2 <- sample_data(sim.biom)$x2
```
Run aMiAD
```
fit <- aMiAD(alpha, y, cov = cbind(x1,x2), model = "binomial")
```
Plot aMiAD
```
aMiAD.plot(fit, filename = "Figure1A.pdf", fig.title = "")
```
