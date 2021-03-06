#!/bin/bash
#
# versao 0.1
#
# NOME
#   auditoria_oracle_algar.sh
#
# DESCRICAO
#   Efetua colecao de SQL e scripts a fim de coletar informacoes para auditoria Algar do
# banco de dados oracle.
#
# NOTA
#
# HISTORICO
# autor           dd/mm/yyyy   Historico
# marcos.abraga   10/05/2013 - Disponivel primeira versao.
#

# variaveis
FC=/tmp/exec_$$.sql             # arq. temporario

# conjunto de queries para execucao
>$FC \
cat <<__FIM__
conn / as sysdba
prompt
prompt
prompt Volume de Dados Alocado em Disco por Esquema 
prompt ===============

select distinct(O.owner),O.tablespace_name,SUM(O.BYTES)/1024 /1024/1024 TAM_MB   
from dba_segments o,Dba_Users u 
where o.owner in (select  distinct(t.username) 
from Dba_Users T ) and o.owner=u.username 
GROUP BY O.owner, O.tablespace_name ;

prompt
prompt
prompt 
prompt =========================

prompt
prompt
prompt Volume de Dados Alocado em Disco por Banco de Dados 
prompt ===============

select sum(bytes)/1024/1024/1024 || ' MBytes' from dba_segments;

prompt
prompt
prompt 
prompt =========================

prompt
prompt
prompt Percentual de utiliza��o por Tablespace
prompt ===============

select * from dba_tablespace_usage_metrics order by 1;

prompt
prompt
prompt 
prompt =========================

prompt
prompt
prompt Percentual dispon�vel para crescimento por Tablespace
prompt ===============

select  a.tablespace_name,(a.used_space/a.tablespace_size)/100 Tamanho_MB from dba_tablespace_usage_metrics a order by 1;

prompt
prompt
prompt 
prompt =========================

prompt
prompt
prompt Percentual de �Cache Hit�
prompt ===============

select ((1-a.value/(b.value+c.value))*100) as "Cache Hit"
         from v$sysstat a, v$sysstat b , v$sysstat c
         where a.name = 'physical reads'
         and b.name = 'db block gets'
         and c.name = 'consistent gets';
         
prompt
prompt
prompt 
prompt =========================         

prompt
prompt
prompt Percentual de Backups em Conformidade com a Pol�tica de Backup
prompt ===============

select a.START_TIME,a.end_time,a.output_bytes_per_sec,a.status,a.input_type   
from v$rman_backup_job_details a where a.START_TIME > to_char(sysdate , 'dd/mm/yyyy');

prompt
prompt
prompt 
prompt =========================

exit
__FIM__

sqlplus /nolog @$FC

rm $FC 
