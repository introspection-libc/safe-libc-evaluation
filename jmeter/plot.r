#!/usr/bin/Rscript
library(ggplot2)
library(reshape)
library(scales)
library(plyr)
library(grid)
library(gridExtra)
library(ggrepel)

set.seed(42)

plotdata <- function(df, title, round) {
    meds <- ddply(df, .(threads, system_ordered, introspection_ordered), summarize, med = median(throughput))
    p<-ggplot(df, aes(x=introspection_ordered, y=throughput)) + geom_boxplot() + facet_grid(threads~system_ordered, scales="free") + theme_bw(base_size = 13) + theme(panel.grid.minor = element_blank(), plot.margin=grid::unit(c(1,-1,1,0), "mm"), strip.background = element_blank(), axis.title.x = element_blank()) +
     geom_text_repel(data = meds, aes(y = med, label = round(med, round)),size = 4, vjust="inward", check_overlap=TRUE, direction="y", box.padding=0, nudge_y=100) +
     ggtitle(title) + ylab("requests per second")
    return(p)   
}

df<-read.csv(file="output.csv",header=TRUE,sep=";")
print(df)
df$system_ordered <- factor(df$system, levels=c("clang", "asan", "mpx"))
levels(df$system_ordered) <- factor(c("Clang (baseline)", "ASan", "MPX"))
df$introspection_ordered <- factor(df$introspection, levels=c("", "original", "introspection"))
lightftp_df <- subset(df, benchmark=="lightftp")
dnsmasq_df <- subset(df, benchmark=="dnsmasq")
p1 <- plotdata(lightftp_df, "Throughput on LightFTP", 2)
p2 <- plotdata(dnsmasq_df, "Throughput on Dnsmasq", 0)
p <- grid.arrange(p1, p2)
ggsave(filename="throughput.pdf", plot=p, width=6, height=5, device=cairo_pdf) 
