DF.Final <- read.csv("derived_data/Final_Data.csv")
library(caret)
library(tidyverse)
library(randomForest)
library(knitr)
library(dplyr)
set.seed(123)

trainIndex <- createDataPartition(y = DF.Final$carav, p = .8, times = 1, list = F)
train_ctrl <- trainControl(method = "cv", number = 10)
DF.Test <- DF.Final[-trainIndex, ]
#use caret to get the nice parameters then build the rf model
mod.test <- train(carav.scale ~ heightInches +
                    weight +
                    combine40yd +
                    combineShuttle +
                    combineVert +
                    combineBroad +
                    combine3cone +
                    combineBench,
                  data = DF.Final[trainIndex, ],
                  preProcess = c("center", "scale"),
                  method = "rf",
                  trControl = train_ctrl,
                  verbose = F,
                  distribution = "gaussian")
# mod.test
# plot(mod.test)

mod <- randomForest(carav.scale ~ heightInches +
                      weight +
                      combine40yd +
                      combineShuttle +
                      combineVert +
                      combineBroad +
                      combine3cone +
                      combineBench,
                    data = DF.Final[trainIndex, ],
                    mtry = 2, type = "regression", ntree = 500, keep.forest = T)
png(filename = "derived_graphs/rf.VarImp.plot.png")
varImpPlot(mod)
dev.off()
saveRDS(mod, "models/rf.model.rds")