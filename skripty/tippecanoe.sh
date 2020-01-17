#!/bin/bash
# Create folder if not exist
mkdir -p scratch

# Run tippecanoe - build vecotr tiles
tippecanoe -o ./scratch/tiles.mbtiles -zg -pk -pC -pS -pt -f ./UZPR_data/geojson_obec_boskovice/600822_BUDOVY_P.geojson

# Unpackage - mb util
rm -r -f tiles
#creates folder tiles automatically
mb-util ./scratch/tiles.mbtiles ./tiles --image_format=pbf
