#!/bin/bash
TIMESTRING=`mongosh "mongodb://localhost:27018,localhost:27019,localhost:27020/?replicaSet=analytics&retryWrites=true&w=majority" --username root --password password --eval "db.getReplicationInfo().tFirst"`
echo ${TIMESTRING}

PYTHONCODE="
import sys
from dateutil.parser import parse

timestring = '${TIMESTRING}'
timestring = timestring.split('(')[0]
timestring = ''.join(timestring.split('GMT'))
print(timestring)
print(parse(timestring).isoformat())
"

python -c "${PYTHONCODE}"
# python timestring_parse.py "${TIMESTRING}"
