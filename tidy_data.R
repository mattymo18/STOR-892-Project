library(tidyverse)

DF <- read.csv("Source-Data/Final.csv") %>% 
  select(-c(X, key, college, n_college_picks, short_college, games)) %>% 
  filter(pos != "K" & pos != "P" & pos != "LS")



DF.Def <- DF %>% 
  filter(pos == "DE" | pos == "LB" | pos == "DT"| pos == "DB"| pos == "NT"| pos == "DL"| pos == "OLB"| pos == "CB"| pos == "S"| pos == "ILB"| pos == "FS"| pos == "SS" | pos == "")

DF.Off <- DF %>% 
  filter(pos == "T" | pos == "WR" | pos == "RB" | pos == "TE" | pos == "QB" | pos == "G" | pos == "C" | pos == "FB" | pos == "OL" | pos == "OG" | pos == "OT")

write.csv(DF.Def, "derived_data/Defense.csv")
write.csv(DF.Off, "derived_data/Offense.csv")