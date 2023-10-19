
library(readxl)
library(tidyverse)
library(MatchIt)
getwd()

data<-read_xlsx("data_smoking.xlsx")
attach(data)

colnames(data)<-c("SrNo","Mother_smoking","Child_weight","Mother_ed","Father_ed",
                     "Father_smoking","MHI","PerCapitaInc")
#RCT

data %>%
  count(Mother_smoking) %>%
  mutate(prop=n/sum(n))

#Checking for balance
data%>%
  group_by(Mother_smoking) %>%
  summarize(avg_inc = mean(PerCapitaInc),
            avg_mhi = mean(MHI), avg_fathersmoke = mean(Father_smoking), avg_mothered = mean(Mother_ed),
            avg_fathered = mean(Father_ed))

#Average Treatment Effect

data%>%
  group_by(Mother_smoking)%>%
  summarise(avg_weight=mean(Child_weight))
  
#REGRESSION
reg<-lm(Child_weight~Mother_smoking)
summary(reg)

reg1<-lm(Child_weight~Mother_smoking+MHI+PerCapitaInc+Father_smoking+Mother_ed+Father_ed)
summary(reg1)

reg2<-lm(Child_weight~Mother_smoking+MHI+PerCapitaInc)
summary(reg2)



#Propensity Score Matching
#logit model
pscores.model<-glm(Mother_smoking~MHI+PerCapitaInc+Mother_ed+Father_ed+Father_smoking,family="binomial")
summary(pscores.model)

#remove insignificant variable
pscores.model1<-glm(Mother_smoking~MHI+PerCapitaInc+Mother_ed+Father_ed,family="binomial")
summary(pscores.model1)
psm.score<-data.frame(pr_score=predict(pscores.model,type="response"),training=pscores.model1$model$Mother_smoking)
View(psm.score)
head(psm.score,10)
tail(psm.score,10)

match<- matchit(Mother_smoking~MHI+PerCapitaInc+Mother_ed+Father_ed,
                method="nearest",data=data)
summary(match)
v_treatcont<- match$match.matrix
v_treatcont
plot(match)
dta.match<-match.data(match)
dim(dta.match)
head(dta.match)
dim(data)

#Estimating treatment effect
#Though difference in means
treated<-subset(dta.match,Mother_smoking==1)
control<-subset(dta.match,Mother_smoking==0)
mean(treated$Child_weight)-mean(control$Child_weight)

#Selection bias
treat1<-lm(Child_weight~Mother_smoking,data=data)
summary(treat1)

treat2<-lm(Child_weight~Mother_smoking,data=dta.match)
summary(treat2)

treat1$coefficients[2]-treat2$coefficients[2]



