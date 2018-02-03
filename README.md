# R scripts

Collection of dataset and R scripts usefull for provenance analysis and others geological researchs.

## Datasets for classification and discrimination diagrams
Create geological fields in ternary diagrams with `ggplot` or `ggtern` package for R. Binary and ternary plots are extensively used to classify rocks and sediments or identify tectonic settings of the detrital source area. References are indicated in the preambule. The following datasets are available:
+ **SandstonesTernary**: mainly based on framework composition, the dataset provides a collection of ternary diagram for sandstone classification. Most of them were created between the 1950's and 1970's years.
+ **SandstonesBiplot**: biplot diagrams involve major and trace elements concentrations.
+ **ProvenanceTernary**: corresponds to the Dickinson ternary diagram identifying the tectonic settings of the detrital source (QFL and QmFLt diagrams).
+ **ProvenanceBiplot**: source rocks are identified applying a discriminant function on major elements concentration.
+ **MagmaticBiplot** and **MagmaticTernary** provide a collection of classification diagrams for felsic to ultramafic rocks based on framework composition or major elements.
+ **MineralTernary**: comprises a serie of discrimination diagram for dedicated mineral phases including garnet, pyroxene.

Integration of fields can be basically done as following for `ggplot`:
```
<<<<<<< HEAD
ggplot() +
   geom_line(data=subset(MagmaticBiplot, reference=="LeBas1986"), aes(x, y, group=line)) +
   geom_line(data=df, aes(SiO2, Na2O+K2O))
```
and for `ggtern`:
```
ggtern() +
   geom_line(data=subset(ProvenanceTernary, type=="QmFLt"), aes(x, y, z, group=line)) +
   geom_line(data=df, aes(F, Qm, Lt))
```
## Todo
+ feldspar ternary

=======
MagmaticBiplot <- read.csv("path/to/MagmaticBiplot.csv", header = TRUE, comment.char = "#", dec = ".")

ggplot() +
   geom_line(data=subset(MagmaticBiplot, reference=="LeBas1986"), aes(x, y, group=line)) +
   geom_line(data=df, aes(SiO2, Na2O+K2O))
```
and for `ggtern`:
```
ProvenanceTernary <- read.csv("path/to/ProvenanceTernary.csv", header = TRUE, comment.char = "#", dec = ".")

ggtern() +
   geom_line(data=subset(ProvenanceTernary, type=="QmFLt"), aes(x, y, z, group=line)) +
   geom_line(data=df, aes(F, Qm, Lt))
```
## Todo
+ feldspar ternary

>>>>>>> update repo
## GeoJSON.R
Convert outcrops location in .csv file to GeoJSON file to display geographical datasets on geo-referenced maps (Mapbox). Script from Oscar Perpiñan Lamigueiro (http://procomun.wordpress.com/2013/09/20/r-geojson-and-github/).
