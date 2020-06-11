"Causal Inference, 2020-1
Juan Andrés Rincón Galvis
juana.rincon@urosario.edu.co
ja.rincong@uniandes.edu.co"

"Assignment 3 - Potential Outcomes and OLS"
#Instructions to this script are in this very repository: "causal-inference-course/Assignment 3/Instructions".

"Preliminary Organization"

  #Cleaning Working space
  rm(list = ls())
  cat("\f")
  
  #Setting Working Directory
  Juancho <- "/Users/ja.rincong/Git/causal-inference-course/Assignment 3"
  setwd(Juancho)
  
  #Packages
  packs <- c("tidyverse","doBy","gdata","ggforce","haven","Hmisc","lubridate","rdd","readxl","sandwich","stargazer","dagitty")
  sapply(packs,require,character=TRUE)
  
"----------------------------------Potential Outcomes----------------------------------"

  #Dataset Creation
  Patient <- seq(1,11,1)
  Y1 <- c(1,1,1,5,5,6,7,7,8,9,10)
  Y0 <- c(10,5,4,6,1,7,8,10,2,6,7)
  Age <- c(29,35,19,45,65,50,77,18,85,96,77)
  #Perfect Doctor Data Frame
  pd <- data.frame(Patient,Y1,Y0,Age)
  
  #Variable Creation
  pd <- pd %>% mutate(TE=Y1-Y0) %>% mutate(D=ifelse(TE>0,1,0)) %>% mutate(Y=ifelse(TE>0,Y1,Y0))
  ATE <- mean(pd$TE)
  SDO <- mean(pd$Y1[pd$D==1])-mean(pd$Y0[pd$D==0])
  ATT <- mean(pd$TE[pd$D==1])
  ATU <- mean(pd$TE[pd$D==0])
  Sel_Bias <- mean(pd$Y0[pd$D==1])-mean(pd$Y0[pd$D==0])
  HTE_Bias <- ATT-ATU

  #Calculation proof
  ATE+Sel_Bias+HTE_Bias*(1-mean(pd$D))
  SDO

"----------------------------------Ordinary Least Squares----------------------------------"
  
  #Dataset from perfect doctor
  pd_ols <- pd %>% select(D,Age,Y)
  
  #Estimation model 1
  mdl1 <- Y ~ D
  mdl1_fit <- lm(formula = mdl1, data = pd_ols)
  summary(mdl1_fit)
  
  #Estimation model 2, controlling for age
  mdl2 <- Y ~ D + Age
  mdl2_fit <- lm(formula = mdl2, data = pd_ols)
  summary(mdl2_fit)
  
  #Beautiful Table 1
  stargazer(mdl1_fit,mdl2_fit,
            title = "Regression results for models (a) and (b). Note: standard errors are in parentheses. Made in R with the \texttt{stargazer} package.",
            out = "Tables/Table1.tex",
            column.labels = c("(a)","(b)"),
            model.names = T, multicolumn = T
            )
  
  #Auxiliary regression
  aux_mdl <- D ~ Age
  aux_mdl_fit <- lm(formula = aux_mdl, data = pd_ols)
  summary(aux_mdl_fit)
  
  #Residual of the Auxiliary regression
  pd_ols$D2 <- aux_mdl_fit$residuals
  mdl3 <- Y ~ D2
  mdl3_fit <- lm(formula = mdl3, data = pd_ols)  
  summary(mdl3_fit)  

  #Beautiful Table 2
  stargazer(mdl2_fit,aux_mdl_fit,mdl3_fit,
            title = "Regression results for the linear model equations in (c).", 
            out = "Tables/Table2.tex",
            model.names = T, multicolumn = T, model.numbers = T
            )
  

  
  
  
  
  
  