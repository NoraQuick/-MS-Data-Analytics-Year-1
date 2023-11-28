library(Sleuth3)

penalty <- case1902
penalty_freq <- gather(data = penalty, key = Sentence, value = Freq, c("Death", "NoDeath"), factor_key = TRUE)

penalty_case <- expand.dft(penalty_freq)
head(penalty_case)


penalty_indicators<- transmute(penalty_case, 
                               Aggravation = Aggravation,
                               White = ifelse(Victim == "White", 1, 0), 
                               Death = ifelse(Sentence == "Death", 1, 0))

dat <- glm(Sentence ~ Aggravation + Victim, data = penalty_case, family=binomial(link="logit"))
summary(dat)

penalty_indicators<- transmute(penalty_case, 
                               Sentence = Sentence,
                               Death = ifelse(Victim == "Death", 1, 0), 
                               dnd = ifelse(Sentence == "dnd", 1, 0))
dat <- glm(Sentence ~ Aggravation + Victim, data = penalty_case, family=binomial)
dat

exp(6.67 - 1.5397 * 2 -1.8106)
exp(6.67 - 1.2397 * 2)

5.929856/66.06242

coef(summary(fit))[,4]
