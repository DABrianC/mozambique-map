
#libraries
library(tidyverse)
library(sf)
library(geodata)
library(showtext)
library(terra)
library(tidyterra)
library(roughsf)

#import shape of mozambique
moz0 <- geodata::gadm(country = "MOZ"
                     , level = 0
                     , path = "./data")

moz1 <- geodata::gadm(country = "MOZ"
                      , level = 1
                      , path = "./data")


#Quick look at the output to make sure it's correct
ggplot(moz)+
  geom_spatvector()

#colors of mozambique
pal <- c("#009739"
         , "#FFD100"
         , "#E4002B"
         , "#000000")

#Now to make it look nice
plot <- ggplot(moz1) +
  geom_spatvector(aes(fill = factor(NAME_1))
                  , color = "white"
                  , lwd = .05) + 
  theme_void() +
  scale_fill_manual(values = rep(pal, times = 3
                                  , length.out = 11)) +
  theme(legend.position = "none")

ggsave(plot
       , filename = "map.png"
       , path = "./output"
       , height = 1.5
       , width = 1
       , unit = "in")

#now add the words
