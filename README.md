# RaflEtal24
Memory Across Days analyses code. Processing and analyses of the data are coded into the four .ipynb and three .R notebooks of this repository:
- processing.ipnyb: experimental events are processed to only include events used in the analyses of both experiments. Also, generates the similarity matrices used for semantic clsutering analyses.
- Recal_performance: analyses of recall performance (correct and false recall rates) for experiments 1 and 2.
- Exp1_beh_analyses: analyses of semantic, temporal and subjective clustering in Experiment 1. These analyses reference functions in pybeh_pd.py, pybeh_pd_min.py and pybeh_copy.py.
- Exp2_beh_analyses: analyses of semantic, temporal, and subjective clustering in Experiment 2, as well as the code for the intrusion recency analysis (reported in Figure 5 of the manuscript). These analyses reference functions in pybeh_pd.py, pybeh_pd_min.py and pybeh_copy.py.
- stat_dataframes: compiles all dataframes reporting various clustering scores and recall performance measurements across sessions into a single dataframe for each experiment. These dataframes are then used by exp1_stat.R and exp2_stat.R to fit various models to the data.
- exp1_stat.R: contains all statistical models and analyses pertaining to data of Experiment 1.
- exp2_stat.R: contains all statistical models and analyses pertaining to data of Experiment 2.
- intrusion.R: contains all statistical  models and analyses pertaining to the intrusion analysis reported for Experiment 1.
