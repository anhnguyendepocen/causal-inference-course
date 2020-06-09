"Causal Inference, 2020-1
Juan Andrés Rincón Galvis
juana.rincon@urosario.edu.co
ja.rincong@uniandes.edu.co"

"Preliminary Organization"

  #Cleaning Working space
  rm(list = ls())
  cat("\f")
  
  #Setting Working Directory
  Juancho <- 
  setwd(Juancho)
  
  #Packages
  packs <- c("tidyverse","doBy","gdata","ggforce","haven","Hmisc","lubridate","rdd","readxl","sandwich","stargazer")
  sapply(packs,require,character=TRUE)
  
  
  