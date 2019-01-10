library(dplyr)
library(tidyr)
library(readr)


neto_tabela <- left_join(imig_starost_spol, emi_starost_spol)
neto_tabela <- neto_tabela %>% mutate(Neto = Priseljeni - Izseljeni)
neto_tabela[,c(5,6)] <- NULL


