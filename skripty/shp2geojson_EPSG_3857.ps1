# Datum: 29.1.2020
# Účel: Slouží pro konverzi shapefilu na geojsony do systému Web Mercator(EPSG:3857)
# Copyright: (C) 2020 Lukáš Kettner
# Spouštět jako správce!!!
# Zjistit aktuální nastavení
# Get-ExecutionPolicy
# Změnit na spustitelné, potřeba následně potvrdit
# set-executionpolicy remotesigned

# Nastavení vstupního a výstupního adresáře, třeba změnit
$input_dir = 'D:\CVUT\155UZPR\GitHub\UZPR_skupina1\data\shp_obec_boskovice\'
$output_dir = 'D:\CVUT\155UZPR\GitHub\UZPR_skupina1\data\geojson_obec_boskovice_3857\'

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

        ogr2ogr -f "GeoJSON" -a_srs $PSScriptRoot\sour_system_krovak.prj  -t_srs EPSG:3857 $output_dir\$ku_name`_$shp_name`.geojson $ku_fullname\$shp_name`.shp

    }
}
