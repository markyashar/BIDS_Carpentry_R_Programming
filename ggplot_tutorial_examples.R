?boxplot

# Take a look at the cheatsheets

stripchart(inflammation[,10])
colpal = c("red", "green", "blue")
plot(iris$Sepal.Length, iris$Sepal.Width, col=colpal[iris$Species])

##########

iris   # iris is a dataframe
head(iris)

install.packages("ggplot2")  # we've already installed this

library(ggplot2)  # use library instead of require

ggplot(iris, aes(x=Sepal.Length, y= Petal.Length)) + 
  geom_point(aes(colour = Sepal.Width), size=6, alpha=0.5) +
  geom_smooth() +
  theme_classic()

ggplot(iris) +  geom_boxplot(aes(y=Sepal.Width, x = Species))
ggplot(iris) +  geom_violin(aes(y=Sepal.Width, x = Species))
ggplot(iris) +  geom_violin(aes(x=1, y=Sepal.Width )) +
  geom_jitter(aes(x=1, y=Sepal.Width, col=Petal.Length))+
  facet_wrap(~Species) + 
  theme_bw() +
  ylab("Sepal Width") +
  xlab("")

# gridExtra -- package worth  
install.packages("dplyr")
library(dplyr)
iris %>% head()
  
iris %>%
  filter(Species == "setosa") %>%
  summarize(mean_sepal_length = mean(Sepal.Length))

iris %>%
  group_by(Species) %>%
  summarize(mean_sepal_length = mean(Sepal.Length)) %>%
  ggplot() +
  geom_boxplot(aes(x=1, y=mean_sepal_length))
  