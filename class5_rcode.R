
#load the GISTools package (like a Python library!) into your R session. 
install.packages(GISTools)
library(GISTools)

#load preloaded dataset that came with the GISTools package
data(newhaven) 
ls() 

# See the description of the different data in the "Values" column to the left. 
# getClass gets the definition of these classes and tells you what category of data is 
# stored in the slots within each class. 

getClass('SpatialPoints')
getClass('SpatialPointsDataFrame')
getClass('SpatialPolygons')
getClass('SpatialPolygonsDataFrame')  

# for spatial analysis, we are mainly concerned with the data, matrix, and CRS slots
# you can see the data stored in the slots by typing "@" and then the slot name after
# the variable name. 

# Here are some basic ways to look at your data

blocks  #shows you summary info 
summary(blocks)  #gives a statistical summary of all the variables in your dataset
head(blocks)  #gives the first 5 lines of each variable within the dataframe
blocks@data$OCCUPIED  #what does the $ symbol show you? 
blocks@proj4string    #tells you the coordinate system of your spatial data
#Try calling different variables and data slots using @ and $. Get comfortable with it!

# let's do a simple plot
plot(blocks, add=TRUE)
# "add=T" allows you to add another dataset to the plot
# note that changing the plot order changes what it looks like
plot(roads,add=T, col='red') 
plot(tracts, col='blue')
# note: dev.off() will clear your plot space

# You can make a histogram of occupied houses
hist(blocks@data$OCCUPIED)
hist(blocks@data$OCCUPIED, main = "Histogram of Occupied Blocks", xlab="# Occupied Houses")

# Choropleth map: 
# a thematic map in which areas are shaded in proportion to the attributes present
# to make one, you need a SpatialPolygons of a SpatialPolygonsDataFrame Object

# visualize the data by which blocks are vacant
choropleth(blocks, blocks@data$OCCUPIED) 

# adding n = 5/6/7 will decide intervals for the legend
shades <- auto.shading(blocks@data$OCCUPIED, cols = brewer.pal(5,"Reds"))

#this function is interactive. you can click on locations where you want to plot points
#use locator to decide where you want your legend; must hit esc to get coords
locator() 
choro.legend(521445.7,198264.8, shades) # <- you can put any coords in here to adjust placement
axis(1)
axis(2)
box()

#Let's use a different preloaded dataset from GISTools
data(vulgaris)
plot(vulgaris2)
# what class of data is this?
 
# to make more sense of the data, let's plot our data points on a map
# what class of data is the map? 
plot(us_states2)
plot(vulgaris2, add=T, col='purple')

# what if we don't care about the states? 
# Let's get ride of them with the gUnaryUnion function
# id=NULL bc we don't want to label the geometries 
us.outline <- gUnaryUnion(us_states2, id=NULL) 
plot(us.outline, lwd=1.5) #lwd = line width
plot(vulgaris2, add=T, col='purple')
box()
grid()


# using mapview -makes spatial objects into an interactive map!
install.packages("mapview")
library(mapview)
breweries   #what info do you see? 
summary(breweries)  #what can we find out from the summary?
mapview(breweries) 
help("mapViewPalette")


#install some packages used for spatial analysis
install.packages('spData')
install.packages('spDataLarge')
library(spData)

# Now, try using some of these functions to play with the GISTools data!
# Also try making some of these plots with new data from the spData packages
# GISTools also has functions to add common map and plot elements.
# See what you can use to make your plots better/more informative!

#Some Extra Help:
#visit this link for more info on GISTools and all its functions:
# https://www.rdocumentation.org/packages/GISTools/versions/0.7-4
# this link has more info about the choropleth function: 
# https://rpubs.com/chrisbrunsdon/958
# this link shows you the datasets available in spData:
# https://nowosad.github.io/spData/
# more info on mapview:
# https://r-spatial.github.io/mapview/


#IGNORE

#import a shapefile using rgdal 
require(rgdal)
# Read SHAPEFILE.shp from the current working directory (".")
shape <- readOGR(dsn = ".", layer = "~/workspace/SHAPEFILE")
