--ALTERA MBR RONDONIA (BASEFUNDO_RO) SO PRA ESSAS TABELAS (BASEFUNDO.BRASIL_ESTADOS,BASEFUNDO.CAPITAL,BASEFUNDO.BRASIL_BUFFER)

update sde.layers t set t.minx=-1538616.34779645, t.miny=5627567.22652473, t.maxx=1925011.25841717, t.maxy=10186611.8268488
 where t.owner='BASEFUNDO_RO' AND T.TABLE_NAME IN ('BRASIL_ESTADOS','CAPITAL','BRASIL_BUFFER');
--commit;
update sde.spatial_references t set t.falsex=-1538616.34779645,t.falsey=5627567.22652473,t.xyunits=70
 where t.srid in (select srid from sde.layers where owner='BASEFUNDO_RO' AND TABLE_NAME IN ('BRASIL_ESTADOS','CAPITAL','BRASIL_BUFFER'));
--commit;