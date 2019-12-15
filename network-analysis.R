#lwerthmann@email.arizona.edu
#12/14/2019
#network analysis of hashtags dealing with 2019 protests against violence against women in LATAM

#used http://sachaepskamp.com/files/Cookbook.html

install.packages("gdata")
install.packages("readxl")


library(gdata)

library(readxl)
data1 <- as.data.frame(read_xlsx("elvioladorerestu.xlsx",sheet = 1,na = "."))
head(data1)
#drop(1)
#drop.levels(1)

data1 <- data.frame(data1)
#data1 <- data1[-c(1)]
#data1 <- data1[-c(3)]
head(data1)
data1 <- na.omit((data1))
head(data1)

#data1$Count <- as.numeric(data1$Count)

corMat <- cor(data1, use = "pairwise.complete.obs")

install.packages("qgraph")
library("qgraph")
graph_pcor <- qgraph(corMat)

data2 <- data1[1:91]
head(data2)

#data2 <-subset(data1)
head(data2)

#data3 <- na.omit(data2)

#data3$Keyword <- as.numeric(data3$Keyword)

data3 <- data2[,1:91]
corMat <- cor(data3, use = "pairwise.complete.obs")

#data3$Count <- as.numeric(data3$Count)
#corMat <- cor(data3, use = "pairwise.complete.obs")

library("qgraph")
data3 <- data3[,1:91]
corMat <- cor_auto(data3)

Graph_pcor <- qgraph(corMat, graph = "pcor", layout = "spring")

View(Graph_pcor)

Graph_pcor <- qgraph(corMat, graph = "pcor", layout = "spring", threshold = "bonferroni",
                     sampleSize = nrow(data2), alpha = .05)

Graph_lasso <- qgraph(corMat, graph = "glasso", layout = "spring", tuning = .25, sampleSize = nrow(data1))
