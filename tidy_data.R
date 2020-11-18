library(tidyverse)

DF <- read.csv("Source-Data/Final.csv") %>% 
  select(-c(X, key, college, n_college_picks, short_college, games)) %>% 
  filter(pos != "K" & pos != "P" & pos != "LS")



DF.Def <- DF %>% 
  filter(pos == "DE" | pos == "LB" | pos == "DT"| pos == "DB"| pos == "NT"| pos == "DL"| pos == "OLB"| pos == "CB"| pos == "S"| pos == "ILB"| pos == "FS"| pos == "SS")

DF.Off <- DF %>% 
  filter(pos == "T" | pos == "WR" | pos == "RB" | pos == "TE" | pos == "QB" | pos == "G" | pos == "C" | pos == "FB" | pos == "OL" | pos == "OG" | pos == "OT")

write.csv(DF.Def, "derived_data/Defense.csv")
write.csv(DF.Off, "derived_data/Offense.csv")

OLine.DF <- DF.Off %>% 
  filter(pos == "T" | pos == "G"| pos == "C"| pos == "OL"| pos == "OG"| pos == "OT") %>% 
  filter(carav > 0) %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical)

WR.DF <- DF.Off %>% 
  filter(pos == "WR") %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical) %>% 
  filter(carav > 0)

QB.DF <- DF.Off %>% 
  filter(pos == "QB") %>% 
  filter(carav > 0) %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical)

RB.DF <- DF.Off %>% 
  filter(pos == "RB") %>% 
  filter(carav > 0) %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical)

TE.DF <- DF.Off %>% 
  filter(pos == "TE") %>% 
  filter(carav > 0) %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical)

FB.DF <- DF.Off %>% 
  filter(pos == "FB") %>% 
  filter(carav > 0) %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical)

LB.DF <- DF.Def %>% 
  filter(pos == "LB" | pos == "OLB" | pos == "ILB") %>% 
  filter(carav > 0) %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical)

DLine.DF <- DF.Def %>% 
  filter(pos == "NT"| pos == "DL" | pos == "DE" | pos == "DT") %>% 
  filter(carav > 0) %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical)

DB.DF <- DF.Def %>% 
  filter(pos == "DB" | pos == "CB"| pos == "S"| pos == "FS"| pos == "SS") %>% 
  filter(carav > 0) %>% 
  select(player, pick, pos, year, age, carav, bench, broad, forty, threecone, shuttle, vertical)

Full.DF <- rbind(DB.DF, DLine.DF, LB.DF, FB.DF, TE.DF, RB.DF, WR.DF, QB.DF, OLine.DF)

combine.data <- read.csv("Source-Data/combine.csv") %>% 
  select(nameFull, heightInches, weight, ageAtDraft, combine40yd, combineShuttle, combineVert, combineBench, combine3cone, combineBroad) %>% 
  rename("player" = nameFull)
Full.DF = Full.DF %>% 
  select(-c(bench, broad, forty, threecone, shuttle, vertical))
DF.join <- na.omit(left_join(na.omit(combine.data), Full.DF))
DF.join <- DF.join[!duplicated(DF.join$player), ]

DF.Final = DF.join %>% 
  arrange(desc(carav)) %>% 
  filter(pos != "QB" & pos != "FB")

for (i in 1:nrow(DF.Final)) {
  if (DF.Final$pos[i] == "CB" | DF.Final$pos[i] == "S") {
    DF.Final$position[i] = "DB"
  } else if (DF.Final$pos[i] == "C" | DF.Final$pos[i] == "G" | DF.Final$pos[i] == "T" | DF.Final$pos[i] == "OL") {
    DF.Final$position[i] = "OLine"
  } else if (DF.Final$pos[i] == "DE" | DF.Final$pos[i] == "DT" | DF.Final$pos[i] == "NT"){
    DF.Final$position[i] = "DLine"
  } else if (DF.Final$pos[i] == "ILB" | DF.Final$pos[i] == "OLB") {
    DF.Final$position[i] = "LB"
  } else {
    DF.Final$position[i] = as.character(DF.Final$pos[i])
  }
}

DF.Final$Type <- factor(ifelse(DF.Final$position == "OLine" | DF.Final$position == "DLine", 1,
                               ifelse(DF.Final$position == "LB" | DF.Final$position == "TE", 2, 3)))
#this will mean 1 is big strong players, 2 is mixed, 3 is skill

DF.Final = DF.Final %>% 
  mutate("carav.scale" = carav/3)

write.csv(OLine.DF, "derived_data/OLine.csv")
write.csv(QB.DF, "derived_data/QB.csv")
write.csv(TE.DF, "derived_data/TE.csv")
write.csv(RB.DF, "derived_data/RB.csv")
write.csv(WR.DF, "derived_data/WR.csv")
write.csv(FB.DF, "derived_data/FB.csv")
write.csv(LB.DF, "derived_data/LB.csv")
write.csv(DLine.DF, "derived_data/DLine.csv")
write.csv(DB.DF, "derived_data/DB.csv")
write.csv(Full.DF, "derived_data/Full.DF.csv")
write.csv(DF.Final, "derived_data/Final_Data.csv")