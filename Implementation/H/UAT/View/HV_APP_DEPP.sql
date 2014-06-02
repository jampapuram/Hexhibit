
  CREATE OR REPLACE  VIEW HV_APP_DEPP (SCHEME, DEC, JAN) AS 
  WITH TEMP_DATA AS
(
SELECT SCHEME, NAV_DATE, Sum(GAIN_LOSS) GAIN_LOSS
--from v_appre_depre_hdfc
FROM HI_schnavbd_CURR
  WHERE nav_method='A'AND 
(NAV_DATE In ('08 Jan 2014','31 Mar 2013','31 Dec 2013','31 MAR  2014'))
and (security is not null)
--and scheme = 'APR24MT112'
group by scheme, nav_date
ORDER BY SCHEME, NAV_DATE)
select SCHEME,DEC,JAN from temp_data
pivot( sum(gain_loss) for nav_date in ( '31 Dec 2013' as DEC,'08 JAN 2014' JAN));
 
