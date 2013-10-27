function [valor] = calcValorPolitica(politica,T,R,gamma,sigma,bInit)
	
    nS = size(T{1},1);
    nA = size(T,1);
	Tpi = zeros(nS);
	for a=1:nA
		piA = politica(:,a)'*sigma;
		piA = repmat(piA',1,nS);
		Tpi = Tpi + T{a}(:,:).*piA;
	end
	piV = (eye(nS)-gamma*Tpi)\R';
	valor = bInit'*piV;
end
