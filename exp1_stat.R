library(tidyverse)
library(lme4)
library(lmerTest)
library(stats)

vffr_data <- read_csv("dataframes/exp1_stat_data.csv")

vffr_data <- vffr_data %>%
  group_by(subject) %>%
  mutate(
    sub_mean_corr_recs = mean(correct_recs),
    rel_corr_recs = correct_recs - sub_mean_corr_recs,
    sub_mean_recs = mean(recs),
    rel_recs = recs - sub_mean_recs,
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
    session_cent = session - 7
    
  )
vffr_data$session_fct <- factor(vffr_data$session)


# Recall Performance

# corr recs as a function of sessions
m_correct_recs_lin <- lmer(correct_recs ~ session_cent + (session_cent | subject), data = vffr_data)
summary(m_correct_recs_lin)

# recs as a function of sessions
m_recs_lin <- lmer(recs ~ session_cent + (session_cent | subject), data = vffr_data)
summary(m_recs_lin)

# intrusions as a function of session
m_intr_lin <- lmer(intr ~ session_cent + (session_cent | subject), data = vffr_data)
summary(m_intr_lin)




# Semantic and Temporal Clustering

# anova lag across sessions
m_lag <- lmer(lag ~ session_fct + (1 | subject), data = vffr_data)
summary(m_lag)
anova(m_lag)

# anova sem across sessions
m_sem <- lmer(sem ~ session_fct + (1 | subject), data = vffr_data)
summary(m_sem)
anova(m_sem)

# sem as a function of session
m_sem_lin <- lmer(sem ~ session_cent + (session_cent | subject), data = vffr_data)
summary(m_sem_lin)

# sem as a function of corr recs (relative and mean) and session
m_sem_lin_recs <- lmer(sem ~ session_cent  + rel_corr_recs_scale + sub_mean_corr_recs_scale + 
                         (session_cent  + rel_corr_recs_scale | subject), data = vffr_data)
m_sem_lin_recs_ns1 <- lmer(sem ~ session_cent  + rel_corr_recs_scale + sub_mean_corr_recs_scale + 
                              (session_cent + rel_corr_recs_scale || subject), data = vffr_data)
m_sem_lin_recs_ns2 <- lmer(sem ~ session_cent + rel_corr_recs_scale + sub_mean_corr_recs_scale +
                              (session_cent || subject), data = vffr_data)
summary(m_sem_lin_recs_ns2)




# Subjective Clustering

# subj as a function of session
m_subj_lin <- lmer(subj ~ session_cent + (session_cent | subject), data = vffr_data)
summary(m_subj_lin)


# subj as a function of recs (relative and mean) and session
m_subj_lin_recs <- lmer(subj ~ session_cent + rel_recs_scale + sub_mean_recs_scale + 
                          (session_cent + rel_recs_scale | subject), data = vffr_data)
m_subj_lin_recs_ns1 <- lmer(subj ~ session_cent + rel_recs_scale + sub_mean_recs_scale + 
                              (session_cent + rel_recs_scale || subject), data = vffr_data)
m_subj_lin_recs_ns2 <- lmer(subj ~ session_cent + rel_recs_scale + sub_mean_recs_scale + 
                              (session_cent || subject), data = vffr_data)
m_subj_lin_recs_ns3 <- lmer(subj ~ session_cent + rel_recs_scale + sub_mean_recs_scale + 
                              (1 | subject), data = vffr_data)
summary(m_subj_lin_recs_ns3)


# subj as a function of sem (relative and mean) (M1)
m_subj_sem <- lmer(subj ~ rel_sem_scale + sub_mean_sem_scale + 
                     (rel_sem_scale | subject), data = vffr_data)
m_subj_sem_ns1 <- lmer(subj ~ rel_sem_scale + sub_mean_sem_scale + 
                         (rel_sem_scale || subject), data = vffr_data)
m_subj_sem_ns2 <- lmer(subj ~ rel_sem_scale + sub_mean_sem_scale + 
                         (1 | subject), data = vffr_data)
summary(m_subj_sem_ns2)


# subj as a function of session and sem(relative and mean) (M2)
m_subj_lin_sem <- lmer(subj ~ session_cent + rel_sem_scale + sub_mean_sem_scale + 
                         (session_cent + rel_sem_scale | subject), data = vffr_data)

m_subj_lin_sem_ns1 <- lmer(subj ~ session_cent + rel_sem_scale + sub_mean_sem_scale + 
                             (session_cent + rel_sem_scale || subject), data = vffr_data)
m_subj_lin_sem_ns2 <- lmer(subj ~ session_cent + rel_sem_scale + sub_mean_sem_scale + 
                             (1 | subject), data = vffr_data)
summary(m_subj_lin_sem_ns2)



# subj as a function of sess and temp (rel and mean) (M2)
m_subj_lag_sess <- lmer(subj ~ session_cent + rel_lag_scale + sub_mean_lag_scale + 
                          (session_cent + rel_lag_scale | subject), 
                        data = vffr_data)
m_subj_lag_sess_ns1 <- lmer(subj ~ session_cent + rel_lag_scale + sub_mean_lag_scale + 
                              (session_cent + rel_lag_scale || subject), 
                            data = vffr_data)
m_subj_lag_sess_ns2 <- lmer(subj ~ session_cent + rel_lag_scale + sub_mean_lag_scale + 
                              (1 | subject), 
                            data = vffr_data)
summary(m_subj_lag_sess_ns2)

