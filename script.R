
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
ggplot(moz0)+
  geom_spatvector()

#colors of mozambique
pal <- c("#009739"
         , "#FFD100"
         , "#E4002B"
         , "#000000")

#Now to make it look nice
plot <- ggplot(moz0) +
  geom_spatvector(fill = NA
                  , lwd = .3) + 
  theme_void() +
  scale_fill_manual(values = rep(pal, times = 3
                                  , length.out = 11)) +
  theme(legend.position = "none"
        , plot.margin = unit(c(.15, .2, .3, 0), 
                             "inches"))

ggsave(plot
       , filename = "map1.png"
       , path = "./output"
       , height = 2
       , width = 1.25
       , unit = "in"
       , bg = "white")

#use a google font
font_add_google("Schoolbell", "bell")

#activate font
showtext_auto()

#now add the words

img <- image_read("./output/map1.png")

#annotate the image
#set the font
font <- "Bradley Hand ITC"

img_ <- image_annotate(img, "Amizade"
                       , font = font
                       , color = pal[[1]]
                       , size = 50
                       , gravity = "south"
                       , location = "+20+90"
)

img_1 <- image_annotate(img_, "means friendship"
                       , font = font
                       , color = pal[[4]]
                       , size = 50
                       , gravity = "south"
                       , location = "+0+45")

img_2 <- image_annotate(img_1, "in Portuguese"
                        , font = font
                        , color = pal[[3]]
                        , size = 50
                        , gravity = "south"
                        , location = "+0+1")

img_3 <- image_annotate(img_2, "Mozambique"
                        , font = font
                        , color = pal[[3]]
                        , size = 50
                        , gravity = "north"
                        , location = "+0+1")

image_write(img_3
            , path = "./output/final_2.png"
            , format = "png")
  
  