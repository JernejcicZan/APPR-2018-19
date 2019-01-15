library(dplyr)
library(tidyr)
library(readr)


#Uvoz in ureditev tabele za BDP
BDP <- read_csv("podatki/BDP.csv", na=":")
BDP <- BDP[c(-3,-4,-6)]
names(BDP) <- c("Leto", "Država", "BDP_pc")
BDP$Država <- gsub("^Germany.*", "Germany",BDP$Država)
BDP <- BDP%>%filter(Leto!=2017)

#Uvoz in ureditev tabele za izseljevanje
emi_naslednja <- read_csv("podatki/emi_naslednja.csv", na=":")
emi_naslednja <- emi_naslednja[c(-4:-7,-9)]
names(emi_naslednja) <- c("Leto", "Država", "Država izselitve", "Izseljeni")
emi_naslednja$Država <- gsub("^Germany.*", "Germany",emi_naslednja$Država)
emi_naslednja$`Država izselitve` <- gsub("^Germany.*", "Germany",emi_naslednja$`Država izselitve`)



#Uvoz in ureditev tabele za izseljevanje po starosti in spolu
emi_starost_spol <- read_csv("podatki/emi_po_starosti_in_spolu.csv", na=":")
emi_starost_spol <- emi_starost_spol[c(-3,-4,-6,-9)]
names(emi_starost_spol) <- c("Leto", "Država","Starost", "Spol", "Izseljeni")
emi_starost_spol$Država <- gsub("^Germany.*", "Germany",emi_starost_spol$Država)
emi_starost_spol$Starost <- gsub("Less than 15 years", "14 years or less", emi_starost_spol$Starost)
emi_starost_spol$Starost <- gsub("65 years or over", "Over 65 years", emi_starost_spol$Starost)


#Uvoz in ureditev tabele za priseljevanje po starosti in spolu
imig_starost_spol <- read_csv("podatki/imig_po_starosti_in_spolu.csv",na=":")
imig_starost_spol <- imig_starost_spol[c(-3,-4,-6,-9)]
names(imig_starost_spol) <- c("Leto", "Država", "Starost", "Spol", "Priseljeni")
imig_starost_spol <- imig_starost_spol[!(imig_starost_spol$Država=="Former Yugoslav Republic of Macedonia, the"
),]
imig_starost_spol$Država <- gsub("^Germany.*", "Germany",imig_starost_spol$Država)
imig_starost_spol$Starost <- gsub("Less than 15 years", "14 years or less", imig_starost_spol$Starost)
imig_starost_spol$Starost <- gsub("65 years or over", "Over 65 years", imig_starost_spol$Starost)



#Uvoz in ureditev tabele za priseljevanje po narodnosti
imig_po_narodnosti <- read_csv("podatki/imig_po_narodnosti.csv", na=":")
imig_po_narodnosti <- imig_po_narodnosti[c(-4,-5,-6,-8)]
names(imig_po_narodnosti) <- c("Leto", "Država", "Državljanstvo", "število")
imig_po_narodnosti$Država <- gsub("^Germany.*", "Germany",imig_po_narodnosti$Država)
imig_po_narodnosti$Državljanstvo <- gsub("^Germany.*", "Germany",imig_po_narodnosti$Državljanstvo)
imig_po_narodnosti <- imig_po_narodnosti[!(imig_po_narodnosti$Državljanstvo=="Reporting country"),]


neto_tabela <- left_join(imig_starost_spol, emi_starost_spol)
neto_tabela <- neto_tabela %>% mutate(Neto = Priseljeni - Izseljeni)
neto_tabela[,c(5,6)] <- NULL


#Moje tabele
BDP
emi_naslednja
emi_starost_spol
imig_starost_spol
imig_po_narodnosti


 

