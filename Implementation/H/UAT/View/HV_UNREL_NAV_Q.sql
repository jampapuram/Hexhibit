
  CREATE OR REPLACE  VIEW HV_UNREL_NAV_Q (UNREAL_SCHEME, UNREAL_SCHEMECLASS, UNREAL_NAV_DT, UNREAL_AMOUNT, UNREAL_PU, NAV_SCHEME, NAV_SCHEMECLASS, NAV_SCHCLASS_NAME, NAV_NET_ASSET_AMOUNT, NAV_LAST_NAV, NAV_UNITS, NAV_WKEND_DT, PREV_NAV_UNITS, PREV_UNREAL_AMOUNT) AS 
  SELECT unreal_q.scheme UNREAL_SCHEME,
    unreal_q.schclass UNREAL_SCHEMECLASS,
    unreal_q.nav_date UNREAL_NAV_DT,
    unreal_q.unrel UNREAL_AMOUNT,
    CASE
      WHEN unreal_q.unrel >0
      THEN ROUND(NVL((unreal_q.unrel/nav_q.UNITS_OUTS),0),5)
      ELSE to_number (0)
    END AS unreal_PU,
    nav_q.scheme nav_SCHEME,
    nav_q.schclass NAV_SCHEMECLASS,
    nav_q.SCHCLASS_NAME NAV_SCHCLASS_NAME,
    nav_q.NET_ASSETS NAV_NET_ASSET_AMOUNT,
    nav_q.LAST_NAV NAV_LAST_NAV,
    nav_q.UNITS_OUTS NAV_UNITS,
    nav_q.WEEKEND_DT NAV_WKEND_DT,
    NVL(LAG((NAV_Q.UNITS_OUTS),1) OVER (ORDER BY NAV_Q.SCHCLASS,NAV_Q.WEEKEND_DT,NAV_Q.SCHEME),0) PREV_NAV_UNITS,
    CASE
    WHEN NVL(LAG((unreal_q.unrel),1) OVER (ORDER BY nav_q.schclass,nav_q.WEEKEND_DT,nav_q.scheme),0) >0
    THEN NVL(LAG((unreal_q.unrel),1) OVER (ORDER BY nav_q.schclass,nav_q.WEEKEND_DT,nav_q.scheme),0)
    ELSE to_number (0)
    END AS PREV_UNREAL_AMOUNT
  FROM
    (SELECT scheme,
      schclass,
      nav_date ,
      unrel
    FROM
      (SELECT schnav.SCHEME scheme,
        schnav.Nav_DATE nav_date,
        schnav.schclass schclass,
        SUM(schnav.amount) unrel
      FROM --schnav_project
        HI_schnavbd_CURR schnav,
        sysparam
      WHERE schnav.Nav_DATE = sysparam.cur_date -------to be modified
      AND schnav.ACCOUNT    ='PROFIT/LOSS'
      AND schnav.nav_method ='I'
      AND sysparam.rectype  ='L'
      GROUP BY schnav.SCHEME,
        schnav.Nav_DATE,
        schnav.schclass
      UNION ALL
      SELECT schnavbd.SCHEME scheme,
        schnavbd.NAV_DATE nav_date,
        schnavbd.schclass schclass,
        SUM(schnavbd.amount) unrel
      FROM HI_schnavbd_CURR schnavbd
      WHERE (schnavbd.NAV_DATE > '30 Mar 2013')---????)
      AND ACCOUNT              ='PROFIT/LOSS'
      AND nav_method           ='I'
      GROUP BY schnavbd.NAV_DATE,
        schnavbd.SCHEME,
        schnavbd.schclass
      )
    WHERE scheme='HDFCMS' ---what to do with this??????????
    ORDER BY 3,2
    ) UNREAL_Q,
    ------2
    (
    SELECT scheme,
      schclass,
      SCHCLASS_NAME,
      NET_ASSETS,
      LAST_NAV,
      UNITS_OUTS,
      WEEKEND_DT
    FROM
      (SELECT V_PROJECT_PLAN_HDFC.LAST_NET_ASSETS NET_ASSETS,
        V_PROJECT_PLAN_HDFC.LAST_NAV LAST_NAV,
        V_PROJECT_PLAN_HDFC.LAST_UNITS_OUTS UNITS_OUTS,
        V_PROJECT_PLAN_HDFC.SCHEME SCHEME,
        V_PROJECT_PLAN_HDFC.SCHCLASS SCHCLASS ,
        V_PROJECT_PLAN_HDFC.WEEKEND_DT WEEKEND_DT,
        V_PROJECT_PLAN_HDFC.NAME NAME ,
        V_PROJECT_PLAN_HDFC.SCHCLASS_NAME SCHCLASS_NAME
      FROM
        (SELECT (a.NET_ASSETS_F) NET_ASSETS,
          (a.LAST_NET_ASSETS) LAST_NET_ASSETS,
          (a.LAST_NAV) LAST_NAV,
          (a.LAST_UNITS_OUTS) LAST_UNITS_OUTS,
          a.scheme,
          a.schclass,
          a.weekend_dt,
          b.SCHEME_name name,
          c.name schclass_name,
          appre_depre
        FROM HI_weeknav_CURR a, ----insert project plan here----------------
          HM_scheme b,
          HM_schclass c
        WHERE a.schclass  <> 'GLOBAL'
        AND a.schclass     = c.schclass
        AND a.scheme       = c.scheme
        AND a.amc_code     = c.amc_code
        AND c.rectype      ='L'
        AND a.scheme       = b.scheme
        AND b.activate_y_n = 'Y'
        AND b.rectype      = 'L'
        ORDER BY a.scheme,
          a.schclass,
          a.weekend_dt,
          b.SCHEME_NAME,
          c.name
        ) V_PROJECT_PLAN_HDFC,
        SYSPARAM
      WHERE V_PROJECT_PLAN_HDFC.WEEKEND_DT=SYSPARAM.CUR_DATE
      AND SYSPARAM.RECTYPE                ='L'
      UNION ALL
      SELECT V_EOD_PLAN_hdfc.LAST_NET_ASSETS NET_ASSETS,
        V_EOD_PLAN_hdfc.LAST_NAV LAST_NAV,
        V_EOD_PLAN_hdfc.LAST_UNITS_OUTS UNITS_OUTS,
        V_EOD_PLAN_hdfc.SCHEME SCHEME,
        V_EOD_PLAN_hdfc.SCHCLASS SCHCLASS,
        V_EOD_PLAN_HDFC.WEEKEND_DT WEEKEND_DT,
        V_EOD_PLAN_HDFC.NAME NAME ,
        V_EOD_PLAN_HDFC.SCHCLASS_NAME SCHCLASS_NAME
      FROM
        (SELECT (a.NET_ASSETS_F) NET_ASSETS,
          (a.LAST_NET_ASSETS) LAST_NET_ASSETS,
          (a.LAST_NAV) LAST_NAV,
          (a.LAST_UNITS_OUTS) LAST_UNITS_OUTS,
          a.scheme,
          a.schclass,
          a.weekend_dt,
          b.SCHEME_NAME name,
          c.name schclass_name,
          appre_depre
        FROM HI_weeknav_CURR a,
          HM_scheme b,
          HM_schclass c
        WHERE a.schclass  <> 'GLOBAL'
        AND a.schclass     = c.schclass
        AND a.scheme       = c.scheme
        AND a.amc_code     = c.amc_code
        AND c.rectype      ='L'
        AND a.scheme       = b.scheme
        AND b.activate_y_n = 'Y'
        AND b.rectype      = 'L'
        ORDER BY a.scheme,
          a.schclass,
          a.weekend_dt,
          b.SCHEME_NAME,
          c.name
        ) V_EOD_PLAN_hdfc
      WHERE V_EOD_PLAN_hdfc.WEEKEND_DT >='31 Mar 2013'
      )-------------??????????????how to manage this in live scenario???)
    WHERE scheme='HDFCMS'
    ORDER BY weekend_dt DESC,
      schclass
    ) NAV_Q
  WHERE nav_q.weekend_dt = unreal_q.nav_date
  AND NAV_Q.SCHEME       = UNREAL_Q.SCHEME
  AND unreal_q.schclass  =nav_q.schclass;
 
