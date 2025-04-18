#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

#' Selection of fast food restaurants in Toronto
#'
#' A simple feature (sf) dataframe containing the locations of a selection of fast food restaurants
#' in the city of Toronto, Canada (data are from 2008). The data are projected using EPSG: 26917 (WGS 84/UTM Zone 17N).
#'
#' @docType data
#'
#' @usage data(FastFood.sf)
#'
#' @format A simple features object with 614 rows and 3 variables:
#'
#' \describe{
#'   \item{ID}{Unique identifier of record.}
#'   \item{Class}{Factor with 3 types of fast food restaurants: \[P\]izza, \[S\]andwich, and \[H\]amburger}
#'   \item{geometry}{Geometry of simple features.}
#' }
#'
#' @source Ruiz et al. (2010)
#' \url{https://link.springer.com/article/10.1007/s10109-009-0100-1}
#'
#' @references
#'   \itemize{
#'     \item Ruiz M, López FA, A Páez. (2010). \emph{Testing for spatial association of qualitative
#'     data using symbolic dynamics}. Journal of Geographical Systems. 12 (3) 281-309
#'   }
"FastFood.sf"

#' Provinces in Spain.
#'
#' A simple features object with the provinces in Spain and selected demographic and economic information.
#'
#' @format A simple features dataframe with 50 rows and 15 columns:
#' \describe{
#'   \item{province}{Names of provinces in Spain as factor}
#'   \item{CCAA}{Names of Autonomous Communities in Spain as factor}
#'   \item{ID_INE}{National Institute of Statistics unique identifier of the provinces}
#'   \item{Population}{Population in the province in 2020}
#'   \item{Density}{Population density in the province in persons/km^2}
#'   \item{Older}{Percentage of population 65 and older in the provice in 2020}
#'   \item{Median_Age}{Median age of population in the province in 2020}
#'   \item{Mal2Fml}{Ratio of male to female population in the province in 2020}
#'   \item{GDPpc}{GDP per capita in the province in 2016}
#'   \item{Transit}{Dummy variable for mass transit system in province; 1: YES}
#'   \item{Area}{Area of the province}
#'   \item{Altitude}{Altitude of the province}
#'   \item{Coast}{A dummy variable that indicates whether the province is in the coast; 1: YES}
#'   \item{Meteo_Station}{Identifier of meteorological station representative of the province used to retrieve climatic variables}
#'   \item{geometry}{geometry of the simple features object}
#' }
#'
#' @docType data
#' @keywords datasets
#' @name provinces_spain
#' @usage data(provinces_spain)
#' @source Instituto Nacional de Estadistica http://www.ine.es/
#' @source Climatic data: Agencia Estatal de Meteorologia http://www.aemet.es/
#' @source Páez et al. (2020)
#'
#' @references
#'   \itemize{
#'     \item Paez, A., Lopez, F.A., Menezes, T., Cavalcanti, R., & Pitta, M. (2020). A Spatio‐Temporal Analysis of
#'      the Environmental Correlates of COVID‐19 Incidence in Spain. \emph{Geographical Analysis}. 53(3) 397-421
#'   }
#' @examples
#'  data(provinces_spain)
#'  summary(provinces_spain)
"provinces_spain"

#' Boots.sf.
#'
#' A simple features object square regular lattice 16x16. from Fig. 3.3 in Upton
#' and Fingleton (1985). In this figure, the cells coded black/white correspond
#' to quadrats where the perennial shrub Atriplex hymenelytra is present/absent
#' in a sample area in Death Valley, California.
#'
#' @format A simple features dataframe with 256 rows and 1 column:
#' \describe{
#'   \item{BW}{A factor with two levels: Black and White}
#' }
#'
#' @docType data
#' @keywords datasets
#' @name Boots.sf
#' @usage data(Boots.sf)
#' @source Boots, B. (2003) Developing local measures of spatial association for categorical data, Journal of Geographical Systems, 5(2), 139-160. \doi{10.1007/s10109-003-0110-3}
#'
#' @references
#'   \itemize{
#'     \item Boots, B. (2003). Developing local measures of spatial association
#'     for categorical data. Journal of Geographical Systems, 5(2), 139-160. \doi{10.1007/s10109-003-0110-3}
#'     \item Upton G., Fingleton B. (1985) Spatial data analysis by example.
#'     Volume 1: Point pattern and quantitative data.
#'     John Wiley & Sons, Chichester
#'   }
#' @examples
#'  data(Boots.sf)
#'  summary(Boots.sf)
"Boots.sf"
