#!/usr/bin/env python
import json, sys
from collections import OrderedDict
import codecs

"""Generate mappings of string names to integer ids.
This is used for MayaNet to create an upgrade and compatibility mapping.
"""

if len(sys.argv) != 1:
    print 'Usage: ', sys.argv[0]
    sys.exit(1)

file_list = [
    'alep_units.json',
    'aria_units.json',
    'comb_units.json',
    'haqq_units.json',
    'merc_units.json',
    'noma_units.json',
    'pano_units.json',
    'toha_units.json',
    'yuji_units.json'
]

mappings = OrderedDict()

for filename in file_list:
    print 'Reading from: ' + filename
    with open(filename, 'r') as f:
        data = json.load(f)

    for unit in data:
        mapping = OrderedDict()
        mapping['isc'] = unit['isc']
        mapping['id'] = unit['id']
        mapping['childs'] = OrderedDict()
        for child in unit['childs']:
            mapping['childs'][child['code']] = child['id']

        # One extra manual mapping is unfortunately required
        if unit['isc'] == 'Chandra Sergeant Thrasymedes':
            mapping['childs']['Light Rocket Launcher'] = 2

        if unit['army'] not in mappings:
            mappings[unit['army']] = []
        mappings[unit['army']].append(mapping)

filename = 'name_id_mapping.json'
print 'Writing to: ' + filename
with codecs.open(filename, 'w', encoding='utf-8') as outfile:
    json.dump(mappings, outfile, indent=2, separators=(',', ': '), ensure_ascii=False)
    

