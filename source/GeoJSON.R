##########################
# Title : Convert csv file to GeoJSON
# Author : Jérémy Ragusa
# Date : 26/11/2014
##########################
# Description : 
# Convert outcrops location in .csv file to GeoJSON file.
# Script from Oscar Perpiñan Lamigueiro (http://procomun.wordpress.com/2013/09/20/r-geojson-and-github/).
##########################

# load library
library(sp)
library(rgdal)

# load data
outcrop <- read.csv("/home/jeremy/UniGE/Git/GurnigelNappe/outcrops/outcrops.csv", header = TRUE, comment.char = "#")
outcrop$marker_color <- paste("#",outcrop$marker_color, sep="")

outcropSP <- SpatialPointsDataFrame(outcrop[,c(2,3)], outcrop[,-c(2,3)])
writeOGR(outcropSP, 'outcrops.geojson', 'outcropSP', driver='GeoJSON') 
