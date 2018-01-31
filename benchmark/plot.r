#!/usr/bin/Rscript
library(ggplot2)
library(reshape)
library(scales)
library(plyr)

df<-read.csv(file="out.csv",header=TRUE,sep=";")
df$system_ordered <- factor(df$system, levels=c("clang", "asan", "mpx", "softbound+cets"))
df$introspection_ordered <- factor(df$introspection, levels=c("original", "introspection"))

meds <- ddply(df, .(length, system_ordered, introspection_ordered), summarize, med = median(milliseconds))

p<-ggplot(df, aes(x=introspection_ordered, y=milliseconds)) + geom_boxplot() + facet_grid(length~system_ordered, scales="free_x") + theme_bw() + theme(strip.background = element_blank(), axis.title.x = element_blank()) +
 geom_text(data = meds, aes(y = med, label = round(med,2)),size = 4, vjust="inward", nudge_y=3)
ggsave(filename="out.pdf", plot=p, width=5, height=5, device=cairo_pdf)
