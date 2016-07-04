##### Infomations ####
# Title: ternary.R
# Author: Jérémy Ragusa
# Date: 2016/01/18

##### Description ####
# Draw geological domains in ternary diagram using ggtern package. Do not forget to use quotes for variables !!
# Two different method are proposed. 1/ draw only lines and 2/ draw areas. 
# The method 2 is usefull to put in colour the different fields or to include the field name.
# This script is based on explanation from Nicholas Hamilton website : http://www.ggtern.com/2014/01/15/usda-textural-soil-classification/

##### Ternary diagrams proposed ####
# Folk: Sanstones classification from Folk (1970)
# McBride: Sanstones classification from McBride (1963)
# QFL: Dickinson model from Dickinson & al. (1983)
# QmFLt: Dickinson model from Dickinson & al. (1983)
# garnet: Garnet classification from Morton (1989)
# pyroxene: Pyroxene classification
# QAP: Igneous & Volcanic rocks classification
# ultramafic: Peridotite and Pyroxenites rocks classification

# library
library(ggtern)
library(plyr)
library(grid)

# datasets
lines <- read.csv("/home/jeremy/UniGE/Git/Provenance/data/ternary_lines.csv", header = TRUE, comment.char = "#")
area <- read.csv("/home/jeremy/UniGE/Git/Provenance/data/ternary_areas.csv", header = TRUE, comment.char = "#")

##### function Tline #####
Tline <- function(tern,lab.y,lab.x,lab.z){
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

# Add your data using
# Tline + geom_point(data = df, aes())

##### function Tarea ####
Tarea <- function(tern,lab.y,lab.x,lab.z){

# Put tile labels at the midpoint of each tile ####
LAB <- NULL
LAB = ddply(df_source, 'Label', function(df) {
  apply(df[, 1:3], 2, mean)
})

# Tweak for adjust orientation of tectonic settings ####
LAB$Angle = 0
LAB$Angle[which(LAB$Label == 'Basement Uplift')] = -35 # customize orientation for specific label

ggtern() +
  geom_polygon(data=subset(lines,type==tern),
               aes(x,y,z, color = label, group = label),
               color = 'black') +
  geom_polygon(color='black') +
  geom_text(data = LAB, # Add field name
            aes(y=Q, x=F, z=R, label = Label, angle = Angle),
            color = 'black',
            size = 3.5) +
  xlab(lab.x) +
  ylab(lab.y) +
  zlab(lab.z)
}

# Add your data using
# Tarea + geom_point(data = df, aes())

#### colour association ####
# examples of coloured fields

col.dickinson <- c("Basement Uplift" = "#94642e", "Transitional Continental" = "#c48741", "Craton Interior" = "#dfbe98",
                   "Undissected Arc" = "#e82c0c", "Dissected Arc" = "#f4998b", "Transitional Arc" = "#ee6b57",
                   "Lithic Recycled" = "#f2b705", "Transitional Recycled" = "#fcd256", "Quatzose Recycled" = "#fde498",
                   "Recycled Orogenic" = "#f2b705","Mixed" = "#88aa00")

col.sandstone <- c("Quartzarenite" = "#FFFFFF",
              "Subfeldsparenite" = "#e5af6f", "Arkose" = "#e5af6f", "Lithic arkose" = "#e5af6f",
              "Sublitharenite" = "#b1703a", "Feldspathic litharenite" = "#b1703a", "Litharenite" = "#b1703a")

col.igneous <- c("Quartzolite" = "#d1d1d1",
                 "Quartz-rich granitoid" = "#b6b6b6",
                 "Alkali-feldspar granite" = "#c5aacd",
                 "Syeno-granite" = "#b2d9e8",
                 "Monzo-granite" = "#b2d9e8",
                 "Grano-diorite" = "#d7ebba",
                 "Tonalite" = "#cde48c",
                 "Alkali-feldspar quartz syenite" = "#b982b9",
                 "Quartz syenite" = "#7dc6e6",
                 "Quartz monzonite" = "#3ab797",
                 "Quartz monzodiorite / Quartz monzogabbro" = "#b3d19f",
                 "Quartz diorite / Quartz gabbro" = "#c2d383",
                 "Alkali-feldspar syenite" = "#8c5da1",
                 "Syenite" = "#18aee3",
                 "Monzonite" = "#2d937b",
                 "Monzodiorite / Monzogabbro" = "#89b16b",
                 "Diorite / Gabbro" = "#9ea66d")

col.volcanic <- c("Alkali-rhyolite" = "#c5aacd",
                  "Rhyolite" = "#b2d9e8",
                  "Rhyo-dacite" = "#b2d9e8",
                  "Dacite" = "#d7ebba",
                  "Quartz andesite" = "#cde48c",
                  "Alkali quartz trachyte" = "#b982b9",
                  "Quartz trachyte" = "#7dc6e6",
                  "Quartz latite" = "#3ab797",
                  "Andesite" = "#b3d19f",
                  "Alkali-trachyte" = "#8c5da1",
                  "Trachyte" = "#18aee3",
                  "Latite" = "#2d937b",
                  "Latite / basalt" = "#89b16b",
                  "Basalt" = "#9ea66d")