#install.packages(c("tidyverse", "patchwork", "maps", "ggsci", "scico", "skimr")) # This installs the packages required for today's session. Delete lines 1 & 2 after you install these packages.

library(tidyverse) # Contains ggplot2, dplyr, readr etc
library(patchwork) # Allows us to create figures with multiple panels
library(ggsci) # Contains colour schemes for specific journals
library(scico) # Contains scientific colour schemes
library(skimr) # An alternative to using base R summary
library(maps) # Allows us to project data onto maps

########## 1. Importing your data ########## 
#---- Set working directory ----
getwd()
setwd("/Users/jackward/Documents/RCodingWorkshop") # Windows: “C:\\Users\\Jack\\Documents\\RCodingWorkshop"
getwd()

#---- Import data ----
RawData <- read_csv("R_Workshop_Data.csv") 

#---- Check data ----
str(RawData) # Shows the internal structure of an R object

summary(RawData) # Summarises data in the data frame
skim(RawData) # Superior summary

head(RawData, n = 20) # Shows first 20 rows of data frame
tail(RawData) # Shows last rows of data frame 

colnames(RawData) # Shows column names
count(RawData, LocationClass, sort = T) # Calculates the number of values in a variable
count(RawData, RockName, Location, LocationClass, RockType, sort = T) # Calculates the number of values in a variable

########## 2. Manipulating your data ##########
#---- Calculate geochemical ratios ----
## Base R
RawData$BaTh <- RawData$Ba / RawData$Th
RawData$LaYb <- RawData$La / RawData$Yb
RawData$NbY <- RawData$Nb / RawData$Y
RawData$ThCe <- RawData$Th / RawData$Ce
RawData$BaLa <- RawData$Ba / RawData$La
RawData$NbTh <- RawData$Nb / RawData$Th
RawData$ZrNb <- RawData$Zr / RawData$Nb
RawData$ZrY <- RawData$Zr / RawData$Y
RawData$TotalAlkalis <- RawData$K2O + RawData$Na2O

## Dplyr
RawData <- RawData %>%
  mutate(BaTh_Dplyr = Ba / Th,
         LaYb_Dplyr = La / Yb,
         NbY_Dplyr = Nb / Y,
         ThCe_Dplyr = Th / Ce,
         BaLa_Dplyr = Ba / La,
         NbTh_Dplyr = Nb / Th,
         ZrNb_Dplyr = Zr / Nb,
         ZrY_Dplyr = Zr / Y,
         TotalAlkalis_Dplyr = K2O + Na2O)

## Compare methods
RawData %>% 
  select(SampleName, BaTh, BaTh_Dplyr, LaYb, LaYb_Dplyr, NbY, NbY_Dplyr) %>% 
  View()

#---- Filter data ----
## Base R
BaseRFilteredExampleOne <- RawData[RawData$SiO2 < 53,]
BaseRFilteredExampleTwo <- RawData[RawData$SiO2 < 53 & RawData$MgO > 5 & RawData$MgO < 10,]
BaseRFilteredExampleThree <- RawData[RawData$SiO2 < 53 & RawData$MgO > 5 & RawData$MgO < 10 & RawData$Material == "WR",]

## Dplyr
DplyrFilteredExampleOne <- filter(RawData, SiO2 < 53) # You will notice that the base R filtered data set has more rows. This is because NA values are included.  
DplyrFilteredExampleTwo <- filter(RawData, SiO2 < 53, MgO > 5 & MgO < 10)
DplyrFilteredExampleThree <- filter(RawData, SiO2 < 53, MgO > 5 & MgO < 10, Material == "WR")

## Dplyr & Magrittr
DplyrFilteredExampleFour <- RawData %>% 
  filter(SiO2 < 53, MgO > 5 & MgO < 10, Material == "WR")

#---- Calculate mean values ----
mean(DplyrFilteredExampleOne$SiO2)
mean(BaseRFilteredExampleOne$SiO2) # NA is returned because we have NA values in the data set
mean(BaseRFilteredExampleOne$SiO2, na.rm = T) # "na.rm = T" removes the NA values

#---- Create data sets we will use for the rest of the workshop ----
## Major elements
MajorElementDataset <- RawData %>% 
  filter(RockType == "VOL", Material == "WR", SiO2 > 40 & SiO2 < 80, MgO < 15,
         LocationClass %in% c("Andean Arc", "Cascades", "Mexican Volcanic Belt", "Tonga Arc"))

## Trace elements
TraceElementDataSet <- RawData %>% 
  filter(RockType == "VOL", Material == "WR", SiO2 < 53, MgO > 5 & MgO < 10, 
         LocationClass %in% c("Andean Arc", "Cascades", "Mexican Volcanic Belt", "Tonga Arc"))

## Check data
skim(MajorElementDataset)
skim(TraceElementDataSet)

View(MajorElementDataset)
View(TraceElementDataSet)

## Export .csv file of a R data frame
write_csv(MajorElementDataset, "/Users/jackward/Documents/RCodingWorkshop/MajorElementDataset.csv")

########## 3. Plotting your data ##########
#---- Plotting part 1: major element data ----
## Basic scatter plot
?ggplot

## "Conventional" format
ggplot(data = MajorElementDataset, aes(x = SiO2, y = TiO2)) +
  geom_point() +
  xlim(40, 80) +
  ylim(0, 5)

