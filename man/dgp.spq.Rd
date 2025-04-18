% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dgp.spq.R
\name{dgp.spq}
\alias{dgp.spq}
\title{Generation of qualitative process with spatial structure}
\usage{
dgp.spq(listw = listw, p = p,  rho = rho, control = list())
}
\arguments{
\item{listw}{A \code{listw} object of the class nb, knn, listw o matrix created
for example by
\code{\link[spdep]{nb2listw}} from \pkg{spatialreg} package; if
\code{\link[spdep]{nb2listw}} not given, set to
the same spatial weights as the \code{listw} argument. It can
also be a spatial weighting matrix of order \emph{(NxN)} instead of
a \code{listw} object. Default = \code{NULL}.}

\item{p}{a vector with the percentage of elements of each categories.
The lengths must be the number of categories.
The sum of the elements of vector must be 1.}

\item{rho}{the level of spatial dependence (values between -1 y 1)}

\item{control}{List of additional control arguments. See control argument section.}
}
\value{
a factor of length N (\code{listw} is a matrix of order \emph{(NxN)}) with
levels the first capital letters: "A", "B", ....

The description of the DGP is available in Páez et al. 2010 (pag 291) and in details section.
}
\description{
The purpose of the function \code{dgp.spq} is to generate a random dataset
with the dimensions and spatial structure decided by the user. This function may be
useful in pure simulation experiments or with the aim of showing specific properties
and characteristics of a spatial qualitative dataset.
}
\details{
In order to obtain categorical random variables with controlled degrees
of spatial dependence, we have designed a two- stage data generating process:\cr
\cr
Firstly, we simulate autocorrelated data using the following model:
\deqn{Y = (I - \rho W)^{-1} \epsilon}
where \eqn{\epsilon = N(0,1)} I is the \eqn{N \times N} identity matrix, \eqn{\rho} is a parameter
of spatial dependence, and \emph{W} is a connectivity matrix that
determines the set of spatial relationships among points.\cr
\cr
In the second step of the data generation process, the continuous spatially
autocorrelated variable Y is used to define a discrete spatial process
as follows. Let \eqn{b_{ij}} be defined by:\cr
\deqn{p(Y \leq b_{ij})= {i \over j} \ \ \ with \ \ \ i<j}
Let \eqn{A =\{a_1,a_2,...,a_k\}} and define the discrete spatial process as:
\deqn{X_s=a_1 \ \ \ if \ \ \ Y_s \leq b_{1k}}
\deqn{X_s=a_i \ \ \ if \ \ \ b_{i-1k} < Y_s \leq b_{ik}}
\deqn{X_s=a_k \ \ \ if \ \ \ Y_s > b_{k-1k}}
}
\section{Control arguments}{

\describe{
\item{seedinit}{seed to generate the data sets}
}
}

\examples{
#
N <- 100
cx <- runif(N)
cy <- runif(N)
coor <- cbind(cx,cy)
p <- c(1/6,3/6,2/6)
rho = 0.5
listw <- spdep::nb2listw(spdep::knn2nb(spdep::knearneigh(cbind(cx,cy), k = 4)))
xf <- dgp.spq(list = listw, p = p, rho = rho)

data(provinces_spain)
listw <- spdep::poly2nb(provinces_spain, queen = FALSE)
p <- c(1/6,3/6,2/6)
rho = 0.9
xf <- dgp.spq(p = p, listw = listw, rho = rho)
provinces_spain$xf <- xf
plot(provinces_spain["xf"])
}
\references{
\itemize{
\item Ruiz M, López FA, A Páez. (2010). \emph{Testing for spatial association of qualitative
data using symbolic dynamics}. Journal of Geographical Systems. 12 (3) 281-309
}
}
\seealso{
\code{\link{Q.test}}, \code{\link{Q.map.test}}, \code{\link{sp.runs.test}}, \code{\link{scan.test}}
}
\author{
\tabular{ll}{
Fernando López  \tab \email{fernando.lopez@upct.es} \cr
Román Mínguez  \tab \email{roman.minguez@uclm.es} \cr
Antonio Páez \tab \email{paezha@gmail.com} \cr
Manuel Ruiz \tab \email{manuel.ruiz@upct.es} \cr
}
}
