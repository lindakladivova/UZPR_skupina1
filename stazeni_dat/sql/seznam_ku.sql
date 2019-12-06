SET serveroutput ON
SET SPACE 1
SET NUMWIDTH 12
SET LINESIZE 8000
SET NEWPAGE 0
SET PAGESIZE 0
SET ECHO OFF
SET HEADING OFF
SET FEEDBACK OFF
SET VERIFY OFF
SET TRIMOUT ON
SET TRIMSPOOL ON
SET SERVEROUTPUT ON format wrapped size 1000000
SET linesize 20000  
set long 100000 LONGC 100000  

DEFINE VYSTUP_ADR="&1"

spool &VYSTUP_ADR.seznam_ku_kraj_liberecky.txt;

--vybere 532 ku pro liberecky kraj
SELECT distinct KU.kod 
FROM SC_KATASTR_UZEMI KU 
LEFT JOIN SC_OBCE OB  on (OB.KOD = KU.OBCE_KOD) and (OB.PLATNOST_DO is null)
LEFT JOIN SC_OKRESY OK on (OK.KOD = OB.OKRESY_KOD) and (OK.PLATNOST_DO is null)
LEFT JOIN SC_NOVE_KRAJE NOV on (NOV.KOD = OK.NKRAJE_KOD) and (NOV.PLATNOST_DO is null)
where NOV.KOD = 78;

spool off;

spool &VYSTUP_ADR.seznam_ku_okres_benesov.txt;

--vybere 279 ku pro okres Benešov
SELECT distinct KU.kod 
FROM SC_KATASTR_UZEMI KU 
LEFT JOIN SC_OBCE OB  on (OB.KOD = KU.OBCE_KOD) and (OB.PLATNOST_DO is null)
LEFT JOIN SC_OKRESY OK on (OK.KOD = OB.OKRESY_KOD) and (OK.PLATNOST_DO is null)
where OK.kod = 3201;

spool off;

spool &VYSTUP_ADR.seznam_ku_obec_boskovice.txt;

--vybere 5 ku pro obec Boskovice
SELECT distinct KU.kod 
FROM SC_KATASTR_UZEMI KU 
LEFT JOIN SC_OBCE OB  on (OB.KOD = KU.OBCE_KOD) and (OB.PLATNOST_DO is null)
where OB.kod = 581372;

spool off;

exit;

