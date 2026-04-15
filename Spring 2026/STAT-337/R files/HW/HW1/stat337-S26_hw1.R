# 337 HW 1 code
library(tidyverse)
library(yarrr)
library(mosaic)
library(multcomp)

df_biggie30 <- read_csv("big-sky-biggie_clean30.csv")
df_race <- df_biggie30 %>%  
  mutate(age_group = factor(age_group))

favstats(tot_time ~ age_group, data = df_race)
pirateplot(tot_time ~ age_group, data = df_race)

fit_30a <- lm(tot_time ~ age_group -1, data = df_race)

fit_30b <- lm(tot_time ~ age_group, data = df_race)
summary(fit_30b)

anova(fit_30b)

par(mfrow = c(1,4))
plot(fit_30b)

pairs <- glht(fit_30b, linfct = mcp(age_group = "Tukey"))
par(mfrow = c(1,1))
plot(pairs)
confint(pairs)
cld(pairs)
