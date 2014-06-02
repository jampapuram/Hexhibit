--------------------------------------------------------
--  File created - Wednesday-May-28-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure HP_BSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE HP_BSE 
AS
  -- DECLARE COUNT NUMBER TO CHECK IF THE RECORDS ALREADY EXIST IN THE TABLE
  V_COUNT NUMBER;
  V_CNT   NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO V_COUNT
  FROM HPER_BSE HB
  WHERE EXISTS
    (SELECT *
    FROM HTMP_BSE_EXT
    WHERE /*HB.UPD_DT  <> HTMP_BSE_EXT.UPD_DT
    AND*/ HB.SC_CODE    = HTMP_BSE_EXT.SC_CODE
    --AND HB.VALUE_DATE = HTMP_BSE_EXT.VALUE_DATE
    );
  -- IF COUNT IS GREATER THAN 1 THEN UPDATE THE TABLE ELSE INSERT INTO THE TABLE.
  if V_COUNT >= 1 then
   -- LOOP
      DBMS_OUTPUT.PUT_LINE('1' || V_COUNT);
      INSERT
      INTO HPER_BSE
        (
          SC_CODE,
          SC_NAME,
          SC_GROUP,
          SC_TYPE,
          OPEN,
          HIGH,
          LOW,
          CLOSE,
          LAST,
          PREVCLOSE,
          NO_TRADES,
          NO_OF_SHRS,
          NET_TURNOV,
          TDCLOINDI,
          UPD_DT,
          VALUE_DATE,
          STATUS
        )
      SELECT HTMP_BSE_EXT.SC_CODE,
        HTMP_BSE_EXT.SC_NAME,
        HTMP_BSE_EXT.SC_GROUP,
        HTMP_BSE_EXT.SC_TYPE,
        HTMP_BSE_EXT.open,
        HTMP_BSE_EXT.high,
        HTMP_BSE_EXT.LOW,
        HTMP_BSE_EXT.close,
        HTMP_BSE_EXT.last,
        HTMP_BSE_EXT.PREVCLOSE,
        HTMP_BSE_EXT.NO_TRADES,
        HTMP_BSE_EXT.NO_OF_SHRS,
        HTMP_BSE_EXT.NET_TURNOV,
        HTMP_BSE_EXT.TDCLOINDI,
        SYSDATE,
        SYSDATE,
        'A'
      FROM HTMP_BSE_EXT,
        HPER_BSE
      WHERE HTMP_BSE_EXT.SC_CODE  = HPER_BSE.SC_CODE;
     -- AND HT_BSE_EXT.UPD_DT    <> HPER_BSE.UPD_DT;
     -- AND HT_BSE_EXT.VALUE_DATE = HPER_BSE.VALUE_DATE;
      COMMIT;
      
      -- update the flag inactive for the previous record
      UPDATE HPER_BSE N
      SET N.STATUS    = 'X'
      WHERE n.SC_CODE =
        (SELECT t.SC_CODE
        FROM HPER_BSE T ,
          HPER_BSE HB
        WHERE t.SC_CODE  = HB.SC_CODE
        AND T.VALUE_DATE = HB.VALUE_DATE
        AND T.UPD_DT    <> HB.UPD_DT
        AND T.STATUS    IS NULL
        )
      AND N.VALUE_DATE =
        (SELECT t.value_date
        FROM HPER_BSE T ,
          HPER_BSE HB
        WHERE t.SC_CODE  = HB.SC_CODE
        AND T.VALUE_DATE = HB.VALUE_DATE
        AND T.UPD_DT    <> HB.UPD_DT
        AND T.STATUS    IS NULL
        )
      and N.STATUS is null;
   -- END LOOP;
    DBMS_OUTPUT.PUT_LINE('2' || V_COUNT);
  ELSE
    -- INSERTING THE DATA FROM EXTERNAL TABLE TO PERMANENT TABLE.
    INSERT
    INTO HPER_BSE
      (
        SC_CODE,
        SC_NAME,
        SC_GROUP,
        SC_TYPE,
        OPEN,
        HIGH,
        LOW,
        CLOSE,
        LAST,
        PREVCLOSE,
        NO_TRADES,
        NO_OF_SHRS,
        NET_TURNOV,
        TDCLOINDI,
        UPD_DT,
        value_date
      )
    SELECT SC_CODE,
      SC_NAME,
      SC_GROUP,
      SC_TYPE,
      OPEN,
      HIGH,
      LOW,
      CLOSE,
      LAST,
      PREVCLOSE,
      NO_TRADES,
      NO_OF_SHRS,
      NET_TURNOV,
      TDCLOINDI,
      SYSDATE,--UPD_DT,
      SYSDATE--value_date
    FROM HTMP_BSE_EXT;
    COMMIT;
  END IF;
  /*
  INSERTING THE DATA FROM PERMANENT TABLE TO HI TABLES SINCE WE NEED TO TRUNCATE THE PERMANENT TABLE
  REGULARLY AND ALSO WE WILL PICK ONLY SELECTED COLUMNS IN THE HI TABLE . */
  SELECT COUNT(*)
  INTO V_CNT
  FROM HPER_BSE,
    HI_BSE hb
  WHERE HB.BSE_CODE = HPER_BSE.SC_CODE
  AND HB.VALUE_DATE = HPER_BSE.VALUE_DATE
    --  and HB.UPD_DT    <> HPER_BSE.UPD_DT
  and HPER_BSE.STATUS = 'A' ;
  if V_CNT           >= 1 then
   -- LOOP
      DBMS_OUTPUT.PUT_LINE('3' || V_CNT);
      INSERT INTO HI_BSE
        ( BSE_ID, BSE_CODE, BSE_CLOSE, UPD_DATE,VALUE_DATE,ACTIVE
        )
      SELECT BSE_SEQ.NEXTVAL,
        SC_CODE,
        CLOSE,
        UPD_DT,
        VALUE_DATE,
        'A'
      FROM HPER_BSE
      WHERE STATUS ='A';
      COMMIT;
        -- update the flag inactive for the previous record
      update HI_BSE N
      SET N.active    = 'X'
      WHERE n.BSE_CODE =
        (SELECT t.SC_CODE
        from HPER_BSE T 
        WHERE T.STATUS  = 'X'
        )
      AND N.VALUE_DATE =
        (SELECT t.value_date
        from HPER_BSE T 
        WHERE  T.STATUS    = 'X'
        )
      AND n.active IS NULL;
      
   -- END LOOP;
    DBMS_OUTPUT.PUT_LINE('4'|| V_CNT);
    COMMIT;
  ELSE
    INSERT INTO HI_BSE
      ( BSE_ID, BSE_CODE, BSE_CLOSE, UPD_DATE,VALUE_DATE
      )
    SELECT BSE_SEQ.NEXTVAL, SC_CODE, CLOSE, UPD_DT,VALUE_DATE FROM HPER_BSE;
    COMMIT;
  END IF;
  /*
  AFTER INSERTING THE DATA THE PERMANENT TABLE SHOULD BE REFERESED PERIODICALLY
  FOR EXAMPLE WE ARE DELETING THE RECORDS WHICH ARE GREATER THAN A WEEK FOR THIS TABLE.
  DELETE
  FROM HPER_BSE
  WHERE UPD_DT >= TRUNC (UPD_DT) - 7;
  COMMIT; */
END;

/
