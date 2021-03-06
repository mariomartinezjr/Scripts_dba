SELECT 
dbms_stats.get_PREFS('method_opt') method_opt ,
dbms_stats.get_PREFS('CASCADE')  CASCADE ,
dbms_stats.get_PREFS('DEGREE')  DEGREE ,
dbms_stats.get_PREFS('ESTIMATE_PERCENT') ESTIMATE_PERCENT ,
dbms_stats.get_PREFS('NO_INVALIDATE') NO_INVALIDATE ,
dbms_stats.get_PREFS('AUTOSTATS_TARGET') AUTOSTATS_TARGET ,
dbms_stats.get_PREFS('GRANULARITY') GRANULARITY ,
dbms_stats.get_PREFS('PUBLISH') PUBLISH ,
dbms_stats.get_PREFS('INCREMENTAL') INCREMENTAL ,
dbms_stats.get_PREFS('STALE_PERCENT') STALE_PERCENT
FROM dual;

SELECT 
dbms_stats.get_PREFS('INCREMENTAL','ADM_SGV_TRN''TRANSACAO') 
from dual;

exec DBMS_STATS.set_global_prefs('DEGREE',1);
exec dbms_stats.set_param('DEGREE','1');
