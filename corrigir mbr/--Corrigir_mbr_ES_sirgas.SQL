update sde.layers t set t.minx=140852.9029056 , t.miny=7586247.2966482, t.maxx=465629.5941257, t.maxy=8056545.1122438
 where t.owner='&USER';
commit;
update sde.spatial_references t set t.falsex=140852.9029056,t.falsey=7586247.2966482,t.xyunits=1270
 where t.srid in (select srid from sde.layers where owner='&USER');
commit;






