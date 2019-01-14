library(rgdal)
library(rgeos)
library(mosaic)
library(maptools)
library(reshape2)
library(ggplot2)
library(munsell)

# Uvozimo zemljevid Sveta
# source("https://raw.githubusercontent.com/jaanos/APPR-2018-19/master/lib/uvozi.zemljevid.r")
source("lib/uvozi.zemljevid.r") #Nastavi pravo datoteko

zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                             "ne_50m_admin_0_countries") %>% fortify()


# Zemljevid sveta skrčimo na zemljevid Evrope
Evropa <- filter(zemljevid, CONTINENT == "Europe")
Evropa <- filter(Evropa, long < 55 & long > -45 & lat > 30 & lat < 85)

ggplot(Evropa, aes(x=long, y=lat, group=group, fill=NAME)) + 
  geom_polygon() + 
  labs(title="Evropa") +
  theme(legend.position="none")


najvecji.bdp <- BDP %>% filter(Leto == 2011) %>%
  top_n(10, BDP_pc)

najnizji.bdp <- BDP %>% filter(Leto==2011) %>% top_n(10,-1*BDP_pc)

#Graf za 10 najbolj razvitih držav
graf_BDP_najvecji <- ggplot(data = BDP %>% filter(Država %in% najvecji.bdp$Država), 
                   aes(x=Leto, y=BDP_pc, label=Država)) + 
  geom_line(aes(group = Država,color=Država), stat = 'identity', position = 'dodge')

#Graf za 10 najmanj razvitih držav
graf_BDP_najmanjsi <- ggplot(data = BDP %>% filter(Država %in% najnizji.bdp$Država), 
                   aes(x=Leto, y=BDP_pc, label=Država)) + 
  geom_line(aes(group = Država,color=Država), stat = 'identity', position = 'dodge')

#Graf za priseljevanje po spolu za Nemčijo in Švedsko 
 
graf_priseljevanja_Nem1 <- ggplot(data=imig_starost_spol %>% filter(Država=="Germany", Spol!="Total"),
                    aes(x=Leto, y=Priseljeni, fill=Spol)) + 
  geom_bar(stat="identity", position="stack")

graf_priseljevanja_Swe1 <- ggplot(data=imig_starost_spol %>% filter(Država=="Sweden", Spol!="Total"),
                                 aes(x=Leto, y=Priseljeni, fill=Spol)) + 
  geom_bar(stat="identity", position="stack")

graf_priseljevanja_Nem2 <- ggplot(data=imig_starost_spol %>% filter(Država=="Germany" &Leto==2016& Starost!="Total"),
                                     aes(x="", y=Priseljeni, fill=Starost)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) 

