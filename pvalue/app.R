# app.R
# Shiny app that demonstrates p-values using a coin-toss example.
# UI allows the user to set number of tosses, either simulate an observed result
# or enter it manually, choose the alternative hypothesis, and run simulations
# under the null hypothesis (fair coin, p = 0.5). The app shows the null
# distribution, the observed statistic, the simulated p-value and the exact
# binomial test p-value, with plain-English interpretation.

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Understanding p-values with a coin toss"),
  sidebarLayout(
    sidebarPanel(
      helpText("We test the null hypothesis that the coin is fair (p = 0.5).") ,
      numericInput("n", "Number of tosses (n):", value = 100, min = 1, max = 10000, step = 1),
      hr(),
      h4("Observed data"),
      actionButton("toss", "Simulate observed tosses"),
      br(), br(),
      numericInput("obs", "Or enter observed number of heads:", value = 50, min = 0, step = 1),
      helpText("If you click 'Simulate observed tosses' the observed value will be replaced."),
      hr(),
      radioButtons("alternative", "Alternative hypothesis:",
                   choices = c("Two-sided (coin biased)" = "two.sided",
                               "More heads than expected (p > 0.5)" = "greater",
                               "Fewer heads than expected (p < 0.5)" = "less"),
                   selected = "two.sided"),
      sliderInput("sims", "Number of simulations under the null:", min = 100, max = 50000, value = 5000, step = 100),
      actionButton("run", "Run simulations"),
      width = 3
    ),
    mainPanel(
      h3("Visualisation"),
      plotOutput("distPlot", height = "350px"),
      hr(),
      h4("Results"),
      fluidRow(
        column(4, verbatimTextOutput("obsText")),
        column(4, verbatimTextOutput("pSimText")),
        column(4, verbatimTextOutput("pExactText"))
      ),
      hr(),
      h4("What this means (plain English):"),
      htmlOutput("interpretation"),
      hr(),
      helpText("Tip: change n, press 'Simulate observed tosses' to generate an observed result, then 'Run simulations' to see the null distribution and p-value.")
    )
  )
)

server <- function(input, output, session) {
  # Keep a reactive value for the observed number of heads
  rv <- reactiveValues(obs = NULL)
  
  # When n changes, if the current observed is out of range, update it
  observeEvent(input$n, {
    if (is.null(rv$obs) || rv$obs > input$n) {
      rv$obs <- floor(input$n / 2)
      updateNumericInput(session, "obs", value = rv$obs)
    }
    # also keep the manual obs input in sync
    if (input$obs > input$n) {
      updateNumericInput(session, "obs", value = input$n)
    }
  }, ignoreInit = TRUE)
  
  # Use manual entry when user types in the obs field
  observeEvent(input$obs, {
    # clamp to [0, n]
    newobs <- round(input$obs)
    if (newobs < 0) newobs <- 0
    if (newobs > input$n) newobs <- input$n
    rv$obs <- newobs
    if (newobs != input$obs) updateNumericInput(session, "obs", value = newobs)
  })
  
  # Simulate observed tosses when button clicked
  observeEvent(input$toss, {
    # Simulate a single observed experiment under unknown truth (user intention is to produce an example)
    simulated_obs <- rbinom(1, input$n, 0.5)
    rv$obs <- simulated_obs
    updateNumericInput(session, "obs", value = simulated_obs)
  })
  
  sims_result <- eventReactive(input$run, {
    n <- input$n
    sims <- input$sims
    alt <- input$alternative
    
    # Run simulations under the null hypothesis (p = 0.5)
    sim_counts <- rbinom(sims, n, 0.5)
    
    # observed must be set
    obs <- rv$obs
    if (is.null(obs)) obs <- floor(n/2)
    
    # Simulated p-value depending on alternative
    if (alt == "greater") {
      p_sim <- mean(sim_counts >= obs)
    } else if (alt == "less") {
      p_sim <- mean(sim_counts <= obs)
    } else {
      # two-sided: proportion of sims as or more extreme than observed in distance from expectation
      expected <- n * 0.5
      p_sim <- mean(abs(sim_counts - expected) >= abs(obs - expected))
    }
    
    # exact binomial p-value for comparison
    binom_res <- binom.test(obs, n, p = 0.5, alternative = ifelse(alt == "two.sided", "two.sided", alt))
    
    list(
      sim_counts = sim_counts,
      p_sim = p_sim,
      p_exact = binom_res$p.value,
      obs = obs,
      expected = n * 0.5
    )
  })
  
  output$distPlot <- renderPlot({
    res <- sims_result()
    req(res)
    
    df <- data.frame(counts = res$sim_counts)
    # plot counts as proportions on the x axis
    df$prop <- df$counts / input$n
    
    ggplot(df, aes(x = prop)) +
      geom_histogram(binwidth = 1 / input$n, boundary = 0, closed = "left") +
      geom_vline(xintercept = res$obs / input$n, linetype = "dashed", size = 1) +
      labs(x = "Proportion of heads (simulated under H0: p = 0.5)",
           y = "Frequency",
           title = sprintf("Null distribution from %d simulations (n = %d tosses)", input$sims, input$n)) +
      annotate("text", x = res$obs / input$n, y = Inf, label = sprintf("Observed = %d (%.2f)", res$obs, res$obs / input$n), vjust = 2, hjust = 1.05)
  })
  
  output$obsText <- renderText({
    res <- sims_result()
    req(res)
    sprintf("Observed heads: %d of %d (%.3f)", res$obs, input$n, res$obs / input$n)
  })
  
  output$pSimText <- renderText({
    res <- sims_result()
    req(res)
    sprintf("Simulated p-value: %.4g", res$p_sim)
  })
  
  output$pExactText <- renderText({
    res <- sims_result()
    req(res)
    sprintf("Exact binomial p-value: %.4g", res$p_exact)
  })
  
  output$interpretation <- renderUI({
    res <- sims_result()
    req(res)
    p_sim <- res$p_sim
    p_exact <- res$p_exact
    obs <- res$obs
    n <- input$n
    alt <- input$alternative
    
    # Build interpretation text
    alt_text <- switch(alt,
                       "greater" = "the alternative says there are more heads than expected (p > 0.5)",
                       "less" = "the alternative says there are fewer heads than expected (p < 0.5)",
                       "two.sided" = "the alternative says the coin is biased (p != 0.5)")
    
    glue::glue(
      "<p><strong>Null hypothesis (H0):</strong> the coin is fair (probability of heads = 0.5).</p>",
      "<p><strong>Alternative:</strong> {alt_text}.</p>",
      "<p><strong>Observed:</strong> {obs} heads out of {n} tosses (proportion = {sprintf('%.3f', obs/n)}).</p>",
      "<p><strong>Simulated p-value:</strong> {sprintf('%.4g', p_sim)}. This is the fraction of experiments generated under the null where the simulated result was at least as extreme as the observed result, according to the chosen alternative hypothesis.</p>",
      "<p><strong>Exact binomial p-value:</strong> {sprintf('%.4g', p_exact)} (calculated analytically).</p>",
      "<p><em>Interpretation:</em> A small p-value (conventionally below 0.05) means the observed data are unlikely under the null hypothesis. It does NOT by itself prove the alternative is true — it simply gives evidence against the null. For example, if the simulated p-value is 0.01, then if the coin were fair we'd expect to see a result at least as extreme as what you observed in about 1% of experiments.</p>"
    )
  })
  
}

shinyApp(ui, server)
