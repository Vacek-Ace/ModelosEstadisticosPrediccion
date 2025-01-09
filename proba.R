set.seed(374683)
library(dplyr)        

library(ggplot2)
ic=matrix(0,100,5)
ic[,1]=seq(1:100)
ic=as.data.frame(ic)
colnames(ic)=c("id","estimador","inferior","superior","resultado")
ic$resultado="in"
for (i in 1:100){
  muestra=rnorm(50,10,1)
  ic[i,2]=mean(muestra)
  ic[i,3]=mean(muestra)-5*1/sqrt(50)   
  ic[i,4]=mean(muestra)+5*1/sqrt(50) 
}
ic$resultado=!(ic[,3]>10 | ic[,4]<10)
ic %>%
  ggplot(aes(estimador, id, color = resultado)) +
  geom_point() +
  geom_segment(aes(x =inferior, y = id, xend = superior, yend = id, color = resultado))+
  geom_vline(xintercept = 10, linetype = "dashed") +
  ggtitle("Varios Intervalos de Confianza") +
  scale_color_manual(values = c("#FF3333", "#009900")) +
  theme_minimal() +
  theme(axis.text.y = element_blank(), 
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        legend.position = "none",
        plot.title.position = "plot")
