# basic_statistics

This is a repository for teaching the basics of statistics for data science and machine learning. It is intended for use in an introductory data science class. 

This material can also be used by working professionals or lay people who want to learn the basics of data science, statistics and machine learning.

* Type 1 errors, Type 2 errors and p value

    * https://youtu.be/Hdbbx7DIweQ
    
* Power and Type 2 error

    * https://www.youtube.com/watch?v=6_Cuz0QqRWc

    * https://www.khanacademy.org/math/ap-statistics/tests-significance-ap
    
* p value

    * https://www.youtube.com/watch?v=5Z9OIYA8He8
    
    * https://www.youtube.com/watch?v=yzQHONabWhs&list=PLOg0ngHtcqbPTlZzRHA2ocQZqB1D_qZ5V&index=10
    
    
* q value and false discovery rate

    * https://www.youtube.com/watch?v=S268k-DWRrE
    
    * https://www.youtube.com/watch?v=K8LQSvtjcEo
    
    * CONCEPT: look at distribution of p-values. q-value tells us the expected fraction of false positives in the significant tests below this threshold.
    
    
* Power calculation    
    
    * https://youtu.be/6_Cuz0QqRWc
    
    * power.t.test(n = NULL, power = .95, sd = 5, alternative = "two.sided", sig.level = 0.001, delta = 0.1)
    
  

* Bias variance tradeoff

    * https://www.youtube.com/watch?v=VaN1RUDuioQ&list=PLOg0ngHtcqbPTlZzRHA2ocQZqB1D_qZ5V&index=5
    
    * http://scott.fortmann-roe.com/docs/BiasVariance.html
    
    * VERY GOOD picture explanation
    
        * https://github.com/neelsoumya/basic_statistics/blob/master/bias_variance.png
        
    * My lecture on the bias variance tradeoff
    
        * https://www.youtube.com/watch?v=4_la9-Ehvmo 
    
    
* Cross validation

   * https://github.com/neelsoumya/basic_statistics/blob/master/Capture_crossvalidation.PNG

   * https://github.com/neelsoumya/basic_statistics/blob/master/Capture_crossvalidation_split.PNG
   
   
    
    
* Confidence intervals

   * How many standard deviations from the mean must you go to capture 95% of the scores

   * Computing 95% confidence intervals Mean +/- 1.96 * std/sqrt(no of samples)

         
         ci_alpha <- 0.05
         qnorm(ci_alpha / 2)
         qnorm(1 - (ci_alpha/2))
         
         95% of the probability mass is found in about 2 standard deviations of the mean (see video below)
         
         https://www.youtube.com/watch?v=hlM7zdf7zwU
         
         boostrapped confidence intervals using confint(x, method = 'boot')
         
         d <- data.frame(w=rnorm(100),
                                x=rnorm(100),
                                y=sample(LETTERS[1:2], 100, replace=TRUE),
                                z=sample(LETTERS[3:4], 100, replace=TRUE) )
         do GLM on this new data frame
         fm2  <- glm(y ~ w + x + z, data=d, family=binomial)
         confint(object = fm2, method = 'boot')
        
         lb = quantile(list_auc, 0.025)
         ub = quantile(list_auc, 0.975)
         mean = mean(list_uac)
         
         also in Python and R empirical 95% confidence interval     
         lb = np.percentile(list_auc, 2.5)
         ub = np.percentile(list_auc, 97.5)
         
         
   * meaning of confidence intervals

      * SUMMARY: if you repeat the experiment 100 times, 95 times the true value of the mean will fall within this interval.
            This does not mean than with 95% probability, the mean will fall in this interval

   * another explanation of confidence intervals by ISLR people (Rob Tibshirani)
    
      * https://www.youtube.com/watch?v=7TgVO_K75EY&list=PLOg0ngHtcqbPTlZzRHA2ocQZqB1D_qZ5V&index=8
      
      * https://www.coursera.org/learn/epidemiology/lecture/hzpDZ/confidence-intervals
    
    
 
* Precision and recall

   * https://en.wikipedia.org/wiki/Precision_and_recall
   
   * https://developers.google.com/machine-learning/crash-course/classification/precision-and-recall
   
   * VERY GOOD pictures of precision, recall, confusion matrix, false positive, true positive, sensitivity and specificity 
   
      * https://github.com/neelsoumya/basic_statistics/blob/master/Screen%20Shot%202020-07-16%20at%2011.12.44%20AM.png
      
      * https://github.com/neelsoumya/basic_statistics/blob/master/800px-Sensitivity_and_specificity.svg.png

      * https://www.analyticsvidhya.com/blog/2020/04/confusion-matrix-machine-learning/

* Explanation of AUC (area under curve)

      *    https://github.com/neelsoumya/basic_statistics/blob/master/auc_explanation.png

* Linear models and interaction effects (by ISLR authors Rob Tibshirani and Efron)

    * https://www.youtube.com/watch?v=IFzVxLv0TKQ&list=PL5-da3qGB5IBSSCPANhTgrw82ws7w_or9&index=5

    * Woes of interpreting regression coefficients
    
         * https://youtu.be/yzQHONabWhs?t=498


* ANOVA
     * https://cambiotraining.github.io/stats-mixed-effects-models/materials/06-significance-and-model-comparison.html
 
     * Code
          * https://github.com/neelsoumya/basic_statistics/blob/master/anova_basic.R
            
          * https://github.com/neelsoumya/basic_statistics/blob/master/anova_politeness.R   

* Mixed effects models
     * https://github.com/neelsoumya/basic_statistics/blob/master/mixed_effects_basics.Rmd


