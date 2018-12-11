% Transfers the right- or left-handed sense of a mesh element to its computed children.

function [ P, tri ] = refineMesh( Pin, triin )
	
	N = size( Pin, 2 );
	
	edges_1 = [ triin(:,1:2) ; triin(:,2:3) ; triin(:,[3 1]) ];
	edges_s1 = [ min( edges_1, [], 2 ) max( edges_1, [], 2 ) ];

	edges_2 = [ triin(:,2:3) ; triin(:,[3 1]) ; triin(:,1:2) ];
	edges_s2 = [ min( edges_2, [], 2 ) max( edges_2, [], 2 ) ];

	edges_3 = [ triin(:,[3 1]) ; triin(:,1:2) ; triin(:,2:3) ];
	edges_s3 = [ min( edges_3, [], 2 ) max( edges_3, [], 2 ) ];
	
	edges_unique = unique( edges_s1, 'rows' );

	Pnew = Pin( :, edges_unique(:,1) ) + Pin( :, edges_unique(:,2) ); % these are the new vertices
	Pnew = Pnew ./ repmat( sqrt( sum( Pnew.^2 ) ), 3, 1 );

	[ ~, idx1 ] = ismember( edges_s1, edges_unique, 'rows' );
	[ ~, idx2 ] = ismember( edges_s2, edges_unique, 'rows' );
	[ ~, idx3 ] = ismember( edges_s3, edges_unique, 'rows' );

	tri = [ ...
		edges_1(:,1)  ...
		N + idx1 ...
		N + idx3 ...
	];
	sz = numel( idx1 ) / 3;
	tri = [ tri ; N + [ idx1(1:sz) idx2(1:sz) idx3(1:sz) ] ];

	P = [ Pin Pnew ];

end
