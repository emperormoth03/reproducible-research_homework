#Question a 

#Set working directory accordingly as needed
#Load data, don't override original data frame 
virus_data <- read.csv("question-5-data/Cui_etal2014.csv")

#Inspect the data to evulate rows and columns
head(virus_data)


#Question b

#Add natural log-transformed columns
virus_data$log.Genome.length <- log(virus_data$Genome.length..kb.)
virus_data$log.Virion.volume <- log(virus_data$Virion.volume..nm.nm.nm.)

#Inspect the transformed data
head(virus_data)




#Question c 

#Fit the linear model
model <- lm(log.Virion.volume ~ log.Genome.length, data = virus_data)

#Get p-values
summary(model)$coefficients

#Extract β and α
beta <- coef(model)["log.Genome.length"]
alpha <- exp(coef(model)["(Intercept)"])



#Question d

#Load necessary packages

#library(ggplot2)

#Create the plot
virus_plot <- ggplot(virus_data, aes(x = log.Genome.length, y = log.Virion.volume)) +
  geom_point(size = 2.5) +    #Plot individual data points, set size 
  geom_smooth(method = "lm", se = TRUE, color = "blue") +   #Plot linear function
  labs(
    x = "log [Genome length (kb)]",   #Name axes to match plot in repo
    y = "log [Virion volume (nm3)]") +
  theme_minimal() +
  theme(
    panel.border = element_rect(fill = NA, linewidth = 1),   #Faint border around plot
    axis.title.x = element_text(face = "bold", size = 14),   #Make axis titles bold and larger
    axis.title.y = element_text(face = "bold", size = 14),                   
    axis.text.x = element_text(size = 12),                   #Increase size of axis tick labels
    axis.text.y = element_text(size = 12))



#Question e

#Calculate estimated volume for 300 kb genome
L <- 300
volume_estimate <- alpha*(L^beta)
volume_estimate
