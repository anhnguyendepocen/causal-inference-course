"Causal Inference, 2020-1
Juan Andrés Rincón Galvis
juana.rincon@urosario.edu.co
ja.rincong@uniandes.edu.co"

"Assignment 3 - Potential Outcomes and OLS"

"Preliminary Organization"

  #Cleaning Working space
  rm(list = ls())
  cat("\f")
  
  #Setting Working Directory
  Juancho <- "/Users/ja.rincong/Git/causal-inference-course/Assignment 3"
  setwd(Juancho)
  
  #Packages
  packs <- c("tidyverse","doBy","gdata","ggforce","haven","Hmisc","lubridate","rdd","readxl","sandwich","stargazer")
  sapply(packs,require,character=TRUE)
  
"----------------------------------OLS----------------------------------"

  #Dataset Creation
  Patient <- seq(1,11,1)
  Y1 <- c(1,1,1,5,5,6,7,7,8,9,10)
  Y0 <- c(10,5,4,6,1,7,8,10,2,6,7)
  Age <- c(29,35,19,45,65,50,77,18,85,96,77)
  #Perfecto Doctor Data Frame
  pd <- data.frame(Patient,Y1,Y0,Age)

    
  
  
  