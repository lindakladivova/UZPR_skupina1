#!/bin/bash
# Create folder if not exist
mkdir -p scratch

# Run tippecanoe - build vector tiles
#1) Hranice parcel - linie
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

#2) Budovy - polygony
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

#3) Parcely KN - body
tippecanoe \
-n Boskovice \
-N 'Sample experimental tileset' \
-l parcely_kn_b  \
-o ./scratch/parcely_kn_b.mbtiles \
-zg \
-pk \
-pC \
-pS \
-pt \
-f \
-Z 9 \
--coalesce-densest-as-needed \
--extend-zooms-if-still-dropping  \
../geojson_obec_boskovice_4326/600822_PARCELY_KN_B.geojson \
../geojson_obec_boskovice_4326/608327_PARCELY_KN_B.geojson \
../geojson_obec_boskovice_4326/608475_PARCELY_KN_B.geojson \
../geojson_obec_boskovice_4326/608483_PARCELY_KN_B.geojson \
../geojson_obec_boskovice_4326/785598_PARCELY_KN_B.geojson

# Merge MVTiles
#tile-join -o boskovice.mbtiles \
#-pk \
#-f \
#./scratch/budovy_p.mbtiles \
#./scratch/hranice_parcel_l.mbtiles

# Unpackage tiles - mb util
rm -r -f tiles
#creates folder tiles automatically
mb-util ./scratch/hranice_parcel_l.mbtiles ./tiles_hranice --image_format=pbf
mb-util ./scratch/budovy_p.mbtiles ./tiles_budovy --image_format=pbf
mb-util ./scratch/parcely_kn_b.mbtiles ./tiles_parcely_body --image_format=pbf