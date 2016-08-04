## debug gc log
#CATALINA_OPTS="-XX:+PrintHeapAtGC -XX:+PrintTenuringDistribution -XX:+TraceGen1Time -XX:+PrintTenuringDistribution -XX:+TraceGen0Time $CATALINA_OPTS"

CATALINA_OPTS="-Xmx16G -Xms16G $CATALINA_OPTS"
CATALINA_OPTS="-XX:PermSize=128M -XX:MaxPermSize=128M $CATALINA_OPTS"
CATALINA_OPTS="-XX:NewSize=2G -XX:MaxNewSize=2G $CATALINA_OPTS"
CATALINA_OPTS="-XX:SurvivorRatio=8 -XX:MaxTenuringThreshold=6 -XX:TargetSurvivorRatio=80 $CATALINA_OPTS"
CATALINA_OPTS="-XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseParNewGC $CATALINA_OPTS"
CATALINA_OPTS="-XX:+UseCompressedOops -XX:+UseStringCache -XX:+OptimizeStringConcat -XX:+UseCompressedStrings $CATALINA_OPTS"
CATALINA_OPTS="-XX:CMSMaxAbortablePrecleanTime=15000 -XX:CMSWaitDuration=15000 -XX:+CMSConcurrentMTEnabled $CATALINA_OPTS"
CATALINA_OPTS="-XX:+DisableExplicitGC $CATALINA_OPTS"
CATALINA_OPTS="-XX:+PrintCommandLineFlags $CATALINA_OPTS"

CATALINA_OPTS="
  -verbose:gc
  -Xloggc:/spacyz/var/log/gc.log
  -XX:+UseGCLogFileRotation
  -XX:NumberOfGCLogFiles=10
  -XX:GCLogFileSize=50M
  -XX:+PrintGCDetails
  -XX:+PrintGCTimeStamps
  -XX:+PrintGCDateStamps
  $CATALINA_OPTS
"

CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=7900 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false $CATALINA_OPTS"


