
  CREATE OR REPLACE  VIEW HV_UPD_MKTLOT (SECURITY, NSE_CODE, MKTLOT, MKT_SECURITY) AS 
  select 
hsec.SECURITY,
hsec.NSE_CODE,
upd.MKTLOT,
upd.SECURITY mkt_security
from HV_NSE_CODE hsec,HUPD_MKTLOT_UPLOAD upd
where 
hsec.NSE_CODE=upd.security
union all
select 
hsec.SECURITY,
upd.SECURITY NSE_CODE,
upd.MKTLOT,
upd.SECURITY mkt_security
from HV_NSE_CODE hsec,HUPD_MKTLOT_UPLOAD upd
where 
hsec.NSE_CODE(+)=upd.security
and hsec.nse_code is null;
 
