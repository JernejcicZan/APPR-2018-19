library(rgdal)
library(rgeos)
library(mosaic)
library(maptools)
library(reshape2)
library(ggplot2)
library(munsell)




najvecji.bdp <- BDP %>% filter(Leto == 2011) %>%
  top_n(8, BDP_pc)

najnizji.bdp <- BDP %>% filter(Leto==2011) %>% top_n(8,-1*BDP_pc)


#Graf BDP za 6 držav z najvišjim in najnižjim BDP-jem
graf_BDP_najvecji <- ggplot(data = BDP %>% filter(Država %in% najvecji.bdp$Država ), 
                   aes(x=Leto, y=BDP_pc, label=Država)) + 
  geom_line(aes(group = Država,color=Država), stat = 'identity', position = 'dodge')

graf_BDP_najmanjsi <- ggplot(data = BDP %>% filter(Država %in% najnizji.bdp$Država ), 
                            aes(x=Leto, y=BDP_pc, label=Država)) + 
  geom_line(aes(group = Država,color=Država), stat = 'identity', position = 'dodge')


#Prikazal bom grafe za Nemčijo(priseljevanje) in Poljsko(odseljevanje)
#Graf za priseljevanje po spolu za Nemčijo 
 
graf_priseljevanja_Nem1 <- ggplot(data=imig_starost_spol %>% filter(Država=="Germany", Spol!="Total"),
                    aes(x=Leto, y=Priseljeni, fill=Spol)) + 
  geom_bar(stat="identity", position="stack") + 
  labs(title="Priseljevanje od 2011 do 2016 po spolu za Nemčijo")


#Graf za priseljevanje po starosti za Nemčijo 

graf_priseljevanja_Nem2 <- ggplot(data=imig_starost_spol %>% filter(Država=="Germany" &Leto==2016 &Starost!="Total"),
                                     aes(x="", y=Priseljeni, fill=Starost)) +
  geom_bar(stat="identity", position="dodge") + 
  labs(title="Priseljevanje v 2016 po starosti za Nemčijo")


najvec.izseljevanja <- emi_starost_spol %>% filter(Starost=="Total", Spol=="Total", Država %in% najnizji.bdp$Država) %>%
  top_n(10, Izseljeni)

#Graf odseljevanja po spolu za Poljsko 

graf_izseljevanja_Pol1 <- ggplot(data=emi_starost_spol %>% filter(Država=="Poland",Starost=="Total"),
                                aes(x=Leto, y=Izseljeni, fill=Spol)) + 
  geom_bar(stat="identity", position = "dodge") + 
  labs(title = "Izseljevanje po spolu od 2011 do 2016 za Poljsko")

#Graf odseljevanja po starosti za Poljsko 

graf_izseljevanja_Pol2 <- ggplot(data=emi_starost_spol %>% filter(Država=="Poland",Spol=="Total",Starost!="Total",Leto==2016),
                                aes(x=Leto, y=Izseljeni, fill=Starost)) + 
  geom_bar(stat="identity", position = "dodge") + 
  labs(title = "Izseljevanje po starosti v letu 2016 za Poljsko")

graf_neto_pol_nem <- ggplot(data=neto_tabela %>% filter(Država %in% c("Poland","Germany")),
                            aes(x=Leto, y=Neto, label=Država)) + 
  geom_line(aes(group = Država,color=Država), stat = 'identity', position = 'dodge') + 
  labs(title="Neto prirastek za Nemčijo in Poljsko")

neto_tabela <- neto_tabela%>%filter(Starost=="Total", Spol=="Total", Leto!=2017)
neto_tabela <- neto_tabela[c(-3,-4)]
neto_bdp <- left_join(BDP,neto_tabela)

#Graf odvisnosti neto priseljevanja od BDP pc 
graf_bdp_neto <- ggplot(data=neto_bdp %>% filter(Leto==2016), 
                        aes(x=BDP_pc,y=Neto)) + 
  geom_point(aes(color=Država)) + 
  labs(title="Povezava med BDP in neto prirastkom priseljevanja")




# Uvozimo zemljevid Sveta
# source("https://raw.githubusercontent.com/jaanos/APPR-2018-19/master/lib/uvozi.zemljevid.r")
source("lib/uvozi.zemljevid.r") #Nastavi pravo datoteko

zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                             "ne_50m_admin_0_countries") %>% fortify()


# Zemljevid sveta skrčimo na zemljevid Evrope
Evropa <- filter(zemljevid, CONTINENT == "Europe" |NAME == "Cyprus")
Evropa <- filter(Evropa, long < 50 & long > -30 & lat > 30 & lat < 75)

ggplot(Evropa, aes(x=long, y=lat, group=group, fill=id)) + 
  geom_polygon() + 
  labs(title="Evropa") +
  theme(legend.position="none")

evropske_drzave <- unique(Evropa$NAME)
evropske_drzave <- as.data.frame(evropske_drzave, stringsAsFactors=FALSE)
names(evropske_drzave) <- "Country"

priseljeni.2016 <- imig_starost_spol %>% filter(Leto==2016, Starost=="Total", Spol=="Total")
priseljeni.2016 <- priseljeni.2016[c(-1,-3,-4)]
names(priseljeni.2016) <- c("Country", "Priseljeni")

ujemanje <- left_join(priseljeni.2016, evropske_drzave, by="Country")

#Zemljevid neto prirastka za leto 2016 bolj svetle večji bolj temne negativen prirastek

map <- ggplot() + geom_polygon(data=left_join(Evropa,ujemanje, by=c("NAME"="Country")),
                               aes(x=long, y=lat, group=group, fill=Priseljeni)) +
  ggtitle("Število priseljencev v letu 2016") + xlab("") + ylab("") +
  guides(fill=guide_colorbar(title="Število priseljencev"))
