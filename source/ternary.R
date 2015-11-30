##### Infomations #####
# Title: Ternary.R
# Author: Jérémy Ragusa
# Date: 2015/09/05
##### Description #####
# Draw geological domains in ternary diagram using ggtern package.
# Do not forget to use quotes for variables !!
#####
# Ternary diagrams proposed :
# Folk: Sanstones classification from Folk (1970)
# McBride: Sanstones classification from McBride (1963)
# QFL: Dickinson model from Dickinson & al. (1983)
# QmFLt: Dickinson model from Dickinson & al. (1983)
# Garnet: Garnet classification from Morton (1989)
# Pyroxene: Pyroxene classification
# QAP: Igneous & Volcanic rocks classification
# Peridotite: Peridotite and Pyroxenites rocks classification
#####

# library
library(ggtern)

#load data
lines <- read.csv("/home/jeremy/UniGE/Git/Provenance/data/ternary_lines.csv", header = TRUE, comment.char = "#")

# function ternary
ternary <- function(tern,lab.y,lab.x,lab.z){
  # tern: type of ternary diagram
  # lab: use official or custom label for end-members
  # Use quotes for each parameters
  ggtern() + 
  geom_line(data=subset(lines,type==tern),
            aes(x,y,z, color = line, group = line),
            size = 0.5, 
            color = 'grey') +
  xlab(lab.x) +
  ylab(lab.y) +
  zlab(lab.z)
}