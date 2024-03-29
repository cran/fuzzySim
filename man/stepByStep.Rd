\name{stepByStep}
\alias{stepByStep}
\title{
Analyse and compare stepwise model predictions
}
\description{
This function builds a generalized linear model with forward stepwise inclusion of variables, using AIC as the selection criterion, and provides the values predicted at each step, as well as their correlation with the final model predictions.
}
\usage{
stepByStep(data, sp.col, var.cols, family = binomial(link = "logit"), 
Favourability = FALSE, trace = 0, direction = "forward", k = 2, 
cor.method = "pearson")
}
\arguments{
  \item{data}{
a data frame containing your target and predictor variables.
}
  \item{sp.col}{
name or index number of the column of 'data' that contains the response variable.
}
  \item{var.cols}{
names or index numbers of the columns of 'data' that contain the predictor variables.
}
  \item{family}{
argument to be passed to the \code{\link{glm}} function indicating the family (and error distribution) to use in modelling. The default is binomial distribution with logit link (for binary response variables).
}
  \item{Favourability}{
logical, whether to apply the \code{\link{Fav}}ourability function to remove the effect of prevalence from predicted probability (Real et al. 2006). Applicable only to binomial GLMs. Defaults to FALSE.
}
  \item{trace}{
argument to pass to the \code{\link{step}} function. If positive, information is printed during the stepwise procedure. Larger values may give more detailed information. The default is 0 (silent).
}
  \item{direction}{
argument to pass to the \code{\link{step}} function. Implementation contributed by Alba Estrada. Can be "forward" (the default, for back-compatibility with former versions of 'stepByStep'), "backward", or "both".
}
  \item{k}{
argument to pass to the \code{\link{step}} function indicating the multiple of the number of degrees of freedom used for the penalty. The default is 2, which yields the original AIC. You can use larger values for a more stringent selection-- e.g., for a critical p-value of 0.05, use k = qchisq(0.05, 1, lower.tail = F).
}
  \item{cor.method}{
character string to pass to \code{\link{cor}} indicating which coefficient to use for correlating predictions at each step with those of the final model. Can be "pearson" (the default), "kendall", or "spearman".
}
}
\details{
Stepwise variable selection often includes more variables than would a model selected after examining all possible combinations of the variables (e.g. with package \pkg{MuMIn} or \pkg{glmulti}). The 'stepByStep' function can be useful to assess if a stepwise model with just the first few variables could already provide predictions very close to the final ones (see e.g. Fig. 3 in Munoz et al., 2005). It can also be useful to see which variables determine the more general trends in the model predictions, and which variables just provide additional (local) nuances.
}
\value{
This function returns a list of the following components:
\item{predictions}{a data frame with the model's fitted values at each step of the variable selection.}
\item{correlations}{a numeric vector of the correlation between the predictions at each step and those of the final model.}
\item{variables}{a character vector of the variables in the final model, named with the step at which each was included.}
\item{model}{the resulting model object.}
}
\references{
Munoz, A.R., Real R., BARBOSA A.M. & Vargas J.M. (2005) Modelling the distribution of Bonelli's Eagle in Spain: Implications for conservation planning. Diversity and Distributions 11: 477-486

Real R., Barbosa A.M. & Vargas J.M. (2006) Obtaining environmental favourability functions from logistic regression. Environmental and Ecological Statistics 13: 237-245.
}
\author{
A. Marcia Barbosa
}
\seealso{
\code{\link{step}}, \code{\link{glm}}, \code{\link{modelTrim}}
}
\examples{
data(rotif.env)

stepByStep(data = rotif.env, sp.col = 18, var.cols = 5:17, 
cor.method = "spearman")
 
stepByStep(data = rotif.env, sp.col = 18, var.cols = 5:17, 
cor.method = "spearman", Favourability = TRUE)
 
stepByStep(data = rotif.env, sp.col = 9, var.cols = c(5:8, 10:17), 
family = poisson)
}
