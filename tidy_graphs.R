library(tidyverse)

DF.Off <- read.csv("derived_data/Offense.csv")
DF.Def <- read.csv("derived_data/Defense.csv")

g1 <- DF.Off %>% 
  ggplot(aes(x = pick, y = carav)) +
  geom_point(aes(color = pos)) +
  ylab("Career Added Value") +
  xlab("Pick") +
  scale_color_discrete(name = "Position")

ggsave("derived_graphs/Offense.Scatter.NoLab.png", plot = g1)

g2 <- DF.Off %>% 
  ggplot(aes(x = pick, y = carav)) +
  geom_point(aes(color = pos)) +
  ylab("Career Added Value") +
  xlab("Pick") +
  scale_color_discrete(name = "Position") +
  geom_text(aes(label = player))

ggsave("derived_graphs/Offense.Scatter.Lab.png", plot = g2)

