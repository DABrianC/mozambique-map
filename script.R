
#libraries
library(tidyverse)
library(sf)
library(geodata)
library(showtext)
library(terra)
library(tidyterra)
library(roughsf)
library(magick)
library(showtext)

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
plot <- ggplot(moz) +
  geom_spatvector(fill = NA
                  , lwd = .3) + 
  theme_void() +
  scale_fill_manual(values = rep(pal, times = 3
                                  , length.out = 11)) +
  theme(legend.position = "none"
        , plot.margin = unit(c(0, 0, .5, 0), 
                             "inches"))

ggsave(plot
       , filename = "map1.png"
       , path = "./output"
       , height = 2.5
       , width = 1.25
       , unit = "in"
       , bg = "white")

#use a google font
font_add_google("Schoolbell", "bell")

#activate font
showtext_auto()

#now add the words
plot + 
  annotate(geom = "text"
           , x = 35
           , y = -29
           , label = "Amizade means friendship\nin Portuguese"
           , family = "bell"
           , size = 12)

img <- image_read("./output/map1.png")

#annotate the image
#set the font
font <- "Bradley Hand ITC"

img_ <- image_annotate(img, "Amizade means friendship"
                       , font = font
                       , color = pal[[1]]
                       , size = 30
                       , gravity = "south"
                       , location = "+0+100"
)

img_1 <- image_annotate(img_, "in"
                       , font = font
                       , color = pal[[4]]
                       , size = 30
                       , gravity = "south"
                       , location = "+0+75")

img_2 <- image_annotate(img_1, "Portuguese"
                        , font = font
                        , color = pal[[3]]
                        , size = 30
                        , gravity = "south"
                        , location = "+0+50")

image_write(img_2
            , path = "./output/final_1.png"
            , format = "png")
  
  