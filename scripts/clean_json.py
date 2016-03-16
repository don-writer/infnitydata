import json, sys
from collections import OrderedDict

#print 'Number of arguments:', len(sys.argv), 'arguments.'
#print 'Argument List:', str(sys.argv)

if len(sys.argv) != 3:
	print "Usage: clean_json input_file output_file"
	sys.exit(1)

filename = sys.argv[1]
output_filename = sys.argv[2]

print "Reading from: " + filename
with open(filename, 'r') as f:
     data = json.load(f)
     
#print data

sort_order = [
'army', 'sectorial', 'isc', 'name', 'sharedAva', 'image', 'optionSpecific', 'type', 'imp', 'irr', 
'cube', 'hackable', 'mov', 'cc', 'bs', 'ph', 'wip', 'arm', 'bts', 'w', 'wtype', 's', 'ava', 
'code', 'codename', 'cost', 'swc', 'profile', 'spec', 'bsw', 'ccw', 'independent', 'profiles', 'childs'
]



def unitsort(obj):
	# print "unitsort"
	# print obj
	if isinstance(obj, list):
		for i in range(len(obj)):
			obj[i] = unitsort(obj[i])
		#print "list"
		#print obj
		return obj
	elif isinstance(obj, dict):
		{k: unitsort(v) for k, v in obj.items()}
		obj =  sorted(obj.iteritems(), key=lambda (k, v): sort_order.index(k))
		#print "sorted"
		#print obj
		return obj
	else:
		return obj

#json_ordered = [OrderedDict(sorted(item.iteritems(), key=lambda (k, v): sort_order.index(k)))
#                    for item in data]

json_ordered = unitsort(data)

print "Writing to: " + output_filename
with open(output_filename, 'w') as outfile:
    json.dump(json_ordered, outfile, indent=4, separators=(',', ': '))
    

