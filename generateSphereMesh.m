function [ P, tri ] = generateSphereMesh( generation, type )
	if strcmp( type, 'tet' ) % starts with tetrahedron
		[ P, tri ] = getTetrahedralMesh();
	elseif strcmp( type, 'oct' ) % starts with octahedron
		[ P, tri ] = getOctahedralMesh();
	elseif strcmp( type, 'ico' ) % starts with icosahedron
		[ P, tri ] = getIcosahedralMesh();
	else
		fprintf( 'Error: Unrecognized polyhedron type. \n' );
		P = eye( 3 );
		tri = [ 1 2 3 ];
	end

	for n = 1:generation
		[ P, tri ] = refineMesh( P, tri );
	end
end
