library(tidyverse)
library(Rtsne)
library(ggfortify)
library(cluster)

DF.Final <- read.csv("derived_data/Final_Data.csv")

set.seed = 18
fit1 <- Rtsne(DF.Final %>% 
                select(heightInches, 
                       weight, 
                       ageAtDraft, 
                       combine40yd, 
                       combineVert, 
                       combineBench, 
                       combineBroad,
                       combineShuttle,
                       combine3cone), dims = 2)
g1 <- ggplot(fit1$Y %>% as.data.frame() %>% as_tibble(), aes(V1,V2)) +
  geom_point() #this is for sure what I was expecting. We have what looks like three groups of players. This makes sense: Players that lineup against eachother on offense and defense will probably have similar attributes.

#lets break up the data and add tags for players depending on their position, how about OLine and DLine go together, TEs and LBs, and WR DB and RB. 

#ok now lets make the same plot by with the colors of the types

g2 <- ggplot(fit1$Y %>% as.data.frame() %>% as_tibble(), aes(V1,V2)) +
  geom_point(aes(color = DF.Final$Type)) +
  scale_color_discrete(name="Type", labels = c("Skill", "Strength", "Mixed")) +
  ggtitle("TSNE Clustering Analysis")
#ok this looks like there are three groups sort of, lets do another type of clustering to check since TSNE can make clusters where there really aren't any

ggsave("derived_graphs/TSNE.Plot.png", plot = g2)

#PCA

library(ggfortify)
library(cluster)
pcs <- prcomp(DF.Final %>% 
                select(heightInches, 
                       weight, 
                       ageAtDraft, 
                       combine40yd, 
                       combineVert, 
                       combineBench, 
                       combineBroad,
                       combineShuttle,
                       combine3cone), scale. = T)

g3 <- autoplot(pam(DF.Final %>% 
                     select(heightInches, 
                            weight, 
                            ageAtDraft, 
                            combine40yd, 
                            combineVert, 
                            combineBench, 
                            combineBroad,
                            combineShuttle,
                            combine3cone), 3), frame = T, fram.type = 'norm') +
  scale_color_discrete(name="Type", labels = c("Skill", "Strength", "Mixed"))+
  guides(fill = F) +
  ggtitle("Principle Complonent Analysis")

#principle component analysis leads to me believe that there are three groups. Lets make some more plots with this as one of the variable of interest to see differences

ggsave("derived_graphs/PCA.Plot.png", plot = g3)