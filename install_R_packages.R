packages = c('cowplot', 'NHANES', 'BayesFactor', 'fivethirtyeight',
             'bayestestR', 'psych', 'DHARMa', 'broom.mixed', 
             'emmeans', 'GPArotation', 'optimx', 'lmerTest', 'pbkrtest',
             'ggbeeswarm', 'pander', 'devtools', 'janitor',
             'pwr', 'kableExtra', 'sfsmisc', 'DiagrammeR', 
             'ggdendro', 'gplots', 'pdist', 'factoextra',
             'mclust', 'MuMIn', 'influence.ME', 'ggExtra')

for (package in packages){
    install.packages(package, repos='http://cran.us.r-project.org')
}

devtools::install_github("wmurphyrd/fiftystater")
