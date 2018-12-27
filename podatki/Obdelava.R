library(ggplot2)
library(dplyr)


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

#Risanje grafov
# gdp <- filter(BDP_in_rast,BDP_rast == "Current prices, euro per capita")
# View(gdp)
# ggplot2()
