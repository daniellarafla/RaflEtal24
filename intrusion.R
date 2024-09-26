library(tidyverse)
library(lme4)
library(lmerTest)
library(emmeans)

intr_data <- read_csv("dataframes/exp1_intr_analysis_data.csv")

intr_data$lag_fct <- factor(intr_data$lag)
m1 <- lmer(prob ~ lag_fct + (1 | subject), data = intr_data)
anova(m1)
summary(m1)

emmeans(m1, ~ lag_fct)
emmeans(m1, pairwise ~ lag_fct)
emmeans(m1, pairwise ~ lag_fct, adjust = 'none')
