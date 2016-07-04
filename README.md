# R scripts

Collection of R scripts usefull for provenance analysis and others geological research. It comprises :
+ *GeoJSON.R* convert .csv file into GeoJSON file to display geographical datasets on geo-referenced maps (Mapbox).
+ *ternary.R* create ternary diagram using [ggtern](http://www.ggtern.com/) package and draw domains. They includes Dickinson tectonic settings (Dickinson et al;, 1979, 1983), garnet provenance from Morton (1989), Folk classification (Folk, 1970) and QAP ternary diagram of igneous and volcanic rocks

## ternary.R

Draw geological fields in ternary diagrams using [ggtern](http://www.ggtern.com/) package for R. The function needs to specify the end-members of the diagram and the dataset used. Two variants are available: draw lines or surface. The latter is usefull to colorize fields or put centered field name. Do not forget to use quotes for the different variables. dataset comprises:
+ Sandstones classification: *Folk* (Folk, 1970) and *McBride* (McBride, 1963)
+ Dickinson model: *QFL* and *QmFLt* (Dickinson & al., 1979, 1983)
+ Crystalline rocks classification: *QAP* (felsic rocks), *Ultramafic* (peridotite and pyroxenites rocks)
+ Single grains: *Garnet* (Morton, 1989) and *Pyroxene*

## GeoJSON.R

Convert outcrops location in .csv file to GeoJSON file. Script from Oscar Perpiñan Lamigueiro (http://procomun.wordpress.com/2013/09/20/r-geojson-and-github/).
