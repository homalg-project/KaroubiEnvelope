SetPackageInfo( rec(

PackageName := "KaroubiEnvelope",

Subtitle := "Karoubi Envelope for CAP",

Version := Maximum( [
                   "2018.08.30"
                   ## this line prevents merge conflicts
                   ] ),

# this avoids git-merge conflicts
Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Date{[ 9, 10 ]}, "/", ~.Date{[ 6, 7 ]}, "/", ~.Date{[ 1 .. 4 ]} ),

ArchiveURL := Concatenation( "http://github.com/Peaupote/KaroubiEnvelope-", ~.Version ),

ArchiveFormats := ".tar.gz",

Persons := [
  rec( 
    LastName      := "Flin",
    FirstNames    := "Maxime",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "maxime.flin@gmail.com",
    Place         := "Paris",
    Institution   := "Université Paris Diderot"
  )
  
],

Status := "dev",

README_URL := 
  "http://homalg.math.rwth-aachen.de/~barakat/homalg-project/CategoriesWithAmbientObjects/README.CategoriesWithAmbientObjects",
PackageInfoURL := 
  "http://homalg.math.rwth-aachen.de/~barakat/homalg-project/CategoriesWithAmbientObjects/PackageInfo.g",

PackageDoc := rec(
  BookName  := "KaroubiEnvelope",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Karoubi Envelope for CAP",
  Autoload  := false
),

Dependencies := rec(
  GAP := ">=4.4",
  NeededOtherPackages := [
                   [ "AutoDoc", ">= 2013.12.04" ],
                   [ "CAP",     ">= 2018.08.15"],
                   [ "GAPDoc", ">= 1.1" ]
                   ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ]
),

AvailabilityTest := function( )
    return true;
  end,

Autoload := false,

Keywords := [ "categories", "Karoubi envelope" ]

));
