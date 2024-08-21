library(tidyverse) # for summarizing the data to get means and sds of categories 
library(ggsci) # for color palettes of scieintifc journals
library(ggpubr) # for theme pubr

iris_plot =  gather(iris,FlPrt,Length,1:4)

iris_plot= group_by(iris_plot, Species,FlPrt)

iris_plot=summarise(iris_plot,mnL=mean(Length),sdL=sd(Length)) 

iris_plot=  ggplot(iris_plot,aes(reorder(Species,mnL),mnL,fill=reorder(FlPrt,mnL)))+
  geom_bar(stat="identity",position="dodge")+
  geom_text(mapping=aes(label=mnL),position=position_dodge(width=0.9),
            cex=2.5,vjust=-4)+
  labs(title="Iris: Measurment of floral organs",
       subtitle="Length abd width of srpal abd petal",
       x="Species",y="Length ib cm",
       caption="Data: iris dataset by Edgar Anderson",fill="Description")+
  geom_errorbar(mapping=aes(ymin=mnL-sdL,ymax=mnL+sdL),
                width=0.2,position=position_dodge(width=0.9))+
  theme_classic()+scale_fill_jco()
