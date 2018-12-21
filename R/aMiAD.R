aMiAD <-
function(alpha, Y, cov=NULL, model = c("gaussian", "binomial"), n.perm = 5000) {
	if (is.null(cov)) {
        r <- Y - mean(Y)
    } else {
        fit <- glm(Y ~ cov, family = model)
        res <- Y - fitted.values(fit)
        r <- res - mean(res)
    }
    r.s <- list()
    for (j in 1:n.perm) {
        r.s[[j]] <- r[shuffle(length(r))]
    }
	Us <- r%*%alpha
	U0s <- lapply(apply(sapply(r.s, function(x) return(x%*%alpha)), 1, list),unlist)
	pvs <- mapply(function(x,y) length(which(abs(x) > abs(y)))/n.perm, U0s, as.list(Us))
	means <- sapply(U0s, mean)
	vars <- sapply(U0s, var)
	ind.min <- sample(c(which(pvs == min(pvs)),which(pvs == min(pvs))),1)
	W <- (Us[ind.min]- means[ind.min])/sqrt(vars[ind.min])
	T <- min(pvs)
	T0 <- rep(NA, n.perm)
	W0 <- rep(NA, n.perm)
	Ts <- lapply(r.s, function(x) x%*%alpha)
	T0s <- sapply(r.s, function(x) x%*%alpha)
	for (l in 1:n.perm) {
		Ts.each <- as.list(Ts[[l]])
		T0s.rem <- lapply(apply(T0s[,-l], 1, list),unlist)
		pvs.T <- mapply(function(x,y) length(which(abs(x) > abs(y)))/(n.perm-1), T0s.rem, Ts.each)
		means.0 <- sapply(T0s.rem, mean)
		vars.0 <- sapply(T0s.rem, var)
		ind.min.0 <- sample(c(which(pvs.T == min(pvs.T)),which(pvs.T == min(pvs.T))),1)
		W0[l] <- (Ts.each[[ind.min.0]]- means.0[ind.min.0])/sqrt(vars.0[ind.min.0])
		T0[l] <- pvs.T[ind.min.0]
	}
	pv.opt <- length(which(T0 < T))/n.perm
	amidives <- (W-mean(W0))/sqrt(var(W0))
	ItembyItem.out <- as.data.frame(t(rbind(pvs, Us, means, sqrt(vars))))
	midives <- apply(ItembyItem.out,1,function(x)(x[2]-x[3])/x[4])
	ItembyItem.out <- cbind(ItembyItem.out, midives)
	rownames(ItembyItem.out) <- colnames(alpha)
	colnames(ItembyItem.out) <- c("p-value", "U", "Mean(Null)", "SE(NULL)", "MiDivES")
	aMiAD.out <- c(pv.opt, W, mean(W0), sqrt(var(W0)), amidives)
	names(aMiAD.out) <- c("p-value", "W", "Mean(Null)", "SE(NULL)", "aMiDivES")
	return(list(ItembyItem.out = ItembyItem.out, aMiAD.out = aMiAD.out))	
}
