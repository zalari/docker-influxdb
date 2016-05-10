#!/bin/bash

#start influxdb with logging to stdout
exec influxdb -config=/opt/influxdb/shared/config.toml -stdout=true
