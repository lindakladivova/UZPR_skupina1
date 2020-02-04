#!/bin/bash
# Create folder if not exist
mkdir -p scratch

# Run tippecanoe - build vector tiles
#1) PHranice parcel 
tippecanoe \
-n Boskovice \
-N 'Sample experimental tileset' \
-l hranice_parcel_l  \
-o ./scratch/hranice_parcel_l.mbtiles \
-zg \
-pk \
-pC \
-pS \
-pt \
-f \
--coalesce-densest-as-needed \
--extend-zooms-if-still-dropping  \
../geojson_obec_boskovice_4326/600822_HRANICE_PARCEL_L.geojson \
../geojson_obec_boskovice_4326/608327_HRANICE_PARCEL_L.geojson \
../geojson_obec_boskovice_4326/608475_HRANICE_PARCEL_L.geojson \
../geojson_obec_boskovice_4326/608483_HRANICE_PARCEL_L.geojson \
../geojson_obec_boskovice_4326/785598_HRANICE_PARCEL_L.geojson

#2) Budovy
tippecanoe \
-n Boskovice \
-N 'Sample experimental tileset' \
-l budovy_p  \
-o ./scratch/budovy_p.mbtiles \
-zg \
-pk \
-pC \
-pS \
-pt \
-f \
--coalesce-densest-as-needed \
--extend-zooms-if-still-dropping  \
../geojson_obec_boskovice_4326/600822_BUDOVY_P.geojson \
../geojson_obec_boskovice_4326/608327_BUDOVY_P.geojson \
../geojson_obec_boskovice_4326/608475_BUDOVY_P.geojson \
../geojson_obec_boskovice_4326/608483_BUDOVY_P.geojson \
../geojson_obec_boskovice_4326/785598_BUDOVY_P.geojson

# Merge MVTiles
#tile-join -o boskovice.mbtiles \
#-pk \
#-f \
#./scratch/budovy_p.mbtiles \
#./scratch/hranice_parcel_l.mbtiles

# Unpackage tiles - mb util
rm -r -f tiles
#creates folder tiles automatically
mb-util ./scratch/hranice_parcel_l.mbtiles ./tiles --image_format=pbf
mb-util ./scratch/budovy_p.mbtiles ./tiles_budovy --image_format=pbf