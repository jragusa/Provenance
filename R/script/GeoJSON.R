##########################
# Title : Convert to GeoJSON
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

outcrop <- read.csv("/home/jeremy/git/VoironsFlysch/data/Outcrop.csv", header = TRUE, comment.char = "#", dec = ",")
outcrop$marker_color <- paste("#",outcrop$marker_color, sep="")

outcropSP <- SpatialPointsDataFrame(outcrop[,c(3,4)], outcrop[,-c(3,4)])
writeOGR(outcropSP, 'outcrop.geojson', 'outcropSP', driver='GeoJSON') 