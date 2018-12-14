function [ Pout ] = randomlyRotate( Pin )
	[ ~, ~, R ] = svd( rand( 3 ) );
	if det( R ) < 0
		R = R( :, [ 3 2 1 ] );
	end
	Pout = R * Pin;
end
