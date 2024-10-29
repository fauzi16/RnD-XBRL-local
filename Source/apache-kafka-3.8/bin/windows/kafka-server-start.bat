@echo off
rem Licensed to the Apache Software Foundation (ASF) under one or more
rem contributor license agreements.  See the NOTICE file distributed with
rem this work for additional information regarding copyright ownership.
rem The ASF licenses this file to You under the Apache License, Version 2.0
rem (the "License"); you may not use this file except in compliance with
rem the License.  You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.

IF [%1] EQU [] (
	echo USAGE: %0 server.properties
	EXIT /B 1
)

SetLocal
IF ["%KAFKA_LOG4J_OPTS%"] EQU [""] (
    set KAFKA_LOG4J_OPTS=-Dlog4j.configuration=file:%~dp0../../config/log4j.properties
)
IF ["%KAFKA_HEAP_OPTS%"] EQU [""] (
    rem detect OS architecture
    wmic os get osarchitecture | find /i "32-bit" >nul 2>&1
    IF NOT ERRORLEVEL 1 (
        rem 32-bit OS
        set KAFKA_HEAP_OPTS=-Xmx512M -Xms512M
    ) ELSE (
        rem 64-bit OS
        set KAFKA_HEAP_OPTS=-Xmx1G -Xms1G
    )
)

rem konfigurasi jmx untuk kebutuhan monitoring kafka
rem variable didefinisikan diluar blok if menggunakan (%) jika ingin di dalam blok gunakan (!), hal ini tidak berlaku pada unix bash script (.sh)
set JMX_PORT=9999
set JMX_PROMETHEUS_PORT=7071
set JMX_EXPORTER_PROMETHEUS_AGENT=../../libs/jmx_prometheus_javaagent-0.12.0.jar
set JMX_METRIC_FOR_PROMETHEUS=../../config/kafka-2_0_0.yml
set KAFKA_JMX_ADDITIONAL_OPTS=-Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=localhost -Djava.net.preferIPv4Stack=true -javaagent:%JMX_EXPORTER_PROMETHEUS_AGENT%=%JMX_PROMETHEUS_PORT%:%JMX_METRIC_FOR_PROMETHEUS%

"%~dp0kafka-run-class.bat" kafka.Kafka %*
EndLocal
