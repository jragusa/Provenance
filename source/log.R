# Libraries ####
source("lib/lib.R")

# Load data ####
log <- read.csv("/home/jeremy/UniGE/Data/log.csv", header = TRUE, dec=",")

# 2 - Extract locality and section ####
list <- aggregate(log$formation, list(site = log$site, index = log$index), mean)
list.index <- list$index
list.site <- list$site

# 3 - Log by locality ####
for (i in list.site) {
  site <- data.frame(section=log$section[log$site==i],
                      thick=log$thick[log$site==i],
                      rock=log$rock[log$site==i],
                      thick.cum=rev(cumsum(rev(log$thick[log$site==i]))),
                      log.thick=log$thick[log$site==i]/5,
                      log.cum=rev(cumsum(rev(log$thick[log$site==i])))/5+40)  
  write.csv(site,file=paste("reports/log_", i,".csv", sep = ""),row.names=FALSE)
}

# 4 - Compute Rgm ratio ####
Rgm <- NULL

for (i in list.index) {
  Rgm<-rbind(Rgm, data.frame(site=NA,
                             section=NA,
                             formation=NA,
                             R=sum(log$thick[log$index==i&log$rock=="g"])/sum(log$thick[log$index==i&log$rock=="m"]),
                             g=sum(log$thick[log$index==i&log$rock=="g"]),
                             m=sum(log$thick[log$index==i&log$rock=="m"]),
                             h=sum(log$thick[log$index==i&log$rock=="h"]),
                             total=sum(log$thick[log$index==i&log$rock=="m"])+sum(log$thick[log$index==i&log$rock=="g"])+sum(log$thick[log$index==i&log$rock=="h"])))}

Rgm$site <- list.site
Rgm$section <- list.index
Rgm$formation <- list$x
Rgm$g.ratio <- Rgm$g/(Rgm$tot-Rgm$h)*100
Rgm$m.ratio <- Rgm$m/(Rgm$tot-Rgm$h)*100
# site <- paste("log.", i, sep = "")

# 5 - Plot diagram ####
col.formation = c("#ff1926","#99ba42","#f2c54b","#35617f")[as.factor(Rgm$formation)]
# col.formation = c("#f28322","#6bc4ff","#f2c54b","#8BC443")[as.factor(Rgm$formation)]
lim <- 25

pdf("graphs/Rgm.pdf",width=25,height=10)
par(mar = c(4,4,4,4), mfrow=c(1,2))
plot(Rgm$g.ratio,Rgm$m.ratio,
     pch=19,
     cex=2,
     bty="n",
     xlab="sandstones/(total-hiatus)x100",
     ylab="marls/(total-hiatus)x100",
     main="Relative content in sandstone and marly layers",
     col=col.formation,
     xlim=c(0,100),
     ylim=c(0,100))
# text(Rgm$g.ratio[Rgm$m.ratio>lim],Rgm$m.ratio[Rgm$m.ratio>lim], labels = Rgm$section[Rgm$m.ratio>lim], pos = 4, cex=1)
# text(Rgm$g.ratio[Rgm$m.ratio<lim],Rgm$m.ratio[Rgm$m.ratio<lim], labels = Rgm$section[Rgm$m.ratio<lim], pos = 2, cex=1)
rect(90,-1,101,10,border="red")
mtext("A",side=3,line=-1,at=0,cex=3)
legend("topright", 
       legend = c("Voirons Sandstones","Allinges Sandstones","Vouan Conglomerates","Boëge Marls"), 
       col = c("#f2c54b","#ff1926","#35617f","#99ba42"),      
       cex = 2,
       pch = 19, 
       bty = "n") 
plot(Rgm$g.ratio,Rgm$m.ratio,
     pch=19,
     cex=2,
     bty="n",
     xlab="",
     ylab="",
     col=col.formation,
     xlim=c(90,100),
     ylim=c(0,10))
# text(Rgm$g.ratio[Rgm$m.ratio<lim],Rgm$m.ratio[Rgm$m.ratio<lim], labels = Rgm$section[Rgm$m.ratio<lim], pos = 2, cex=1)
dev.off()

# 6 - Export table ####
Rgm$formation <- c("Voirons Sandstones","Allinges Sandstones","Vouan Conglomerates","Saxel Marls")[as.factor(Rgm$formation)]
# write.csv(Rgm,file = "test.csv")
print(xtable(Rgm, 
             #align = "lllrrrrrrr",
             caption = c("Ratio Rgm et épasseurs des intervalles gréseux et marneux par section et site. $R$ = Rgm, $g$ = épaisseur cumulée des bancs gréso-conglomératiques, $m$ = épaisseur cumulée des intervalles marneux, $h$ = épaisseur cumulée des hiatus, $total = g+m+h$, $g.ratio = g/(total-h) times 100$, $m.ratio = m/(total-h) times 100$. Les données des sections de la Maisonnée et de Pont-Morand proviennent de cite{Ospina-Ostios2014}."), 
             label="tab:appendix_rgm"),
      file="reports/Rgm.tex",
      type="latex",
      include.rownames=FALSE,
      tabular.environment="longtable",
      caption.placement="top",
      size = "small",
      floating=FALSE)

test <- Rgm[order(Rgm$formation,Rgm$R),]