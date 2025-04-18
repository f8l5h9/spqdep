% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spqdep-package.R
\docType{data}
\name{provinces_spain}
\alias{provinces_spain}
\title{Provinces in Spain.}
\format{
A simple features dataframe with 50 rows and 15 columns:
\describe{
\item{province}{Names of provinces in Spain as factor}
\item{CCAA}{Names of Autonomous Communities in Spain as factor}
\item{ID_INE}{National Institute of Statistics unique identifier of the provinces}
\item{Population}{Population in the province in 2020}
\item{Density}{Population density in the province in persons/km^2}
\item{Older}{Percentage of population 65 and older in the provice in 2020}
\item{Median_Age}{Median age of population in the province in 2020}
\item{Mal2Fml}{Ratio of male to female population in the province in 2020}
\item{GDPpc}{GDP per capita in the province in 2016}
\item{Transit}{Dummy variable for mass transit system in province; 1: YES}
\item{Area}{Area of the province}
\item{Altitude}{Altitude of the province}
\item{Coast}{A dummy variable that indicates whether the province is in the coast; 1: YES}
\item{Meteo_Station}{Identifier of meteorological station representative of the province used to retrieve climatic variables}
\item{geometry}{geometry of the simple features object}
}
}
\source{
Instituto Nacional de Estadistica http://www.ine.es/

Climatic data: Agencia Estatal de Meteorologia http://www.aemet.es/

Páez et al. (2020)
}
\usage{
data(provinces_spain)
}
\description{
A simple features object with the provinces in Spain and selected demographic and economic information.
}
\examples{
 data(provinces_spain)
 summary(provinces_spain)
}
\references{
\itemize{
\item Paez, A., Lopez, F.A., Menezes, T., Cavalcanti, R., & Pitta, M. (2020). A Spatio‐Temporal Analysis of
the Environmental Correlates of COVID‐19 Incidence in Spain. \emph{Geographical Analysis}. 53(3) 397-421
}
}
\keyword{datasets}
