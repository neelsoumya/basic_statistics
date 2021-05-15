## Introduction

This is a repository for teaching the basics of statistics for data science and machine learning. It is intended for use in an introductory data science class. 

This material can also be used by working professionals who want to learn the basics of data science, statistics and machine learning.


* Type 1 and Type 2 errors and p value

    * https://youtu.be/Hdbbx7DIweQ
    
* Power and Type 2 error

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
    
    * VERY GOOD picture
    
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
         
         boostrapped confidence intervals using confint(x, method = 'boot')
         
         d <- data.frame(w=rnorm(100),
                                x=rnorm(100),
                                y=sample(LETTERS[1:2], 100, replace=TRUE),
                                z=sample(LETTERS[3:4], 100, replace=TRUE) )
         do GLM on this new data frame
         fm2  <- glm(y ~ w + x + z, data=d, family=binomial)
         confint(object = fm2, method = 'boot')
         
         
   * meaning of confidence intervals

      * SUMMARY: if you repeat the experiment 100 times, 95 times the true value of the mean will fall within this interval.
            This does not mean than with 95% probability, the mean will fall in this interval

   * another explanation of confidence intervals by ISLR people (Rob Tibshirani)
    
      * https://www.youtube.com/watch?v=7TgVO_K75EY&list=PLOg0ngHtcqbPTlZzRHA2ocQZqB1D_qZ5V&index=8
      
      * https://www.coursera.org/learn/epidemiology/lecture/hzpDZ/confidence-intervals
    
    
 
* Precision and recall

   * https://en.wikipedia.org/wiki/Precision_and_recall
   
   * https://developers.google.com/machine-learning/crash-course/classification/precision-and-recall
   
   * VERY GOOD picture of precision, recall, confusion matrix, false positive, true positive, sensitivity, specificity 
   
      * https://bitbucket.org/neelsoumya/meta_analysis_r_metafor/src/master/resources/Screen%20Shot%202020-07-16%20at%2011.12.44%20AM.png
      
      * https://github.com/neelsoumya/basic_statistics/blob/master/Screen%20Shot%202020-07-16%20at%2011.12.44%20AM.png
      
      * https://github.com/neelsoumya/basic_statistics/blob/master/800px-Sensitivity_and_specificity.svg.png



* Linear models and interaction effects (by ISLR authors Rob Tibshirani and Efron)

    * https://www.youtube.com/watch?v=IFzVxLv0TKQ&list=PL5-da3qGB5IBSSCPANhTgrw82ws7w_or9&index=5

    * Woes of interpreting regression coefficients
    
         * https://youtu.be/yzQHONabWhs?t=498







You can use the [editor on GitHub](https://github.com/neelsoumya/basic_statistics/edit/gh-pages/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/neelsoumya/basic_statistics/settings/pages). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.
