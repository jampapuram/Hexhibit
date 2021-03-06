
  CREATE OR REPLACE  VIEW HV_MTM_DEAL (NSE_CODE, SCHEME, INDXFUTURE, VALUE_DATE, TRAN_TYPE, UNITS, RATE, SCH_INDXFUT, EXPIRY_DATE, CODE_EXPIRY, MKT_PRICE, UPLOAD_DATE, DEAL_MOVEMENT) AS 
  SELECT SUBSTR (SECURITY.STK_SEC_ID,3) NSE_CODE ,
    FUTUREDEAL.SCHEME,
    FUTUREDEAL.INDXFUTURE,
    FUTUREDEAL.VALUE_DATE,
    FUTUREDEAL.TRAN_TYPE,
    FUTUREDEAL.UNITS,
    FUTUREDEAL.RATE,
    (FUTUREDEAL.SCHEME
    ||''
    ||FUTUREDEAL.INDXFUTURE)SCH_INDXFUT,
    INDXFUTURE.MAT_DATE EXPIRY_DATE,
    (SUBSTR (SECURITY.STK_SEC_ID,3)
    ||''
    || TO_CHAR((INDXFUTURE.MAT_DATE - TO_DATE('01-JAN-1900'))+2))CODE_EXPIRY,
    --  LAG(MKTPRICE.MKT_PRICE, 1, 0) OVER (ORDER BY MKTPRICE.SECURITY, MKTPRICE.VALUE_DATE) AS MKT_PRICE,
    MKTPRICE.MKTPRICE AS MKT_PRICE,
   -- NEXT_DAY('01-Aug-03', 'TUESDAY')
    (MKTPRICE.UPLOAD_DATE + 1) AS UPLOAD_DATE,
    CASE
      WHEN FUTUREDEAL.TRAN_TYPE = 'IFPUR'
      THEN (FUTUREDEAL.RATE   - MKTPRICE.MKTPRICE)* FUTUREDEAL.UNITS
      ELSE (MKTPRICE.MKTPRICE - FUTUREDEAL.RATE )* FUTUREDEAL.UNITS
    END AS DEAL_MOVEMENT
  FROM HI_FUTUREDEAL_CURR FUTUREDEAL,
    HI_MKTPRICE_CURR MKTPRICE,
    HI_INDXFUTURE_CURR INDXFUTURE,
    HM_SECURITY SECURITY,
    HUPD_MKTPRICE_UPLOAD MKTPRICE
  WHERE FUTUREDEAL.RECTYPE    ='L'
  AND FUTUREDEAL.INDXFUTURE   = MKTPRICE.SECURITY
  AND SECURITY.SECURITY       = INDXFUTURE.UNDERLYING_CODE
  AND SECURITY.RECTYPE        = 'L'
  AND FUTUREDEAL.INDXFUTURE   = INDXFUTURE.INDXFUTURE
  AND INDXFUTURE.RECTYPE      = 'L'
  AND FUTUREDEAL.VALUE_DATE   = MKTPRICE.VALUE_DATE
  AND MKTPRICE.UNDERLYING_CODE= SUBSTR (SECURITY.STK_SEC_ID,3)
  AND MKTPRICE.EXPIRY_DATE    = INDXFUTURE.MAT_DATE;
 
