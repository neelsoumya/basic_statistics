# basic_statistics

Repository for teaching basics of statistics. 
This is intended for use in an introductory data science class and for working professionals who want to learn the basics of data science.


* Type 1 and Type 2 errors and p value

    * https://youtu.be/Hdbbx7DIweQ
    
* Power and Type 2 error

    * https://www.khanacademy.org/math/ap-statistics/tests-significance-ap
    
* p value

    * https://www.youtube.com/watch?v=yzQHONabWhs&list=PLOg0ngHtcqbPTlZzRHA2ocQZqB1D_qZ5V&index=10
    
* q value and false discovery rate

    * https://www.youtube.com/watch?v=S268k-DWRrE
    
    * https://www.youtube.com/watch?v=K8LQSvtjcEo
    
    
* Power calculation    

    * https://www.khanacademy.org/math/ap-statistics/tests-significance-ap
    
    * power.t.test(n = NULL, power = .95, sd = 5, alternative = "two.sided", sig.level = 0.001, delta = 0.1)
    
  

* Bias variance tradeoff

    * https://www.youtube.com/watch?v=VaN1RUDuioQ&list=PLOg0ngHtcqbPTlZzRHA2ocQZqB1D_qZ5V&index=5
    
    * http://scott.fortmann-roe.com/docs/BiasVariance.html
    
    
    
* Confidence intervals

   * How many standard deviations from the mean must you go to capture 95% of the scores

   * Computing 95% confidence intervals Mean +/- 1.96 * std/sqrt(no of samples)

         ci_alpha <- 0.05
         qnorm(ci_alpha / 2)
         qnorm(1 - (ci_alpha/2))
         
   * meaning of confidence intervals

      * SUMMARY: if you repeat the experiment 100 times, 95 times the true value of the mean will fall within this interval.
            This does not mean than with 95% probability, the mean will fall in this interval

   * another explanation of confidence intervals by ISLR people (Rob Tibshirani)
    
      * https://www.youtube.com/watch?v=7TgVO_K75EY&list=PLOg0ngHtcqbPTlZzRHA2ocQZqB1D_qZ5V&index=8
      
      * https://www.coursera.org/learn/epidemiology/lecture/hzpDZ/confidence-intervals
    
    
 
* Precision and recall

   * https://en.wikipedia.org/wiki/Precision_and_recall
   
   * https://developers.google.com/machine-learning/crash-course/classification/precision-and-recall
   
   * VERY GOOD picture of precision, recall, confusion matrix, false positive, true positive, etc
   
      * https://bitbucket.org/neelsoumya/meta_analysis_r_metafor/src/master/resources/Screen%20Shot%202020-07-16%20at%2011.12.44%20AM.png


* Linear models and interaction effects (by ISLR authors Rob Tibshirani and Efron)

    * https://www.youtube.com/watch?v=IFzVxLv0TKQ&list=PL5-da3qGB5IBSSCPANhTgrw82ws7w_or9&index=5


* End of basic topics

   * END

* More advanced topics

    
   * Meta-analysis

       * metafor package in R
    
       * https://www.youtube.com/watch?v=E7-EI13FGKc&list=PLfxmV3OxkxCvyh9a9eVU33nbjM9YV8AkV&index=10
    
       * very good tutorial
    
          * https://www.youtube.com/watch?v=O6qDlov5-Is
        
    
   * GWAS

       * https://www.ebi.ac.uk/training/online/course/gwas-catalog-exploring-snp-trait-associations-2019/what-gwas-catalog/what-are-genome-wide
       
       * https://www.coursera.org/lecture/disease-genes/introduction-to-genome-wide-association-studies-historical-overview-iFQ1J
  
    
    
* Main resource page

    * https://sites.google.com/site/neelsoumya/research-resources/basic-statistics
