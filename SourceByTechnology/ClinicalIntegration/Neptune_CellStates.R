
library(genefilter)
neptuneTubEnsembl = read.table("NeptuneAdult_TubuloInterstialData.txt", sep = '\t', header = TRUE, row.names = 1, check.names = FALSE)
aPT = read.table("aPT.txt")
aTAL = read.table("aTAL.txt")
degenerative = read.table("Degenerative.txt")
adaptiveStromal = read.table("Stromal.txt")
aPTaTALcommon = read.table("aPT_aTAL_common.txt")
genes = row.names(neptuneTubEnsembl)
library(edgeR)
y <- DGEList(counts=neptuneTubEnsembl)
y <- calcNormFactors(y)
y$counts
y <- estimateDisp(y)
y <- DGEList(counts=neptuneTubEnsembl)
y <- calcNormFactors(y)
y <- estimateCommonDisp(y, verbose=T)
y <- estimateTagwiseDisp(y)
neptuneTubEnsembl = y$pseudo.counts
head(neptuneTubEnsembl)
randomgenes = sample(genes, size = 100, replace = FALSE)
neptTubrandom = neptuneTubEnsembl[row.names(neptuneTubEnsembl) %in% randomgenes,]
Dat<-(neptTubrandom-rowMeans(neptTubrandom))/rowSds(as.matrix(neptTubrandom))
Score<-colMeans(Dat, na.rm = TRUE)
Score<-as.data.frame(Score)
head(Score)
write.table(Score, file = "neptTubaRandomScore.txt", sep = '\t', quote = FALSE)
neptTubaStromal = neptuneTubEnsembl[row.names(neptuneTubEnsembl) %in% adaptiveStromal$V1,]
Dat<-(neptTubaStromal-rowMeans(neptTubaStromal))/rowSds(as.matrix(neptTubaStromal))
Score<-colMeans(Dat, na.rm = TRUE)
Score<-as.data.frame(Score)
write.table(Score, file = "neptTubaStromalScore.txt", sep = '\t', quote = FALSE)
neptTubaTAL = neptuneTubEnsembl[row.names(neptuneTubEnsembl) %in% aTAL$V1,]
Dat<-(neptTubaTAL-rowMeans(neptTubaTAL))/rowSds(as.matrix(neptTubaTAL))
Score<-colMeans(Dat, na.rm = TRUE)
Score<-as.data.frame(Score)
write.table(Score, file = "neptTubaTALScore.txt", sep = '\t', quote = FALSE)
neptTubaPT = neptuneTubEnsembl[row.names(neptuneTubEnsembl) %in% aPT$V1,]
Dat<-(neptTubaPT-rowMeans(neptTubaPT))/rowSds(as.matrix(neptTubaPT))
Score<-colMeans(Dat, na.rm = TRUE)
Score<-as.data.frame(Score)
write.table(Score, file = "neptTubaPTScore.txt", sep = '\t', quote = FALSE)
neptTubaPTaTALcommon = neptuneTubEnsembl[row.names(neptuneTubEnsembl) %in% aPTaTALcommon$V1,]
dim(neptTubaPTaTALcommon)
Dat<-(neptTubaPTaTALcommon-rowMeans(neptTubaPTaTALcommon))/rowSds(as.matrix(neptTubaPTaTALcommon))
Score<-colMeans(Dat)
Score<-as.data.frame(Score)
write.table(Score, file = "neptTubaPTaTALcommonScore.txt", sep = '\t', quote = FALSE)
neptTubaDegenerative = neptuneTubEnsembl[row.names(neptuneTubEnsembl) %in% degenerative$V1,]
dim(neptTubaDegenerative)
Dat<-(neptTubaDegenerative-rowMeans(neptTubaDegenerative))/rowSds(as.matrix(neptTubaDegenerative))
Score = colMeans(Dat, na.rm = TRUE)
Score = data.frame(colMeans(Dat, na.rm = TRUE))
write.table(Score, file = "neptTubDegenerativeScore.txt", sep = '\t', quote = FALSE)
