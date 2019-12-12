# Datum: 20.11.2019
# Ucel: Slouží pro import shapefilů KM do POSTGISu
# Copyright: (C) 2019 Linda Kladivová
# Spouštět jako správce!!!

# Nastavení vstupního a výstupního adresáře
$input_dir = 'C:\Users\kladivoval\Documents\UZPR_data\shp_obec_boskovice'
$sour_system = "$PSScriptRoot\sour_system_krovak.prj"

# Názvy vrstev, typy prostorových prvků a název budoucí tabulky v databázi
$items = @(
    New-Object PSObject -Property @{Nazev = "BODOVE_POLE_B.shp";  Typ = "MULTIPOINT"; Tabulka = "BODOVE_POLE_B"}
    New-Object PSObject -Property @{Nazev = "BODOVE_POLE_T.shp"; Typ = "MULTIPOINT"; Tabulka = "BODOVE_POLE_T"}
    New-Object PSObject -Property @{Nazev = "BUDOVY_B.shp";  Typ = "MULTIPOINT"; Tabulka = "BUDOVY_B"}
    New-Object PSObject -Property @{Nazev = "BUDOVY_DEF.shp"; Typ = "MULTIPOINT"; Tabulka = "BUDOVY_DEF"}
    New-Object PSObject -Property @{Nazev = "BUDOVY_P.shp";  Typ = "MULTIPOLYGON"; Tabulka = "BUDOVY_P"}
    New-Object PSObject -Property @{Nazev = "DALSI_PRVKY_MAPY_B.shp"; Typ = "MULTIPOINT"; Tabulka = "DALSI_PRVKY_MAPY_B"}
    New-Object PSObject -Property @{Nazev = "DALSI_PRVKY_MAPY_L.shp";  Typ = "MULTILINESTRING"; Tabulka = "DALSI_PRVKY_MAPY_L"}
    New-Object PSObject -Property @{Nazev = "DALSI_PRVKY_MAPY_T.shp"; Typ = "MULTIPOINT"; Tabulka = "DALSI_PRVKY_MAPY_T"}
    New-Object PSObject -Property @{Nazev = "HRANICE_PARCEL_L.shp";  Typ = "MULTILINESTRING"; Tabulka = "HRANICE_PARCEL_L"}
    New-Object PSObject -Property @{Nazev = "KATASTRALNI_UZEMI_DEF.shp"; Typ = "MULTIPOINT"; Tabulka = "KATASTRALNI_UZEMI_DEF"}
    New-Object PSObject -Property @{Nazev = "KATASTRALNI_UZEMI_L.shp";  Typ = "MULTILINESTRING"; Tabulka = "KATASTRALNI_UZEMI_L"}
    New-Object PSObject -Property @{Nazev = "KATASTRALNI_UZEMI_P.shp"; Typ = "MULTIPOLYGON"; Tabulka = "PARCELY_KN_B"}
    New-Object PSObject -Property @{Nazev = "PARCELY_KN_B.shp";  Typ = "MULTIPOINT"; Tabulka = "PARCELY_KN_B"}
    New-Object PSObject -Property @{Nazev = "PARCELY_KN_DEF.shp"; Typ = "MULTIPOINT"; Tabulka = "PARCELY_KN_DEF"}
    New-Object PSObject -Property @{Nazev = "PARCELY_KN_L.shp";  Typ = "MULTILINESTRING"; Tabulka = "PARCELY_KN_L"}
    New-Object PSObject -Property @{Nazev = "PARCELY_KN_P.shp"; Typ = "MULTIPOLYGON"; Tabulka = "PARCELY_KN_P"}
    New-Object PSObject -Property @{Nazev = "PARCELY_KN_T.shp";  Typ = "MULTIPOINT"; Tabulka = "PARCELY_KN_T"}
    New-Object PSObject -Property @{Nazev = "PRVKY_ORIENT_MAPY_B.shp"; Typ = "MULTIPOINT"; Tabulka = "PRVKY_ORIENT_MAPY_B"}
    New-Object PSObject -Property @{Nazev = "PRVKY_ORIENT_MAPY_L.shp"; Typ = "MULTILINESTRING"; Tabulka = "PRVKY_ORIENT_MAPY_L"}
    New-Object PSObject -Property @{Nazev = "PRVKY_ORIENT_MAPY_T.shp"; Typ = "MULTIPOINT"; Tabulka = "PRVKY_ORIENT_MAPY_T"}
    New-Object PSObject -Property @{Nazev = "VB_P.shp"; Typ = "MULTIPOLYGON"; Tabulka = "VB_P"}
)

#################################################################################

$seznam_ku = Get-ChildItem $input_dir 

foreach ($ku in $seznam_ku) {

    $ku_fullname = $ku.FullName
    $ku_name = $ku.Name

    foreach ($item in $items) {

        $nazev = $item.Nazev
        $typ = $item.Typ
        $tabulka = $item.Tabulka

        $dir = "$input_dir\$ku_name\$nazev"

        $env:PGCLIENTENCODING="LATIN1"

        if (Test-Path $dir) {

             ogr2ogr -append -f PostgreSQL PG:"dbname='pgis_uzpr' user='uzpr20_a' password='a.uzpr20' host= 'geo102.fsv.cvut.cz'" -a_srs $sour_system $dir -nlt $typ -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -nln "uzpr20_a.$tabulka"
        }    

    }
}
