#!/bin/bash
rm -ivf /var/run/redis_6379.pid
#service redis start
#netstat -antp|grep 6379
redis-server