## 'Pipe' operator
MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TiO2)) +
  geom_point() +
  xlim(40, 80) +
  ylim(0, 5)

## Scatter plot coloured by continuous variable
MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TiO2, colour = MgO)) +
  geom_point() +
  xlim(40, 80) +
  ylim(0, 5)

## Scatter plot coloured by continuous variable using a scientific colour map
MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TiO2, colour = MgO)) +
  geom_point(size = 2) +
  xlim(40, 80) +
  ylim(0, 5) +
  scale_colour_scico(palette = "batlow") # colour palettes can be found here: https://github.com/thomasp85/scico 

## Same plot as above, but with a different theme, re-positioned legend, new title, and new axes
MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TiO2, colour = MgO)) +
  geom_point(size = 2) +
  xlim(40, 80) +
  ylim(0, 5) +
  scale_colour_scico(palette = "batlow") +
  theme_bw() +
  theme(legend.position = c(0.9, 0.8)) +
  labs(title = "A beautiful bivariate plot of SiO2 (wt %) vs. TiO2 (wt %)", x = "SiO2 (wt %)", y = "TiO2 (wt %)")

## Scatter plot coloured by discrete variable using a scientific colour map
MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TiO2, colour = LocationClass)) +
  geom_point(size = 2) +
  xlim(40, 80) +
  ylim(0, 5) +
  scale_colour_npg() +
  theme_bw() +
  theme(legend.position= c(0.9, 0.8)) +
  labs(x = "SiO2 (wt %)", y = "TiO2 (wt %)")

## Scatter plot coloured by discrete variable using a futurama-inspired (yes, the tv show) colour map 
MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TotalAlkalis, colour = LocationClass)) +
  geom_point(size = 2) +
  xlim(40, 80) +
  ylim(0, 15) +
  scale_colour_futurama() +
  theme_bw() +
  theme(legend.position = c(0.9, 0.8)) +
  labs(x = "SiO2 (wt %)", y = "Na2O + K2O (wt %)")

#---- Plotting part 2: creating a four-panel figure using patchwork ----
PanelA <- TraceElementDataSet %>% 
  ggplot(aes(x = LaYb, y = NbY, colour = LocationClass)) +
  geom_point(size = 2) +
  xlim(0, 100) +
  ylim(0, 10) +
  scale_colour_npg() +
  theme(legend.position = c(0.8, 0.8))

PanelB <- TraceElementDataSet %>% 
  ggplot(aes(x = ThCe, y = BaLa, colour = LocationClass)) +
  geom_point(size = 2) +
  xlim(0, 0.6) +
  ylim(0, 200) +
  scale_colour_npg() +
  theme(legend.position = "none") # This removes the legend

PanelC <- TraceElementDataSet %>% 
  ggplot(aes(x = NbTh, y = ZrNb, colour = LocationClass)) +
  geom_point(size = 2) +
  scale_colour_npg() +
  scale_x_continuous(trans = 'log10', limits = c(0.1,100)) + 
  scale_y_continuous(trans = 'log10', limits = c(0.5, 250)) +
  theme(legend.position = "none")

PanelD <- TraceElementDataSet %>% 
  ggplot(aes(x = ZrY, y = NbY, colour = LocationClass)) +
  geom_point(size = 2) +
  scale_colour_npg() +
  scale_x_continuous(trans = 'log10', limits = c(0.5,100)) + 
  scale_y_continuous(trans = 'log10', limits = c(0.01, 10)) +
  theme(legend.position = "none")

wrap_plots(PanelA, PanelB, PanelC, PanelD, ncol = 2, guides = "collect")

#---- Plotting part 3: creating a four-panel figure using facet_wrap() ----
MajorElementDataset %>%   
  ggplot(aes(x = SiO2, y = TiO2, colour = MgO)) +
  geom_point(size = 2) +
  xlim(40, 80) +
  ylim(0, 5) +
  scale_colour_scico(palette = "batlow") +
  facet_wrap(vars(LocationClass))

#---- Plotting part 4: other plots ----
## Bar chart
RawData %>% 
  ggplot(aes(LocationClass)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 45))

## Basic map
RawData %>% 
  ggplot(aes(x = Long, y = Lat)) + 
  borders("world", colour = "black", fill = NA) + 
  geom_point(colour = "red", shape = 16, size = 2) +
  coord_fixed() +
  theme_linedraw()

## Basic map of South America
RawData %>% 
  ggplot(aes(x = Long, y = Lat)) + 
  borders("world", colour = "black", fill = NA) + 
  geom_point(colour = "red", shape = 16, size = 2) +
  xlim(-100, -25) +
  ylim(-60, 15) +
  coord_fixed() +
  theme_linedraw()

## Scatter plot with trend line
MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TiO2)) +
  geom_point() +
  xlim(40, 80) +
  ylim(0, 5) +
  geom_smooth()

MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TiO2, colour = LocationClass)) +
  geom_point() +
  xlim(40, 80) +
  ylim(0, 5) +
  scale_colour_npg() +
  geom_smooth() 

## Density plot
MajorElementDataset %>% 
  ggplot(aes(x = SiO2, y = TiO2)) +
  geom_density_2d() +
  xlim(40, 80) +
  ylim(0, 2)

## Box plot
TraceElementDataSet %>% 
  ggplot(aes(x = LocationClass, y = NbY)) +
  geom_boxplot() +
  scale_y_continuous(trans = 'log10')









