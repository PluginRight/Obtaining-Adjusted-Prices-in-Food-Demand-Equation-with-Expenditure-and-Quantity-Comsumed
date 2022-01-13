**Calculating the Adjusting Prices by obtaining the Constant and Redisual Error**
use "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\hhd_char.dta", clear
keep if s02q05a < 18 | s02q05a>64

keep HHID s02q05a

save "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\infants_and_elderly.dta", replace
gen infants = 0
replace infants = 1 if s02q05a < 2
gen children = 0
replace children = 1 if s02q05a < 18
gen elderly = 0
replace elderly = 1 if s02q05a >64

collapse (sum) infants children elderly, by ( HHID)
save "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\infants_and_elderly.dta", replace

** Merge the datasets**
use "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\food_expenditure_wide.dta", clear
merge 1:1 HHID using "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\infants_and_elderly.dta"
drop _merge
recode elderly children infants share_FAFH food_expenditure_per_capita total_food_expenditure (.=0)

merge 1:1 HHID using "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\hhd_head.dta"
drop _merge
save "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\food_expenditure_hhd.dta", replace

merge 1:1 HHID using "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\KHM_2019_LSMS-PLUS_v01_M_STATA13\secondary_school.dta"
drop _merge
save "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\food_expenditure_hhd.dta", replace

merge 1:1 HHID using "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\location dummies.dta"
drop _merge
save "C:\Users\sdanilola\Documents\MyProject\Food Demand in Cambodia\Cambodia Data\food_expenditure_hhd.dta", replace

gen infant_prop = infants/ household_size
gen children_prop = children/ household_size
gen elderly_prop = elderly/ household_size

**Regress the Food Group aggainst the dependent variables and obtain the residuals**
regress food_group_unit2 share_FAFH food_expenditure_per_capital household_size age_hh_head married_hh gender_hh years_of_sch_head infant_prop children_prop elderly_prop urban quarter_1 province1-province24
predict resid_food_group1, residuals
gen communal_mean_unit1 =  2385.024 
gen adjusted_price1 = resid_food_group1+communal_mean_unit1
replace adjusted_price1 = communal_mean_unit1 if adjusted_price1 == .|adjusted_price1 <0

regress food_group_unit2 share_FAFH food_expenditure_per_capital household_size age_hh_head married_hh gender_hh years_of_sch_head infant_prop children_prop elderly_prop urban quarter_1 province1-province24
predict resid_food_group2, residuals
gen communal_mean_unit2 = 5567.688     
gen adjusted_price2 = resid_food_group2+communal_mean_unit2
replace adjusted_price2 = communal_mean_unit2 if adjusted_price2 == .

regress food_group_unit3 share_FAFH food_expenditure_per_capital household_size age_hh_head married_hh gender_hh years_of_sch_head infant_prop children_prop elderly_prop urban quarter_1 province1-province24
predict resid_food_group3, residuals
gen communal_mean_unit3 =  18365.47  
gen adjusted_price3 = resid_food_group3+communal_mean_unit3
replace adjusted_price3 = communal_mean_unit3 if adjusted_price3 == .|adjusted_price3 <0

regress food_group_unit4 share_FAFH food_expenditure_per_capital household_size age_hh_head married_hh gender_hh years_of_sch_head infant_prop children_prop elderly_prop urban quarter_1 province1-province24
predict resid_food_group4, residuals
gen communal_mean_unit4 =  300.338   
gen adjusted_price4 = resid_food_group4+communal_mean_unit4
replace adjusted_price4 = communal_mean_unit4 if adjusted_price4 == .|adjusted_price4 <0

regress food_group_unit5 share_FAFH food_expenditure_per_capital household_size age_hh_head married_hh gender_hh years_of_sch_head infant_prop children_prop elderly_prop urban quarter_1 province1-province24
predict resid_food_group5, residuals
gen communal_mean_unit5 =   33208.82   
gen adjusted_price5 = resid_food_group5+communal_mean_unit5
replace adjusted_price5 = communal_mean_unit5 if adjusted_price5 == .|adjusted_price5 <0

regress food_group_unit6 share_FAFH food_expenditure_per_capital household_size age_hh_head married_hh gender_hh years_of_sch_head infant_prop children_prop elderly_prop urban quarter_1 province1-province24
predict resid_food_group6, residuals
gen communal_mean_unit6 =    -5411.588      
gen adjusted_price6 = resid_food_group6+communal_mean_unit6
replace adjusted_price6 = communal_mean_unit6 if adjusted_price6 == .|adjusted_price6 <0

regress food_group_unit7 share_FAFH food_expenditure_per_capital household_size age_hh_head married_hh gender_hh years_of_sch_head infant_prop children_prop elderly_prop urban quarter_1 province1-province24
predict resid_food_group7, residuals
gen communal_mean_unit7 =  3864.525   
gen adjusted_price7 = resid_food_group7+communal_mean_unit7
replace adjusted_price7 = communal_mean_unit7 if adjusted_price7 == .|adjusted_price7 <0

regress food_group_unit8 share_FAFH food_expenditure_per_capital household_size age_hh_head married_hh gender_hh years_of_sch_head infant_prop children_prop elderly_prop urban quarter_1 province1-province24
predict resid_food_group8, residuals
gen communal_mean_unit8 = 97.93375  
gen adjusted_price8 = resid_food_group8+communal_mean_unit8

regress food_group_unit9 share_FAFH food_expenditure_per_capita years_of_sch_head children_prop infant_prop
predict resid_food_group9, residuals
gen communal_mean_unit9 =  3684.981  
gen adjusted_price9 = resid_food_group9+communal_mean_unit9

regress food_group_unit10 food_expenditure_per_capita years_of_sch_head children_prop infant_prop age_hh_head elderly_prop
predict resid_food_group10, residuals
gen communal_mean_unit10 =  0  
gen adjusted_price10 = resid_food_group10+communal_mean_unit10

mean adjusted_price10
mean adjusted_price9
mean  adjusted_price8
mean adjusted_price7
mean adjusted_price6
mean adjusted_price5
mean  adjusted_price4
mean adjusted_price3
mean adjusted_price2
mean adjusted_price1









