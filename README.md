# install
if (!requireNamespace("devtools", quietly = TRUE))<br>
install.packages("devtools")<br>
devtools::install_github("Zhao-Peng-Yang/MinusAddPlot")<br>


# running
library(data.table)<br>
library(MinusAddPlot)<br>

data<-fread("gene_samples_exp.xls",header=TRUE,stringsAsFactors=F,data.table=F)<br>

pdf("Minus_Add_MA_plot.pdf")<br>
MinusAddPlot(data)<br>
dev.off()<br>
system("convert -density 300 Minus_Add_MA_plot.pdf Minus_Add_MA_plot.png")<br>
