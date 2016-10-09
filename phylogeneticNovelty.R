k <- "Closest.Homolog.Genus"

print("Removing...")
which(table(tb[,k]) < 10)

for (d in names(which(table(tb[,k]) < 10)))
{
	tb <- tb[-which(tb[,k] == d),]
}

tb[,k] <- as.character(tb[,k])

tb[,k] <- with(tb,reorder(tb[,k], X.id.of.Closest.Homolog,median))

par(mfrow=c(2,1))
plot(tb[,"X.id.of.Closest.Homolog"] ~ tb[,k],las=3,cex.axis=0.5,xlab=NA)
