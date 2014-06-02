
  CREATE OR REPLACE  VIEW HV_AUM_ANALYSIS_SUMMARY (SCHEME_TYPE, AUM, NET_PERFORMANCE, DIVIDEND, OTH_TOTAL, TOT_VALUATION, OPE_EXP, INC_DIV_EXP, TOTAL, AUM_AS0N, VALUE_DATE) AS 
  SELECT scheme_type,
  SUM(AUM)             AS AUM,
  SUM(net_performance) AS net_performance,
  SUM(DIVIDEND) DIVIDEND,
  SUM(oth_total) oth_total,
  SUM(tot_valuation) AS tot_valuation,
  sum(ope_exp)       as ope_exp,
  sum(inc_div_exp)   as inc_div_exp,
  sum(net_performance + dividend + oth_total + tot_valuation + ope_exp + inc_div_exp) as total,
   sum(AUM + net_performance + DIVIDEND + oth_total + tot_valuation + ope_exp + inc_div_exp) as aum_as0n, 
value_date
FROM hv_analysis
GROUP BY scheme_type,value_date;
 
