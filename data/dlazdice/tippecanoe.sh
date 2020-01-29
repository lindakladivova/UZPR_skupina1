#!/bin/bash
# Create folder if not exist
mkdir -p scratch

# Run tippecanoe - build vector tiles
tippecanoe -o ./scratch/tiles_5514.mbtiles -zg -pk -pC -pS -pt -f ../geojson_obec_boskovice_5514/608483_HRANICE_PARCEL_L.geojson

# Unpackage - mb util
rm -r -f tiles
#creates folder tiles automatically
mb-util ./scratch/tiles_5514.mbtiles ./tiles --image_format=pbf