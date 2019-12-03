

getwd()      # check that R is in the right folder for the GIS files 
setwd("C:/Users/xyz/Documents/R/setup0/6patterns")

### all GIS files must be present in the same folder ###
#London_Borough_Excluding_MHW.dbf
#London_Borough_Excluding_MHW.GSS_CODE.atx
#London_Borough_Excluding_MHW.NAME.atx
#London_Borough_Excluding_MHW.prj
#London_Borough_Excluding_MHW.sbn
#London_Borough_Excluding_MHW.sbx
#London_Borough_Excluding_MHW.shp
#London_Borough_Excluding_MHW.shp.xml
#London_Borough_Excluding_MHW.shx
###

library(maptools)
library(sf)
library(cartography)


sevenMaps  <- sf::st_read('./London_Borough_Excluding_MHW.shp')    # everything is bundled up 


plot(sevenMaps)      # will display maps in lrh window of RStudio
#plot(sevenMaps[,7])
#summary(sevenMaps[,7])

## dig into what is in the shapeFileThing
## steps taken from https://stackoverflow.com/questions/41495747/how-to-create-a-choropleth-or-bubble-map-of-uk-in-r
#summary(sevenMaps)
#names(sevenMaps)
#sevenMaps$NAME

LondonSF <- st_as_sf(sevenMaps)
LondonSF      # display attributes  of NAME, GSS_CODE, HECTARES columns, values colour choropleth

possibleTrends <- read.csv('./boroughChloropleth0.csv')    # learn to spell choropleth
northSouth <- possibleTrends[c(1,2)]                       # only boroughNames and northSouth

plot(sevenMaps[1,])  # Kingston in different colours for the seven maps
plot(sevenMaps[,1])  # 'NAME' map only with all boroughs
plot(sevenMaps[1,1]) # only Kingston from 'NAME' map
northSouth[,2]       # list 1 1 2 1 2 which is the column showing 1 for north and 2 for south of the river

LondonSF[,1][northSouth]


plot(sevenMaps[,5])      # plot the two tone map

sevenMaps$ONS_INNER      # lists F and T for the two-tone colours of the boroughs
sevenMaps$NAME           # list the names of 33 boroughs
sevenMaps$GSS_CODE       # lists E09000021 etc for the 33 borough codes
sevenMaps$HECTARES       # lists the values used to colour the choropleth for the HECTARES map
sevenMaps$HECTARES[1:2]  # lists the fist two values

### Monday 2nd Decmber 2019 I coloured my first choropleth
# use table1$column1 <- myTable$myValues   
# after checking column1 for the values to replace to get the right colour range

threeColumns <- read.csv('boroughChoroplethRiv-v-Out.csv')
sevenMaps$HECTARES <- threeColumns$outside
plot(sevenMaps[,3])                              # save screenshot
sevenMaps$HECTARES <- threeColumns$riverside
plot(sevenMaps[,3])                              # save screenshot again


