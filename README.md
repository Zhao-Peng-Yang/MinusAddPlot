# install

devtools::install_github("Zhao-Peng-Yang/MinusAddPlot")


# running
library(data.table)

library(MinusAddPlot)

data(GeneExp)

MinusAddPlot(GeneExp,"Minus_Add_MA_plot.pdf")



