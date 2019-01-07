library(dplyr)
library(tidyr)
library(readr)


#Uvoz in ureditev tabele za BDP
BDP <- read_csv("podatki/BDP.csv", na=":")
BDP[,c(3,4,6)] <- NULL
names(BDP) <- c("Leto", "Država", "BDP")


#Uvoz in ureditev tabele za izseljevanje
emi_naslednja <- read_csv("podatki/emi_naslednja.csv", na=":")
emi_naslednja[,c(4:7,9)] <- list(NULL)
names(emi_naslednja) <- c("Leto", "Država", "Država izselitve", "število")


#Uvoz in ureditev tabele za izseljevanje po starosti in spolu
emi_starost_spol <- read_csv("podatki/emi_starost_spol.csv", na=":")
emi_starost_spol[,c(3,4,6,9)] <- list(NULL)
names(emi_starost_spol) <- c("Leto", "Država","Starost", "Spol", "Število")


#Uvoz in ureditev tabele za priseljevanje po starosti in spolu
imig_starost_spol <- read_csv("podatki/imig_starost_spol.csv",na=":")
imig_starost_spol[,c(3,4,6,9)] <- list(NULL)
names(imig_starost_spol) <- c("Leto", "Država", "Starost", "Spol", "število")


#Uvoz in ureditev tabele za priseljevanje po narodnosti
imig_po_narodnosti <- read_csv("podatki/imig_po_narodnosti.csv", na=":")
imig_po_narodnosti[,c(4,5,6,8)]<-list(NULL)
names(imig_po_narodnosti) <- c("Leto", "Država", "Državljanstvo", "število")




 

