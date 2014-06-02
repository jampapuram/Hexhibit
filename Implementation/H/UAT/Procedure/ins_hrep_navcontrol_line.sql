--------------------------------------------------------
--  File created - Thursday-May-29-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure INS_HREP_NAVCONTROL_LIVE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE INS_HREP_NAVCONTROL_LIVE as 
begin
INSERT INTO HREP_NAVCONTROL_LIVE_CURR   ( portfolio, portfolio_name, 
portfolio_class_name, portfolio_type, portfolio_category, PORTFOLIO_CATEGORY_ALT
, PORTFOLIO_CATEGORY_NAME_ALT, per_mgmt_recur_exp, 
dividend, missed_value, schclass, scheme_aum_cr, scheme_units_cr, aum_cr, units_cr,
 nav,last_nav, total_expense, planwise_income, mgmt_recurring_expense, net_addition_planwise,
 nav_mov, manual_current_day_nav, weeknav_scheme, weekend_dt,nav_date, total_income, 
 buy_nav_value, sell_nav_value,FINAL_MANUAL_CURRENT_DAY_NAV) 
 
 SELECT  SCHEME, SCHEME_NAME, 
NAME, PORTFOLIO_TYPE, PORTFOLIO_CATEGORY,portfolio_cat_name_alt,
   port_cat_alt, PER_MGMT_RECUR_EXP, 
DIVIDEND, MISSED_VALUE, SCHCLASS, SCH_AUM_CR, SCH_UNITS_CR, AUM_CR, UNITS_CR,
 NAV,last_nav, TOTAL_EXPENSE,PLANWISE_INCOME, MGMT_RECUR_EXP,NET_ADDITION_PLANWISE,
 NAV_MOV, MANUAL_CURRENT_DAY_NAV, WKNAV_SCHEME, WEEKEND_DT,nav_date, TOTAL_INCOME, 
 BUY_NAV_VALUE, SELL_NAV_VALUE,FINAL_MANUAL_CURRENT_DAY_NAV FROM HV_NAV_CONTROL_COMPUTATION;
 end;

/
