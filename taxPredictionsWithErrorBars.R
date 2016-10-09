k <- "Closest.Homolog.Phylum" #species column for which to do the species breakdown/analysis

matr <- table(tb[,k],tb[,2])

matr <- sweep(matr, 2, colSums(matr), "/")


#par(mar=c(15,6,4,1)+.5)
#boxplot(t(matr[which(maxPerTaxa > 0.03),]),las=3,cex=0.1)


# from http://davetang.org/muse/2014/06/25/plotting-error-bars-with-r/
error.bar <- function(x, y, upper, lower=upper, length=0.1,...){
   if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper))
   stop("vectors must be same length")
   arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

sem <- function(x){
  sd(x)/sqrt(length(x))
}


matr <- matr * 100 #convert to percentage

sems <- apply(matr,1,sem) #standard errors of the means

sds <- apply(matr,1,sd) # standard deviations

cis <- sems * 1.96

means <- apply(matr,1,mean) 

n <- 20 #will plot top twenty most abundant

plotlist <- rev(order(means))[1:n]

par(mar=c(15,6,4,1)+.5)

barx <- barplot(means[plotlist],
                names.arg=rownames(matr)[plotlist],
                ylim=c(0,max(means[plotlist])+10),
                xlab=NA,
                ylab='Abundance (percentage)',
                las=3,
                cex.names=0.7
                )
                
error.bar(barx, means[plotlist], cis[plotlist])  # plotting 95% confidence intervals, just change cis to sems or sds if you want them
