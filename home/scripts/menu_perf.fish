#!/usr/bin/env fish

set cpu_usage $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)
