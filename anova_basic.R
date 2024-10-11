##########################################################################################
# Anova
# https://en.wikipedia.org/wiki/Analysis_of_variance
#
# Analysis of variance (ANOVA) is a collection of statistical models and their associated estimation procedures
# (such as the "variation" among and between groups) used to analyze the differences among group means in a sample.
# ANOVA was developed by statistician and evolutionary biologist Ronald Fisher. In the ANOVA setting, the observed variance
#in a particular variable is partitioned into components attributable to different sources of variation. 
# In its simplest form, ANOVA provides a statistical test of whether the population means of several groups are equal, 
# and therefore generalizes the t-test to more than two groups. ANOVA is useful for comparing (testing) three or more group
# means for statistical significance. It is conceptually similar to multiple two-sample t-tests, but is more conservative, 
#resulting in fewer type I errors,[1] and is therefore suited to a wide range of practical problems.
#
# from http://homepages.inf.ed.ac.uk/bwebb/statistics/ANOVA_in_R.pdf
##########################################################################################

##########################################################
# Load libraries
##########################################################
library(lme4)
library(sqldf)

##########################################################
# Load data
##########################################################
attach(InsectSprays)
data("InsectSprays")

str(InsectSprays)
head(InsectSprays)

summary(InsectSprays)


##########################################################
# Plot it
##########################################################
boxplot(count ~ spray, data = InsectSprays)


##########################################################
# One-way ANOVA
##########################################################
oneway.test(formula = count ~ spray, data = InsectSprays)

##########################################################
# ANOVA
##########################################################
aov_out = aov(formula = count ~ spray, data = InsectSprays)
summary(aov_out)


# ANOVA and linear regression are the same thing – more on that tomorrow. For the
# moment, the main point to note is that you can look at the results from aov() in terms of the
# linear regression that was carried out, i.e. you can see the parameters that were estimated.
# Implicitly this can be understood as a set of (non-orthogonal) contrasts of the first group
# against each of the other groups. R uses these so-called ‘Treatment’ contrasts as the default,
# but you can request alternative contrasts (see later) 

summary.lm(aov_out)

# Interpret as treatment contrasts compred to control (see PDF)

#########################################################
# Plot residuals
#########################################################

plot(aov_out)

# 1. This shows if there is a pattern in the residuals, and ideally should show similar scatter for
# each condition. Here there is a worrying effect of larger residuals for larger fitted values. This
# is called ‘heteroscedascity’ meaning that not only is variance in the response not equal across
# groups, but that the variance has some specific relationship with the size of the response. In
# fact you could see this in the original boxplots. It contradicts assumptions made when doing
# an ANOVA.

# 2. Q-Q plots
# This looks for normality of the residuals; if they are not normal, the assumptions of ANOVA
# are potentially violated.

# 3. This is like the first plot but now to specifically test if the residuals increase with the fitted
# values, which they do


####################################################################################
# Contrasts
# taken from
# http://homepages.inf.ed.ac.uk/bwebb/statistics/Statistical_models.html
####################################################################################

# In general, the F-ratio its p-value for an ANOVA tell us that the groups differ,
# but not which groups differ. In some experimental designs we might have particular 
# expectations about which group differences will be meaningful.

# First, we need to specify contrasts attribute for our predictor variable (spray type). 
# We can use one of the default contrast matrices , e.g. contr.helmert() is an orthogonal
# contrast matrix where each category (except the last) is compared to the mean effect 
# of all subsequent categories a standard procedure for studies along the lines of control
# vs. drug A vs. drug B.

contrasts(InsectSprays$spray)
contr.helmert(InsectSprays$spray)

# if we want to define our own contrasts it is possible too.
# Let's say that first we want to compare first 3 conditions to the last 3 and 
# then run more contrasts within those two subgroups of conditions.
# First, we define the weights

con1=c(1,1,1,-1,-1,-1)
con2=c(2,-1,-1,0,0,0)
con3=c(0,1,-1,0,0,0)
con4=c(0,0,0,2,-1,-1)
con5=c(0,0,0,0,1,-1)

our.contrasts=cbind(con1,con2,con3,con4,con5)
our.contrasts

# Then we attach contrasts attribute
contrasts(InsectSprays$spray)=our.contrasts

# Finally, once we obtain our model with aov() function we use summary.lm() 
# instead of standard summary() to observe the results of the contrasts.
model_aov_newcontrasts = aov(count~spray, data=InsectSprays)
summary.lm(model_aov_newcontrasts)


#############################################################
# Post-hoc tests
#############################################################

# A common approach alternative approach to planned contrasts is simply to carry out a set of t-tests between various groups,
# potentially whatever looks interesting in the data (hence the name, post-hoc). It is necessary to control for the overall 
# type I error rate, α, given the number of comparisons, c. The simplest approach is using the simple Bonferonni correction 
# set the significance level at α/c, e.g. here, if comparing each group against the first group we would be doing 5 comparisons, 
# so would need each t-test to have a p<.01 to be significant to ensure overall α<0.05. More precise is to use Dunn-Sidak correction:
# There are various other methods for multiple comparisons, each of which makes slightly different assumptions in attempting to control 
# for both type I and type II error (power), including: 
#   Neuman-Keuls (liberal on Type I); 
#   Scheff(strict on Type I but bad for Type II);
#   Dunnett� (optimised for comparing all treatments to a single control); 
#   Games-Howell (doesn� sume equal variances); and
#   Tukey HSD (optimised for when all possible pairwise comparisons are being made)

TukeyHSD(aov_out)

