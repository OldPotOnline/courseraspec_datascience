lambdavals <- seq(0.005, 0.1, by = 0.01)
nosim <- 1000
t<-100
coverage <- sapply(lambdavals, function(lambda) {
    lhats <- rpois(nosim, lambda = lambda * t)/t 
    ll <- lhats - qnorm(0.975) * sqrt(lhats/t) 
    ul <- lhats + qnorm(0.975) * sqrt(lhats/t) 
    mean(ll < lambda & ul > lambda)
})

