#' Visualize the amplicon data
#'
#' @param otuTab otu table of your sample
#' @param metaData design file
#' @param classToPlot which column you want to plot
#' @param topNum  top n taxa to plot
#' @param col colour palette: including all the types of the "display.brewer.all()" in the RColorBrewer package
#' @return
#'
#' @export 
#'
#' @examples otu_table_L2.txt <- system.file("extdata", "otu_table_L2.txt", package = "microVisu")
#' @examples design.txt <- system.file("extdata", "design.txt", package = "microVisu")
#' @examples taxBarPlot(otuTab = otu_table_L2.txt, metaData = design.txt,
#'  classToPlot = "status", topNum = 10, col = "Set3")
MinusAddPlot <- function(data=data,pdf="Minus_Add_MA_plot.pdf"){

    library(ggplot2)
    library(ggrepel)

    # check data
    data$A<-(log2(data$G2)+log2(data$G1))/2
    data$M<-log2(data$G2/data$G1)

    data$Class<-"Not"
    data[which(data$log2FC>=1 & data$FDR<=0.05),]$Class<-"Up"
    data[which(data$log2FC<=-1 & data$FDR<=0.05),]$Class<-"Down"
    data<-data[which(!is.na(data$A)& !is.infinite(data$A)),]
    data<-data[which(!is.na(data$M)& !is.infinite(data$M)),]

    dt<-data[which(data$Class=="Not"),]
    dt<-rbind(dt,data[which(data$Class=="Up"),])
    dt<-rbind(dt,data[which(data$Class=="Down"),])
    data<-dt

    Q3=quantile(c(data$M))[4]
    Q1=quantile(c(data$M))[2]
    IQR=Q3-Q1
    lable<-paste("Median=",abs(round(median(c(data$M)),5)),"\n","IQR=",round(IQR,5),sep="")

    x<-data$G1
    y<-data$G2

    # Plot
    p<-ggplot(data)+
        geom_smooth(aes(x=(log2(y)+log2(x))/2,y=log2(y/x)),method='lm', formula=y~I(poly(x,3)), colour="red")+
        geom_point(data=data, aes(x=(log2(y)+log2(x))/2,y=log2(y/x), colour=Class),alpha=1,size=0.8)+
        scale_colour_manual(values=c("#377eb8","grey","#e41a1c"))+ # c("blue","grey","red")
        geom_hline(yintercept=0, colour="blue")+
        geom_text(aes(x=max(A)-1.25, y=max(M)-0.5, label=lable), size=4, vjust=0, hjust=0)+
        geom_label_repel(aes(A, M,
            label=Symbol),
            box.padding=unit(0.01, "lines"),
            point.padding=unit(0.01, "lines"),
            segment.colour = "grey50")+
        xlab("A")+
        ylab("M")+
        theme_bw()+
        ggtitle("MA Plot")+
        theme(plot.title = element_text(hjust=0.5,size=20,colour="black"))
    print(p)
    # system("convert -density 300 Minus_Add_MA_plot.pdf Minus_Add_MA_plot.png")
}

