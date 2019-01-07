#Seštel bom podatke od leta 2011 naprej
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

nova_tabela <- emi_po_starosti_in_spolu
nova_tabela %>% group_by(Država, Starost, Spol) %>% summarize(Skupaj = sum(Število,na.rm = T), Povprečno = mean(Število,na.rm = T))
