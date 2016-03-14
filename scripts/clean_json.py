import json, sys

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

print "Writing to: " + output_filename
with open(output_filename, 'w') as outfile:
    json.dump(data, outfile, indent=4, separators=(',', ': '))