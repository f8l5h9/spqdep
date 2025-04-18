% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jc.test.R
\name{jc.test}
\alias{jc.test}
\title{A function to compute joint-count test for
binomial and multinomial (asymptotic and
permutation distributions).}
\usage{
jc.test(formula = NULL,
               data = NULL,
               fx = NULL,
               listw = NULL,
               na.action,
               zero.policy = NULL,
               distr = "asymptotic",
               alternative = "greater",
               control =list())
}
\arguments{
\item{formula}{a symbolic description of the factor(s).}

\item{data}{an (optional) data frame or a sf object
with points/multipolygons geometry containing the
variable(s) to be tested.}

\item{fx}{a factor  or a matrix of factors in columns}

\item{listw}{A \code{listw} object created for example by
\code{\link[spdep]{nb2listw}} from \pkg{spdep} package;
if \code{\link[spdep]{nb2listw}} not given,
the spatial weights are built using the object given
in \code{listw} argument (usually an \code{sf}
object). Default = \code{NULL}.}

\item{na.action}{A function (default \code{options("na.action")}),
can also be \code{na.omit} or \code{na.exclude}.
It may be necessary to set \code{zero.policy}
to \code{TRUE} because this subsetting may
create no-neighbour observations.}

\item{zero.policy}{Similar to the corresponding parameter of
\code{\link[spatialreg]{lagsarlm}} function in
\pkg{spatialreg} package.
If \code{TRUE} assign zero to the lagged value of zones without
neighbours. Default = \code{NULL}.}

\item{distr}{character. Distribution type "asymptotic" (default) or "mc".}

\item{alternative}{character string specifying the alternative hypothesis,
must be one of "greater" (default), or "less".}

\item{control}{list of additional arguments.}
}
\value{
An \code{spjctest} object. This type of object
is a list of \code{htest} objects.
The length of the list is the number of
factor variables included in the
\code{formula} or the number of columns
in \code{fx}.
Each element of the list can be a
\code{jclist} object, for binomial factors,
or a \code{jcmulti} object for multinomial
factors. See \code{\link[spdep]{joincount.test}}
or \code{\link[spdep]{joincount.multi}}
for additional details.
}
\description{
A function to compute joincount
tests for spatial qualitative data. This function
is a wrapper of \code{\link[spdep]{joincount.multi}}
and \code{\link[spdep]{joincount.test}}
in \pkg{spdep} package.
}
\section{Control arguments}{

\tabular{ll}{
\code{nsim} \tab number of permutations used in
the Monte Carlo distribution.
Default \code{nsim} = 999. \cr
\code{seedinit} \tab seed to select the initial
element during the simulations.
Default \code{seedinit} = 1111. \cr
\code{adjust.n} \tab default \emph{TRUE},
if \emph{FALSE} the number of observations
is not adjusted for no-neighbour
observations, if \emph{TRUE}, the number of
observations is adjusted consistently.
See \code{\link[spdep]{joincount.multi}}
for aditional information. \cr
\code{spChk} \tab	should the data vector
names be checked against the spatial
objects for identity integrity,
\emph{TRUE}, or \emph{FALSE}, default \emph{NULL} to
use \emph{get.spChkOption()}.
See \code{\link[spdep]{joincount.multi}}
for aditional information. \cr
\code{sampling} \tab default \emph{nonfree},
may be \emph{free}.
See \code{\link[spdep]{joincount.test}} for
additional information. \cr
\code{queen} \tab default \emph{TRUE}. Defines
the neighborhood criteria for \emph{sf}
objects. \cr
\code{style} \tab defines the style for
\code{listw}. Default = \emph{B} (binary). \cr
\code{knn} \tab chooses the number of
neighboors when this criteria is used.
Default \code{knn} = 5.
}
}

\examples{

## Case 1
## Multinomial + Binomial using a sf multipolygon
\donttest{
data("provinces_spain")
# sf::sf_use_s2(FALSE)
provinces_spain$Mal2Fml <- factor(provinces_spain$Mal2Fml > 100)
levels(provinces_spain$Mal2Fml) = c("men","woman")
provinces_spain$Older <- cut(provinces_spain$Older, breaks = c(-Inf,19,22.5,Inf))
levels(provinces_spain$Older) = c("low","middle","high")
f1 <- ~ Older + Mal2Fml
jc1 <- jc.test(formula = f1,
               data = provinces_spain,
               distr = "mc",
               alternative = "greater",
               zero.policy = TRUE)
summary(jc1)

provinces_spain$Coast <- factor(provinces_spain$Coast)
levels(provinces_spain$Coast) = c("no","yes")
f2 <- ~ Mal2Fml + Coast
jc2 <- jc.test(formula = f2,
               data = provinces_spain,
               distr = "mc",
               zero.policy = TRUE)
summary(jc2)
}

# Case 2:
## Multinomial using a sf multipoint
data("FastFood.sf")
# sf::sf_use_s2(FALSE)
f1 <- ~ Type
jc3 <- jc.test(formula = f1,
               data = FastFood.sf,
               distr = "asymptotic",
               control = list(knn = 6))
 summary(jc3)

# Examples function joincount.test
data(oldcol, package = "spdep")
HICRIME <- cut(COL.OLD$CRIME, breaks = c(0,35,80), labels = c("low","high"))
names(HICRIME) <- rownames(COL.OLD)
jc4 <- jc.test(fx = HICRIME,
               listw = spdep::nb2listw(COL.nb,
               style="B"))
summary(jc4)
 jc5 <- jc.test(fx = HICRIME,
                listw = spdep::nb2listw(COL.nb, style="B"),
                distr = "mc")
 summary(jc5)
 HICRIME <- cut(COL.OLD$CRIME, breaks = c(0, 35, 80),
                labels = c("low","high"))
 names(HICRIME) <- rownames(COL.OLD)
 jc6 <- jc.test(fx = HICRIME,
                listw = spdep::nb2listw(COL.nb,
                                 style = "B"))
summary(jc6)

}
\references{
\itemize{
\item Cliff, A. D., Ord, J. K. 1981 \emph{Spatial processes}, Pion, pp. 19-20.
\item Upton, G., Fingleton, B. 1985 \emph{Spatial data analysis by example: point pattern and qualitative data}, Wiley, pp. 158–170.
}
}
\seealso{
\code{\link{print.summary.spqtest}},
\code{\link[spdep]{joincount.test}},
\code{\link[spdep]{joincount.multi}}
}
\author{
\tabular{ll}{
Fernando López  \tab \email{fernando.lopez@upct.es} \cr
Román Mínguez  \tab \email{roman.minguez@uclm.es} \cr
Antonio Páez \tab \email{paezha@gmail.com} \cr
Manuel Ruiz \tab \email{manuel.ruiz@upct.es} \cr
}
}
