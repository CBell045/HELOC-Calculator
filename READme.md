---
title: "RShiny Project"
output:
  html_document:  
    keep_md: true
    toc: true
    toc_float: true
    code_folding: hide
    fig_height: 6
    fig_width: 12
    fig_align: 'center'
author: "Chad Bell"
date: "2023-02-02"
---

# Overview

This project aims to create a website that will host a Mortgage vs. HELOC calculator. This will allow clients to compare the difference between HELOC's and Mortgages. 

To start the test server, click the "Run App" button from within RStudio. This will open up to the main calculator page of the app. 

I wrote this software as a solution for a useful HELOC calculator. Many mortgage calculators exist, but no HELOC calculators exist that suit my purposes. 

{Provide a link to your YouTube demonstration.  It should be a 4-5 minute demo of the software running (starting the server and navigating through the web pages) and a walkthrough of the code.}

[Software Demo Video](https://youtu.be/LT2EWPF5fe4)

# Web Pages

The three main pages I created were the "Calculator", "About", and "Prevail" pages. 

- The calculator page is where most of my work was. It allows you to input loan details and dynamically generates pay-off tables. 
- The about page gives information about HELOC's. 
- The Prevail page gives information about prevail and appointment scheduling. 

# Development Environment

I used RStudio and RShiny to develop this web application. 

I used the R programming language with the Shiny, shinyWidgets, and DT libraries. 

# Useful Websites

{Make a list of websites that you found helpful in this project}
* [R Shiny](https://shiny.rstudio.com)
* [Mastering Shiny](https://mastering-shiny.org/basic-app.html)

# Future Work

* Create a graphical comparison of Mortgage vs HELOC
* Improve the HELOC code to make it faster
* Shrink the table column widths. 
