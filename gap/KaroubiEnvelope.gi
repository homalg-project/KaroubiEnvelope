#############################################################################
##
##                  KaroubiEnvelope package
##
##  Copyright 2018, Maxime Flin, Université Paris Diderot
##  	      	    Daniel Juteau, Université Paris Diderot
##
##
#############################################################################

LoadPackage( "AttributeCategoryForCAP" );

DeclareRepresentation( "IsKaroubiObjectRep",
        IsCapCategoryObject and IsKaroubiObject and IsAttributeStoringRep,
        [ ] );

DeclareRepresentation( "IsKaroubiMorphismRep",
        IsCapCategoryMorphism and IsKaroubiMorphism and IsAttributeStoringRep,
	[ ] );

####################################
#
# families and types:
#
####################################

# new families:
BindGlobal( "TheFamilyOfKaroubiObjects",
        NewFamily( "TheFamilyOfKaroubiObjects" ) );

BindGlobal( "TheFamilyOfKaroubiMorphisms",
        NewFamily( "TheFamilyOfKaroubiMorphisms" ) );

BindGlobal( "TheTypeOfKaroubiObjects",
        NewType( TheFamilyOfKaroubiObjects,
                IsKaroubiObjectRep ) );

BindGlobal( "TheTypeOfKaroubiMorphisms",
        NewType( TheFamilyOfKaroubiMorphisms,
		 IsKaroubiMorphismRep ) );


####################################
##
## Constructors
##
####################################


InstallMethod( Idempotent,
	       [ IsKaroubiObject ],
    function ( obj )
         return ObjectAttributesAsList( obj )[1];
end);

InstallMethod( UnderlyingObject,
	       [ IsKaroubiObject ],
    function ( obj )
        return UnderlyingCell( obj );
end);

InstallMethod( UnderlyingMorphism,
	       [ IsKaroubiMorphism ],
    function ( obj )
        return UnderlyingCell( obj );
end);

# InstallMethod( UnderlyingCategory,
# 	       [ IsKaroubiCategory ],
#     function ( obj )
#         return UnderlyingCell( obj );
# end);

InstallMethod( IsFullObject,
	       [ IsKaroubiObject ],
    function ( obj )
        return Idempotent( obj ) = IdentityMorphism(UnderlyingObject(obj));
end);

##
InstallMethod( KaroubiEnvelope,
               [ IsCapCategory ],
               
  function( category )
    local karoubi_envelope, category_weight_list, structure_record, zero_object, triple, mor_const, obj_const;
    
    if not IsFinalized( category ) then
        Error( "category must be finalized" );
        return;
    fi;

    karoubi_envelope := CreateCapCategory( Concatenation( "Karoubi envelope of ", Name( category ) ) );

    structure_record := rec(
      underlying_category := category,
      category_with_attributes := karoubi_envelope
    );

    structure_record.object_type := TheTypeOfKaroubiObjects;
    structure_record.morphism_type := TheTypeOfKaroubiMorphisms;

    category_weight_list := category!.derivations_weight_list;

    # structure_record.IdentityMorphism := function(obj)
    #     return ObjectAttributesAsList(obj)[1];
    # end);

    if CurrentOperationWeight(category_weight_list, "ZeroObject") < infinity then
       zero_object := ZeroObject ( category );

       structure_record.ZeroObject :=
           function( underlying_zero_object )
	   return [ ZeroMorphism( underlying_zero_object, underlying_zero_object ) ];
      end;
    fi;

    if HasIsAdditiveCategory(category) and IsAdditiveCategory( category ) then
        AddAdditionForMorphisms( karoubi_envelope,
	    function (a, b)
	    #Assert( 4, Source( a ) = Source( b ) and Range( a ) = Range( b ) );
	    return KaroubiMorphism( Source( a ), UnderlyingMorphism( a ) + UnderlyingMorphism( b ), Range( a ) );
        end );

	AddAdditiveInverseForMorphisms( karoubi_envelope,
	    function( a )
	    return KaroubiMorphism( Source( a ), - UnderlyingMorphism, Range ( b ) );
	end );
    fi;


    triple := EnhancementWithAttributes( structure_record );
    obj_const := triple[2];
    mor_const := triple[3];

    InstallMethod( KaroubiObject,
    		   [ IsCapCategoryMorphism ],
        function (idempotent)
	return obj_const(Source(idempotent), [idempotent]);
    end);

    InstallMethod( KaroubiMorphism,
    		   [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ],
        function (a, f, b)
	return mor_const(a, f, b);
    end);

    Finalize( karoubi_envelope );
    return karoubi_envelope;
end );


