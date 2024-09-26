library(tidyverse)
library(lme4)
library(lmerTest)

repfr_data <- read_csv("dataframes/exp2_stat_data.csv")


repfr_data <- repfr_data %>%
  group_by(subject) %>%
  mutate(
    sub_mean_recs = mean(recs),
    rel_recs = recs - sub_mean_recs,
    sub_mean_corr_recs = mean(correct_recs),
    rel_corr_recs = correct_recs - sub_mean_corr_recs, 
    sub_mean_sem = mean(sem),
    rel_sem = recs - sub_mean_sem,
    sub_mean_lag = mean(lag),
    rel_lag = recs - sub_mean_lag
  ) %>% ungroup %>% mutate(
    rel_recs_scale = as.vector(scale(rel_recs)),
    sub_mean_recs_scale = as.vector(scale(sub_mean_recs)),
    rel_corr_recs_scale = as.vector(scale(rel_corr_recs)),
    sub_mean_corr_recs_scale = as.vector(scale(sub_mean_corr_recs)),
    rel_sem_scale = as.vector(scale(rel_sem)),
    sub_mean_sem_scale = as.vector(scale(sub_mean_sem)),
    rel_lag_scale = as.vector(scale(rel_lag)),
    sub_mean_lag_scale = as.vector(scale(sub_mean_lag)),
    session_cent = session - 5.5
  )
repfr_data$session_fct <- factor(repfr_data$session)


# Recall Performance

# correct recs as a function of session
m_correct_recs_lin <- lmer(correct_recs ~ session_cent + (session_cent | subject), data = repfr_data)
summary(m_correct_recs_lin)
m_correct_recs_lin_ns1 <- lmer(correct_recs ~ session_cent + (session_cent || subject), data = repfr_data)
summary(m_correct_recs_lin_ns1)


# recs as a function of session
m_recs_lin <- lmer(recs ~ session_cent + (session_cent | subject), data = repfr_data)
summary(m_recs_lin)
m_recs_lin_ns1 <- lmer(recs ~ session_cent + (session_cent || subject), data = repfr_data)
summary(m_recs_lin_ns1)



# intrusions as a function of session
m_intr_lin <- lmer(intrusions ~ session_cent + (session_cent | subject), data = repfr_data)
m_intr_lin_ns1 <- lmer(intrusions ~ session_cent + (session_cent || subject), data = repfr_data)
summary(m_intr_lin_ns1)







# Semantic and Temporal Clustering

# anova sem across sessions
m_sem <- lmer(sem ~ session_fct + (1 | subject), data = repfr_data)
summary(m_sem)
anova(m_sem)


# anova lag across sessions
m_lag <- lmer(lag ~ session_fct + (1 | subject), data = repfr_data)
summary(m_lag)
anova(m_lag)






# Subjective clustering

# subj as a function of session
m_subj_lin <- lmer(subj ~ session + (session | subject), data = repfr_data)
m_subj_lin1 <- lmer(subj ~ session + (session || subject), data = repfr_data)
summary(m_subj_lin1)


# subj as a function of recs (relative and mean) and session
m_subj_lin_recs <- lmer(subj ~ session_cent + rel_recs_scale + sub_mean_recs_scale + 
                          (session_cent + rel_recs_scale | subject), data = repfr_data)
m_subj_lin_recs_ns1 <- lmer(subj ~ session_cent + rel_recs_scale + sub_mean_recs_scale + 
                              (session_cent + rel_recs_scale || subject), data = repfr_data)
m_subj_lin_recs_ns2 <- lmer(subj ~ session_cent + rel_recs_scale + sub_mean_recs_scale + 
                              (1 | subject), data = repfr_data)
summary(m_subj_lin_recs_ns2)


# subj as a function semantic (relative and mean) (M1)
m_subj_sem <- lmer(subj ~ rel_sem_scale + sub_mean_sem_scale + 
                     (rel_sem_scale | subject), data = repfr_data)
m_subj_sem_ns1 <- lmer(subj ~ rel_sem_scale + sub_mean_sem_scale + 
                     (rel_sem_scale || subject), data = repfr_data)
m_subj_sem_ns2 <- lmer(subj ~ rel_sem_scale + sub_mean_sem_scale + 
                         (1 | subject), data = repfr_data)
summary(m_subj_sem_ns2)


# subj as a function of session and semantic (relative and mean) (M2)
m_subj_lin_sem <- lmer(subj ~ session_cent + rel_sem_scale + sub_mean_sem_scale + 
                         (session_cent + rel_sem_scale | subject), data = repfr_data)
m_subj_lin_sem_ns1 <- lmer(subj ~ session_cent + rel_sem_scale + sub_mean_sem_scale + 
                             (session_cent + rel_sem_scale || subject), data = repfr_data)
m_subj_lin_sem_ns2 <- lmer(subj ~ session_cent + rel_sem_scale + sub_mean_sem_scale + 
                             (1 | subject), data = repfr_data)
summary(m_subj_lin_sem_ns2)


# subj as a function session and temp (relative and mean) (M2)
m_subj_lin_lag <- lmer(subj ~ session_cent + rel_lag_scale + sub_mean_lag_scale + 
                         (session_cent + rel_lag_scale | subject), data = repfr_data)
m_subj_lin_lag_ns1 <- lmer(subj ~ session_cent + rel_lag_scale + sub_mean_lag_scale + 
                             (session_cent + rel_lag_scale || subject), data = repfr_data)
m_subj_lin_lag_ns2 <- lmer(subj ~ session_cent + rel_lag_scale + sub_mean_lag_scale + 
                             (1 | subject), data = repfr_data)

summary(m_subj_lin_lag_ns2)

