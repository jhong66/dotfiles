import sys
from dateutil.parser import parse

timestring = sys.argv[1]
timestring = timestring.split("(")[0]
print(parse(timestring).isoformat())
