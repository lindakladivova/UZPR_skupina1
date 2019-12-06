# Datum: 20.11.2019
# Ucel: Slouží pro konverzi shapefilu na geojsony
# Copyright: (C) 2019 Linda Kladivová
# Spouštět jako správce!!!

# Nastavení vstupního a výstupního adresáře, třeba změnit
$input_dir = 'C:\Users\kladivoval\Documents\UZPR_data\shp_obec_boskovice'
$output_dir = 'C:\Users\kladivoval\Documents\UZPR_data\geojson_obec_boskovice'

If(!(test-path $output_dir))
{
      New-Item -ItemType Directory -Force -Path $output_dir
}

#################################################################################

$seznam_ku = Get-ChildItem $input_dir 

foreach ($ku in $seznam_ku) {

    $ku_fullname = $ku.FullName
    $ku_name = $ku.Name

    $shapefiles = Get-ChildItem $ku_fullname\* -Include *.shp

    foreach ($shapefile in $shapefiles) {

        $shp_fullname = $shapefile.Name
        $shp_name = $shp_fullname.trimend(".shp") 

        ogr2ogr -f "GeoJSON" -a_srs $PSScriptRoot\sour_system_krovak.prj  -t_srs "CRS:84" $output_dir\$ku_name`_$shp_name`.geojson $ku_fullname\$shp_name`.shp

    }
}
