# sg.data
The goal of sg.data is to publish experimental data that were collected as study related work at the Department for psychological methodology of Justus Liebig University in Gießen (Germany). This deals with strategic dyadic games as an assessment tool for measuring cognitive performance. The package is just a research project that utilizes the R package structure. It includes some helpers for simulations as R code and analysis snippets as vignettes.

## Installation
You can install this from [GitHub](https://github.com/) with:

``` r
# You need the devtools package
install.packages("devtools")
devtools::install_github("strategic-games/sg.data")
```

## Data loading

You can load the datasets via the data loading mechanism in R. The package also provides documentation for the datasets.

``` r
## load data
data(begriffix)

# See documentation
?begriffix
```

