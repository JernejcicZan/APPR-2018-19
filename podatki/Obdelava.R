library(ggplot2)
library(dplyr)
library(tidyr)

#Podatki uvoženi
BDP_in_rast
emi_next_destination
emi_po_starosti_in_spolu
imig_po_spolu_in_starosti
imigr_po_narodnosti
#Podatki prebrani

#Nepotrbni stolpci pobrisani
BDP_in_rast[4] <- NULL
BDP_in_rast[5] <- NULL
emi_next_destination[4:7] <- list(NULL)
emi_next_destination[5] <- NULL
emi_po_starosti_in_spolu[,c(3,4,6,9)] <- list(NULL)
imig_po_spolu_in_starosti[,c(3,4,6,9)] <- list(NULL)
imigr_po_narodnosti[,c(4,5,6,8)]<-list(NULL)

#Preimenovanje stolpcev
names(BDP_in_rast) <- c("Leto", "Država", "BDP_rast", "število")
names(emi_next_destination) <- c("Leto", "Država", "Država izselitve", "število")
names(emi_po_starosti_in_spolu) <- c("Leto", "Država","Starost", "Spol", "Število")
names(imig_po_spolu_in_starosti) <- c("Leto", "Država", "Starost", "Spol", "število")
names(imigr_po_narodnosti) <- c("Leto", "Država", "Državljanstvo", "število")

melt(BDP_in_rast)
BDP_in_rast <- spread(BDP_in_rast, BDP_rast, število)
names(BDP_in_rast) <- c("Leto", "Država", "Rast BDP", "BDP per capita")

#v imig_po_spolu_starosti moramo pobrisat vrstice, kjer je starostena od
#(Less than 15 years,From 15 to 64 years,From 65 to 69 years),enako pri emi_po_spolu

imig_po_spolu_in_starosti <- subset(imig_po_spolu_in_starosti, Starost=="Less than 15 years" |
        Starost=="From 15 to 64 years" | Starost=="65 years or over" | Starost=="Total"  )

emi_po_starosti_in_spolu <- subset(emi_po_starosti_in_spolu, Starost=="Less than 15 years" |
        Starost=="From 15 to 64 years" | Starost=="65 years or over" | Starost=="Total" )

imigr_po_narodnosti <- imigr_po_narodnosti[!(imigr_po_narodnosti$Državljanstvo %in% c("Foreign country","Europe","Reporting country")),]




