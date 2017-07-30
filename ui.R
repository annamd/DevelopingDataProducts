#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Simulation from exponential distribution"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        h4("This application enables investigating CLT for random variables from exponential distribution.
           Please specify the parametres of simulation below."),
       numericInput("lambda", "Choose lambda:", value=5, min=1),
       sliderInput("samp.size",
                   "Choose sample size:",
                   min = 1,
                   max = 100,
                   value = 50),
       sliderInput("n.sim",
                   "Choose number of simulations:",
                   min = 1,
                   max = 2000,
                   value = 1000),
       checkboxInput("norm", "Plot normal density?", TRUE),
       submitButton()
    ),
    
    # Show theoretical and sample means and variances, plot means distribution.
    mainPanel(
       h3("Theoretical mean:"),
       verbatimTextOutput("mean.theoretical"),
       h3("Average value of sample means:"),
       verbatimTextOutput("mean.emp"),
       h3("Theoretical variance:"),
       verbatimTextOutput("var.theoretical"),
       h3("Variance of sample  means:"),
       verbatimTextOutput("var.emp"),
       h3("Histogram of sample means"),
       plotOutput("plot1"),
       h3("Kolmogorov-Smirnov test"),
       verbatimTextOutput("ks.res2"),
       verbatimTextOutput("ks.res4")
       )
    )
  )
)
