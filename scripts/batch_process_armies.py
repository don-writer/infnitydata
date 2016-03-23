#!/usr/bin/env python

import os

file_list = [
"alep_units.json",
"aria_units.json",
"comb_units.json",
"haqq_units.json",
"merc_units.json",
"noma_units.json",
"pano_units.json",
"toha_units.json",
"yuji_units.json"
]

for file in file_list:
	os.system("scripts\\number_childs.py " + file)
	os.system("scripts\\number_profiles.py " + file)
	os.system("scripts\\clean_json.py " + file)
