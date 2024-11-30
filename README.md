# Reproducible research: version control and R

\# INSERT ANSWERS HERE #

Question 4.

a. 

Running the provided code simulates two random walks each comprising 500 steps. The left and right plots have very different paths, highlightting the variability when random variables are involved. The colour of the lines represent the progression of time as the walks proceed, with the lines becoming lighter as steps increase, allowing us to see the progression of the paths.

![image](https://github.com/user-attachments/assets/125ab123-d847-4964-8242-4b07018fd2dd)

b. 

A random seed is a set value used to start off a pseudo random number generator (PRNG), computers cannot truly generate random numbers, but they can use algorithms to mimic randomness, hence the term 'pseudo random'. If you don't set a seed value, the PRNG will start from an unpredictable state, leading to different pseudo random numbers being generated that result in different plots being produced. Hence why the random walk plots are different each time the code is run. One can fix the starting point of a PRNG by setting a seed to ensure that the same sequence of pseudo random numbers are generated each time the code is run, therefore allowing reproducibility as the output should always be the same. 

We can set a seed in R with the code: set.seed(x), with x representing the seed value. The PRNG will initialise at a specific state, producing the same pseudo random output each time. 

c.

In order to make the simulation reproducible, we can simply set a seed value at the start of the code to ensure that the PRNG is initialised in the same way each time the code is run, so that the same pseudo random values are produced.

set.seed(1) is established before the rest of the code. The set value itself is arbitrary, but must be kept the same so that the same pseudo random values are produced. 

Now each time the code is run, the same output is produced. But to ensure extra reproducibility, we can fix the size of the plot so that the ouput will truly be the same. We can do this with the ggsave function:

overall_plot <- grid.arrange(plot1, plot2, ncol = 2)

ggsave("reproducible_random_walk.png", plot = overall_plot, width = 10, height = 6, dpi = 600)

![reproducible_random_walk](https://github.com/user-attachments/assets/d4d08c01-f917-4ff5-931b-ac144a27a4bf)

#THE FULL CODE CAN BE FOUND IN THE 'question-4-code' FILE IN THE 'reproducible-research-homework' repo

d. 

Here we can see the addition of the seed as well as the ggsave function. The grid to arrange plot1 and plot2 together has been named 'overall_plot' so that it can be saved as an image. 

![image](https://github.com/user-attachments/assets/c6368592-9246-46a8-a69c-47a4d16d7496)

####################################################################################################

Question 5. 
#THE FULL CODE FOR QUESTION 5 CAN BE FOUND IN 'dsDNA_virus_analysis.R' IN THE 'question-5-data' FILE 
a. 

The data table has 13 columns and 33 rows. 

![image](https://github.com/user-attachments/assets/d16c8f04-bc5a-4682-b7d6-e96878d96c30)

b. 

The relationship between virion volume and genome size is an allometric equation, so we can use a natural log transformation to make it a linear relationship.

V = αL^β

ln(V) = ln(α) + βln(L)

c. 

Now that the data has been ln transformed, we can fit a linear model. 

![image](https://github.com/user-attachments/assets/161b09a7-53bc-44ee-9ad3-8f72f905b41f)

The estimate for log.Genome.length (1.515) is the exponent, describing the slope of the line.

We can calculate alpha by taking the exponential of the estimate for the intercept: e^7.0748 = 1181.8

So our estimated values for beta (exponent) is 1.515, and our estimated value for alpha (scaling factor) is 1182

The calculated values match the values presented in the paper for dsDNA viruses

![image](https://github.com/user-attachments/assets/de47b524-df91-4c53-8b53-2cd75d8f4d01)

d. 

The following code is to produce a recreation of the plot log(Virion volume) against log(Genome length) for question d. 

#library(ggplot2)

#Create the plot

```r
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
```
<img width="559" alt="plot_zoom_png" src="https://github.com/user-attachments/assets/7e3e8c4c-c2ad-4b21-8a94-23835a898a60">


e. 

We can use these values to make estimates for virion volume (V) for different virus genome lengths (L). We can simply put our values into the equation V = αL^β

When genome length = 300kb

V = 1182*300^1.515 = 6690463nm^3

## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points. First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers (also make sure that your username has been anonymised). All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   a) A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points) \
   b) Investigate the term **random seeds**. What is a random seed and how does it work? (5 points) \
   c) Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points) \
   d) Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points) 

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \alpha L^{\beta}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   a) Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)\
   b) What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points) \
   c) Find the exponent ($\beta$) and scaling factor ($\alpha$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points) \
   d) Write the code to reproduce the figure shown below. (10 points) 

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  e) What is the estimated volume of a 300 kb dsDNA virus? (4 points) 
