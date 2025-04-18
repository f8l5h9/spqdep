% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/local.sp.runs.test.R
\name{local.sp.runs.test}
\alias{local.sp.runs.test}
\title{A function to calculate the local spatial runs tests.}
\usage{
local.sp.runs.test(formula = NULL, data = NULL, fx = NULL,
distr = "asymptotic", listw = listw, alternative = "two.sided" , nsim = NULL,
control = list())
}
\arguments{
\item{formula}{An (optional) formula with the factor included in \code{data}}

\item{data}{An (optional) data frame or a sf object containing the variable to testing for.}

\item{fx}{An (optional) factor of observations with the same length as the neighbors list in \code{listw}}

\item{distr}{a character string specifying the distribution "asymptotic" (default) or "bootstrap"}

\item{listw}{A neighbourhood list (an object type knn or nb) or a W matrix that indicates the order of the elements in each  $m_i-environment$
(for example of inverse distance). To calculate the number of runs in each $m_i-environment$, an order must
be established, for example from the nearest neighbour to the furthest one.}

\item{alternative}{a character string specifying the alternative hypothesis, must be one
of "two.sided" (default), "greater" or "less".}

\item{nsim}{Default value is NULL to obtain the asymptotic version of the local test.
For the bootstrap version nsim is the number of permutations to obtain the pseudo-value.}

\item{control}{Optional argument. See Control Argument section.}
}
\value{
The output is an object of the class localsrq \cr
\cr
\code{local.SRQ} A matrix with \cr
\tabular{ll}{
\code{runs.i} \tab number of runs in the localization 'i'. \cr
\code{E.i} \tab expectation of local runs statistic in the localization 'i'. \cr
\code{Sd.i} \tab standard deviate of local runs statistic in the localization 'i'. \cr
\code{z.value} \tab standard value of local runs statistic (only for asymptotic version). \cr
\code{p.value} \tab p-value of local local runs statistic (only for asymptotic version). \cr
\code{zseudo.value} \tab standard value of local runs statistic (only for boots version). \cr
\code{pseudo.value} \tab p-value of local runs statistic (only for boots version). \cr
}
\code{MeanNeig} Mean of run.i \cr
\code{MaxNeig} Maximum of run.i  \cr
\code{listw} the object \code{listw} \cr
\code{alternative} a character string describing the alternative hypothesis \cr
}
\description{
This function calculates the local spatial runs tests for all localizations.
}
\details{
The object \code{listw} can be the class:
\itemize{
\item \code{knn}: Objects of the class knn that consider the neighbours in
order of proximity.
\item \code{nb}: If the neighbours are obtained from an sf object, the code internally
will call the function \code{\link{nb2nb_order}} it will order them in order
of proximity of the centroids.
\item \code{matrix}: If a object of matrix class based in the inverse of
the distance in introduced as argument, the function \code{\link{nb2nb_order}} will
also be called internally to transform the object the class matrix to a matrix of the
class nb with ordered neighbours.
}
}
\section{Control arguments}{

\tabular{ll}{
\code{seedinit} \tab Numerical value for the seed in boot version. Default value seedinit = 123 \cr
}
}

