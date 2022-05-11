library(data.table)
library(MinusAddPlot)

data<-fread("gene_samples_exp.xls",header=TRUE,stringsAsFactors=F,data.table=F)

pdf("Minus_Add_MA_plot.pdf")
MinusAddPlot(data)
dev.off()
system("convert -density 300 Minus_Add_MA_plot.pdf Minus_Add_MA_plot.png")
