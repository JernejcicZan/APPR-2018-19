# 4. faza: Analiza podatkov
source('lib/libraries.r', encoding = 'UTF-8')

#Napoved prirastka za države z največjim in najnižjim BDP

najrazvitejse <- neto_tabela %>% filter(Država %in% najvecji.bdp$Država)
najmanj_razvite <- neto_tabela %>% filter(Država %in% najnizji.bdp$Država)
najmanj_razvite[is.na(najmanj_razvite)] <- 0

najrazvitejse <- najrazvitejse %>% group_by(Leto) %>% summarise(Neto = sum(Neto))
najmanj_razvite <- najmanj_razvite %>% group_by(Leto) %>% summarise(Neto = sum(Neto))


fit <- lm(data=najrazvitejse, Neto ~ Leto)
leta <- data.frame(Leto=seq(2011, 2021))
predict(fit, leta)
napoved.prirastka1 <- mutate(leta, Neto=predict(fit, leta))

podatki <- lm(data=najmanj_razvite, Neto ~ Leto)
cas <- data.frame(Leto=seq(2011, 2021))
predict(podatki, cas)
napoved.prirastka2 <- mutate(cas, Neto=predict(podatki, cas))

graf.napovedi.prirastka1 <- ggplot(data=najrazvitejse, aes(x=Leto, y=Neto)) + 
  geom_smooth(method = "lm", formula = y ~ x + I(x^2), fullrange = TRUE) +
  geom_point(data=napoved.prirastka1) 




graf.napovedi.prirastka2 <- ggplot(data=najmanj_razvite, aes(x=Leto, y=Neto)) + 
  geom_smooth(method = "lm", formula = y ~ x + I(x^2), fullrange = TRUE) +
  geom_point(data=napoved.prirastka2) 




print(graf.napovedi.prirastka2)