\examples{

# Case 1: Local spatial runs test based on knn
N <- 100
cx <- runif(N)
cy <- runif(N)
x <- cbind(cx,cy)
listw <- spdep::knearneigh(cbind(cx,cy), k = 10)
p <- c(1/6,3/6,2/6)
rho <- 0.5
fx <- dgp.spq(p = p, listw = listw, rho = rho)

# Asymtotic version
lsrq <- local.sp.runs.test(fx = fx, listw = listw, alternative = "less")
print(lsrq)
plot(lsrq, sig = 0.05)
# Asymtotic version
lsrq <- local.sp.runs.test(fx = fx, listw = listw, alternative = "two.sided",
                           distr ="bootstrap", nsim = 399)
print(lsrq)
plot(lsrq, sig = 0.1)
\donttest{
# Case 2:Fastfood example. sf (points)
data("FastFood.sf")
# sf::sf_use_s2(FALSE)
x <- sf::st_coordinates(sf::st_centroid(FastFood.sf))
listw <- spdep::knearneigh(x, k = 10)
formula <- ~ Type
lsrq <- local.sp.runs.test(formula = formula, data = FastFood.sf, listw = listw)
print(lsrq)
plot(lsrq, sf = FastFood.sf, sig = 0.05)
}

# Case 3: With a sf object (poligons)
fname <- system.file("shape/nc.shp", package="sf")
nc <- sf::st_read(fname)
listw <- spdep::poly2nb(as(nc,"Spatial"), queen = FALSE)
p <- c(1/6,3/6,2/6)
rho = 0.5
nc$fx <- dgp.spq(p = p, listw = listw, rho = rho)
plot(nc["fx"])
formula <- ~ fx
lsrq <- local.sp.runs.test(formula = formula, data = nc, listw = listw)
print(lsrq)
plot(lsrq, sf = nc)
# Version boot
lsrq <- local.sp.runs.test(formula = formula, data = nc, listw = listw,
                           distr ="bootstrap", nsim = 399)
print(lsrq)
plot(lsrq, sf = nc)

# Case 4: With isolated areas
data(provinces_spain)
listw <- spdep::poly2nb(as(provinces_spain,"Spatial"), queen = FALSE)
provinces_spain$Mal2Fml<- factor(provinces_spain$Mal2Fml > 100)
levels(provinces_spain$Mal2Fml) = c("men","woman")
plot(provinces_spain["Mal2Fml"])
formula <- ~ Mal2Fml
lsrq <- local.sp.runs.test(formula = formula, data = provinces_spain, listw = listw)
print(lsrq)
plot(lsrq, sf = provinces_spain, sig = 0.1)

# Boots Version
lsrq <- local.sp.runs.test(formula = formula, data = provinces_spain, listw = listw,
                           distr ="bootstrap", nsim = 199)
print(lsrq)
plot(lsrq, sf = provinces_spain, sig = 0.10)

# Case 5: SRQ test based on a distance matrix (inverse distance)
\donttest{
N <- 100
cx <- runif(N)
cy <- runif(N)
coor <- as.data.frame(cbind(cx,cy))
coor <- sf::st_as_sf(coor,coords = c("cx","cy"))
n = dim(coor)[1]
dis <- 1/matrix(as.numeric(sf::st_distance(coor,coor)), ncol = n, nrow = n)
diag(dis) <- 0
dis <- (dis < quantile(dis,.10))*dis
p <- c(1/6,3/6,2/6)
rho <- 0.5
fx <- dgp.spq(p = p, listw = dis, rho = rho)
lsrq <- local.sp.runs.test(fx = fx, listw = dis)
print(lsrq)
plot(lsrq, coor = cbind(cx,cy), sig = 0.05)
lsrq <- local.sp.runs.test(fx = fx, listw = dis, data = )
print(lsrq)
plot(lsrq, sf = coor)
# Version boots
lsrq <- local.sp.runs.test(fx = fx, listw = dis, data = coor,
                           distr ="bootstrap", nsim = 299)
print(lsrq)
plot(lsrq, sf = coor)

# SRQ test based on inverse distance
data("FastFood.sf")
# sf::sf_use_s2(FALSE)
n = dim(FastFood.sf)[1]
dis <- 1000000/matrix(as.numeric(
          sf::st_distance(FastFood.sf, FastFood.sf)),
          ncol = n, nrow = n)
diag(dis) <- 0
dis <- (dis < quantile(dis,.01))*dis
formula <- ~ Type
lsrq <- local.sp.runs.test(formula = formula, data = FastFood.sf, listw = dis)
print(lsrq)
# plot(lsrq, sf = FastFood.sf)
}
}
\seealso{
\code{\link{sp.runs.test}}, \code{\link{dgp.spq}}
}
\author{
\tabular{ll}{
Fernando López  \tab \email{fernando.lopez@upct.es} \cr
Román Mínguez  \tab \email{roman.minguez@uclm.es} \cr
Antonio Páez \tab \email{paezha@gmail.com} \cr
Manuel Ruiz \tab \email{manuel.ruiz@upct.es} \cr
}
@references
\itemize{
\item Ruiz, M., López, F., and Páez, A. (2021).
A test for global and local homogeneity of categorical data based on spatial runs.
\emph{Working paper}.
}
}
