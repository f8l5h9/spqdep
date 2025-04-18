% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/similarity.test.R
\name{similarity.test}
\alias{similarity.test}
\title{Compute the similarity test.}
\usage{
similarity.test(formula = NULL, data = NULL, fx = NULL, listw = listw,
alternative = "two.sided", distr = "asymptotic", nsim = NULL, control = list())
}
\arguments{
\item{formula}{a symbolic description of the factor (optional).}

\item{data}{an (optional) data frame or a sf object containing the variable to testing for.}

\item{fx}{a factor (optional).}

\item{listw}{a listw object}

\item{alternative}{a character string specifying the type of cluster, must be one
of "High" (default), "Both" or "Low".}

\item{distr}{A string. Distribution of the test "asymptotic" (default) or "bootstrap"}

\item{nsim}{Number of permutations.}

\item{control}{List of additional control arguments.}
}
\value{
A object of the \emph{htest}
\tabular{ll}{
\code{data.name} \tab a character string giving the names of the data.\cr
\code{statistic} \tab Value of the similarity test \cr
\code{N} \tab total number of observations.\cr
\code{Zmlc} \tab Elements in the Most Likelihood Cluster.\cr
\code{alternative} \tab a character string describing the alternative hypothesis. \cr
\code{p.value} \tab p-value of the similarity test \cr
\code{similiarity.mc} \tab values of the similarity test in each permutation. \cr
}
}
\description{
This function compute the nonparametric test for spatial independence
using symbolic analysis for categorical/qualitative spatial process.
}
\details{
This testing approach for spatial independence that extends some of the properties
of the join count statistic. The premise of the tests is similar to the join count
statistic in that they use the concept of similarity between neighbouring spatial
entities (Dacey 1968; Cliff and Ord 1973, 1981). However, it differs by taking
into consideration the number of joins belonging locally to each spatial unit,
rather than the total number of joins in the entire spatial system. The approach
proposed here is applicable to spatial and network contiguity structures, and
the number of neighbors belonging to observations need not be constant.\cr

We define an equivalence relation \eqn{\sim} in the set of locations S. An equivalence
relation satisfies the following properties:\cr \cr
Reflexive: \eqn{s_i \sim s_i} for all \eqn{s_i \in S},\cr
Symmetric: If \eqn{s_i \sim s_j}, then \eqn{s_j \sim s_i} for all \eqn{s_i,\ s_j \in S} and\cr
Transitive: If \eqn{s_i \sim s_j} and \eqn{s_j \sim s_k}, then \eqn{s_i \sim s_k}
for all \eqn{s_i, \  s_j, \ s_k \in S}\cr \cr
We call the relation \eqn{\sim} a similarity relation. Then, the null hypothesis that
we are interested in is
\deqn{H_0: \{X_s\}_{s \in S} \ \ is\ \ iid}
Assume that, under the null hypothesis, \eqn{P(s_i \sim s_{ji}) = p_i} for all
\eqn{s_{ji} \in N_{s_i}}. \cr
Define\cr
\deqn{I_{ij}=1 \ \ if \ \ s_i \sim s_{ji} \ \ ; 0 \ \ otherwise}\cr
Then, for a fixed degree d and for all location si with degree d, the variable d\cr
\deqn{\Lambda_{(d,i)}=\sum_{j=1}^d I_{ij}}
gives the number of nearest neighbours to si that are similar to si.
Therefore, under the null hypothesis, \eqn{H_0}, \eqn{\Lambda(d,i)} follows a binomial
distribution \eqn{B(d, p_i)}.
}
\section{Control arguments}{

\tabular{ll}{
\code{seedinit} \tab Numerical value for the seed (only for boot version). Default value seedinit=123 \cr
}
}

\examples{

# Case 1:
N <- 100
cx <- runif(N)
cy <- runif(N)
listw <- spdep::knearneigh(cbind(cx,cy), k = 3)
p <- c(1/4,1/4,1/4,1/4)
rho <- 0.5
fx <- dgp.spq(p = p, listw = listw, rho = rho)
W <- (spdep::nb2mat(spdep::knn2nb(listw)) >0)*1
similarity <- similarity.test(fx = fx, data = FastFood.sf, listw = listw)
print(similarity)

# Case 2: test with formula, a sf object (points) and knn
data("FastFood.sf")
coor <- sf::st_coordinates(sf::st_centroid(FastFood.sf))
listw <- spdep::knearneigh(coor, k = 4)
formula <- ~ Type
similarity <- similarity.test(formula = formula, data = FastFood.sf, listw = listw)
print(similarity)

# Case 3:
data(provinces_spain)
listw <- spdep::poly2nb(as(provinces_spain,"Spatial"), queen = FALSE)
provinces_spain$Mal2Fml <- factor(provinces_spain$Mal2Fml > 100)
levels(provinces_spain$Mal2Fml) = c("men","woman")
formula <- ~ Mal2Fml
similarity <- similarity.test(formula = formula, data = provinces_spain, listw = listw)
print(similarity)
}
\references{
\itemize{
\item Farber, S., Marin, M. R., & Paez, A. (2015).
Testing for spatial independence using similarity relations.
\emph{Geographical Analysis}. 47(2), 97-120.
}
}
\seealso{
\code{\link{sp.runs.test}}, \code{\link{dgp.spq}}, \code{\link{Q.test}}, , \code{\link{scan.test}}
}
\author{
\tabular{ll}{
Fernando López  \tab \email{fernando.lopez@upct.es} \cr
Román Mínguez  \tab \email{roman.minguez@uclm.es} \cr
Antonio Páez \tab \email{paezha@gmail.com} \cr
Manuel Ruiz \tab \email{manuel.ruiz@upct.es} \cr
}
}
