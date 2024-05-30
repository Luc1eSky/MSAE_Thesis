 sysuse auto, clear
 
 eststo reg1: regress price mpg rep78
 
 eststo reg2: regress weight length
 
 esttab reg1 reg2 /* using "Table-both.rtf" */
 
 
 ** DATA CLEANING
clear
** import the excel file for the regression analysis (you might need to update the path)
import excel "/Users/lucieschulz/Desktop/Thesis/error_rate_data.xlsx", firstrow
encode uid, gen(uid_numeric)

** Model 1
xtset uid_numeric session
eststo model1: xtreg all_decisions session, fe vce(cluster uid)

** Model 2
xtset uid_numeric session
 eststo model2: xtreg first_10 session, fe vce(cluster uid)

** Model 3
xtset uid_numeric session
eststo model3: xtreg level_1 session, fe vce(cluster uid)



** combined table
esttab model1 model2 model3 /* using "Table-both.rtf" */, title("Error Rates over Sessions")
