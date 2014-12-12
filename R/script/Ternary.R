##########################
# Title : Draw geological domains in ternary diagram
# Author : Jérémy Ragusa
# Date : 07/12/2014
##########################
# Description : 
# Example of script for creating ternary diagram with geological domains using ggtern package. Data are incorporated using 'ggplot' function. Colored background of domains are available using 'scale_fill_manual' functions. See ggplot documentation for further details. The script is based on explanation from Nicholas Hamilton website : http://www.ggtern.com/2014/01/15/usda-textural-soil-classification/
 # Geological domains include Dickinson tectonic settings ('qfl' and 'qmflt'), QAP diagram for igneous and volcanic ('igneous' and 'volcanic'), sandstones classification of Folk (1970) ('folk') and garnet provenance of Morton (1989) ('garnet')
##########################

# In this script, we will draw the QmFLt ternary diagram of Dickinson 'qmflt' and add sample dataset 'df'. 
# You will have to define colour variable for sample 'col'.

# Load libraries ####
library(ggtern)
library(plyr)
library(grid)

# Load data ####
folk <- read.csv("/data/Folk_Sandstone.csv", header = TRUE, comment.char = "#")
volcanic <- read.csv("/data/QAP_Volcanic.csv", header = TRUE, comment.char = "#")
igenous <- read.csv("/data/QAP_Igneous.csv", header = TRUE, comment.char = "#")
qmflt <- read.csv("/data/Dickinson_QmFLt.csv", header = TRUE, comment.char = "#")
qfl <- read.csv("/data/Dickinson_QFL.csv", header = TRUE, comment.char = "#")
garnet <- read.csv("/data/Morton_Garnet.csv", header = TRUE, comment.char = "#")

# Color domains ####

col.dickinson <- c("Basement Uplift" = "#94642e", "Transitional Continental" = "#c48741", "Craton Interior" = "#dfbe98",
                   "Undissected Arc" = "#e82c0c", "Dissected Arc" = "#f4998b", "Transitional Arc" = "#ee6b57",
                   "Lithic Recycled" = "#f2b705", "Transitional Recycled" = "#fcd256", "Quatzose Recycled" = "#fde498",
                   "Recycled Orogenic" = "#f2b705","Mixed" = "#88aa00")

# Put tile labels at the midpoint of each tile ####
LAB <- NULL
LAB = ddply(qmflt, 'Label', function(df) {
  apply(df[, 1:3], 2, mean)
  })
  
# Tweak for adjust orientation of tectonic settings ####
LAB$Angle = 0
LAB$Angle[which(LAB$Label == 'Basement Uplfit')] = -35
  
# QmFLt ternary diagram

ggtern() +
  # Draw polygons
  geom_polygon(data = qmflt, 
               aes(y=Qm, x=F, z=Lt, color = Label, fill = Label),
               alpha = 0.75, 
               size = 0.5, 
               color = 'black') +
  geom_polygon(color='black') +
  # Add colours
  scale_fill_manual(values = col.dickinson) +
  # Add labels
  geom_text(data = LAB,
            aes(y=Q, x=P, z=A,label = Label, angle = Angle),
            color = 'black',
            size = 3.5) +
  # Add your points
  geom_point(data = df, aes(y=Qm, x=F, z=Lt), size = 4) +
  scale_color_manual(values=col) +
  # Add 90 % confidence area
  geom_confidence(data = df, aes(y=Qm, x=F, z=Lt), breaks = 0.9, color="red",linetype=1) +
  # Customize caption
  labs(colour = "Samples", fill = 'Tectonic settings') +
  # To remove slash of polygons in caption
  theme(legend.key=element_rect(fill='white',colour = "black")) +
  guides(colour = guide_legend(override.aes = list(size=4)),fill = guide_legend(override.aes = list(colour = NULL)))
