## ----include=FALSE-------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(eval=TRUE, echo=TRUE, message=FALSE, warnings=FALSE)
solution <- TRUE


## ---- readin, message=FALSE----------------------------------------------------------------------------------------
library(Distance)
data("DuikerCameraTraps")


## ----smaltable, eval=TRUE------------------------------------------------------------------------------------------
sum(!is.na(DuikerCameraTraps$distance))
table(DuikerCameraTraps$Sample.Label)


## ---- eval=TRUE----------------------------------------------------------------------------------------------------
breakpoints <- c(seq(0,8,1), 10, 12, 15, 21)
hist(DuikerCameraTraps$distance, breaks=breakpoints, main="Peak activity data set",
     xlab="Radial distance (m)")


## ----fit, eval=TRUE------------------------------------------------------------------------------------------------
conversion <- convert_units("meter", NULL, "square kilometer")
trunc.list <- list(left=2, right=15)
mybreaks <- c(seq(2,8,1), 10, 12, 15)
hn0 <- ds(DuikerCameraTraps, transect = "point", key="hn", adjustment = NULL,
          cutpoints = mybreaks, truncation = trunc.list)
hn1 <- ds(DuikerCameraTraps, transect = "point", key="hn", adjustment = "herm",
          order=2,
          cutpoints = mybreaks, truncation = trunc.list)
hn2 <- ds(DuikerCameraTraps, transect = "point", key="hn", adjustment = "herm",
          order=c(4,6),
          cutpoints = mybreaks, truncation = trunc.list)

uni1 <- ds(DuikerCameraTraps, transect = "point", key="unif", adjustment = "cos",
           order=1,
           cutpoints = mybreaks, truncation = trunc.list)
uni2 <- ds(DuikerCameraTraps, transect = "point", key="unif", adjustment = "cos",
           order=c(1,2),
           cutpoints = mybreaks, truncation = trunc.list)

hr0 <- ds(DuikerCameraTraps, transect = "point", key="hr", adjustment = NULL,
          cutpoints = mybreaks, truncation = trunc.list)
hr1 <- ds(DuikerCameraTraps, transect = "point", key="hr", adjustment = "cos",
          order=2,
          cutpoints = mybreaks, truncation = trunc.list)
hr2 <- ds(DuikerCameraTraps, transect = "point", key="hr", adjustment = "cos",
          order=c(2,3),
          cutpoints = mybreaks, truncation = trunc.list)


## ----assessment, eval=TRUE-----------------------------------------------------------------------------------------
knitr::kable(summarize_ds_models(hn0,hn1,uni1,uni2,hr0,hr1,hr2),
             caption="Summary of fitted models", row.names = FALSE,
             digits = c(0,0,0,5,3,4,1))


## ----storeresults, eval=TRUE---------------------------------------------------------------------------------------
fittedmodels <- c("hn0", "hn1", "hn2", "uni1", "uni2", "hr0", "hr1", "hr2")
save(list=fittedmodels, file="duikermodels.RData")

