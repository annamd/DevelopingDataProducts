library(shiny)
library(stats)

shinyServer(function(input, output) {
    # perform simulation
    set.seed(123)
    random.sample<-reactive({matrix(rexp(input$n.sim*input$samp.size,input$lambda),input$n.sim,input$samp.size)})
    means.sample<-reactive({apply(random.sample(),1,mean)})     
    means.sample.df<-reactive({data.frame(means=means.sample())})
    
    #theoretical and sample mean
    output$mean.emp<-reactive({mean(means.sample())})
    output$mean.theoretical<-reactive({1/input$lambda})
    mean.theo<-reactive({1/input$lambda})

    #theoretical and sample variance
    output$var.emp<-reactive({var(means.sample())})
    output$var.theoretical<-reactive({1/(input$lambda^2*input$samp.size)})
    var.theo<-reactive({1/(input$lambda^2*input$samp.size)})
    
    #plot distribution
    output$plot1<-renderPlot({
            if (input$norm==FALSE){
        ggplot(means.sample.df(), aes(x=means))+
                            geom_histogram(binwidth=0.005,aes(y =..density..))} else {
        ggplot(means.sample.df(), aes(x=means))+geom_histogram(binwidth=0.005,aes(y =..density..))+
        stat_function(fun=dnorm, args=list(mean.theo(), sqrt(var.theo())), color="BLUE", size=1.25)}})

    y<-reactive({rnorm(input$n.sim, mean=mean.theo(), sd=sqrt(var.theo()))})
    ks.res1<-reactive({ks.test(means.sample(),y())})
    output$ks.res2<-renderText({ks.res1()$p.value})
    ks.res3<-reactive({ifelse(ks.res1()$p.value>0.05,"P-value is grater than 0.05, which means that there is no evidence to reject the null hypothesis that sample means are normally distributed (with theoretical parametres).",
        "P-value is less that 0.05, which means that we should reject the null hypothesis that sample means are normally distributed (with theoretical parametres).")})
    output$ks.res4<-renderText(ks.res3())
    })
    
   
