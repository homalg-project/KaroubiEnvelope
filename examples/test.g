LoadPackage("KaroubiEnvelope");
LoadPackage( "LinearAlgebraForCAP" );

Q := HomalgFieldOfRationals();

underlying_category := MatrixCategory( Q );

kar := KaroubiEnvelope(underlying_category);


V := VectorSpaceObject( 2, Q );

endo := VectorSpaceMorphism( V, HomalgMatrix( [ [ 0, 1 ], [ 1, 0 ] ], 2, 2, Q ), V );

Vendo := KaroubiObject( endo );

Mor := KaroubiMorphism(Vendo, endo, Vendo);

Display(Idempotent(Vendo));
