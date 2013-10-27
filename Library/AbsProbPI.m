function [piCurrent,currentValue] = AbsProbPI(nState,nAbstract,nAction,T,R,sigma,bInit,gamma)

    epsilon = 0.1;
    minIncremento = 0.0005;
            
    piCurrent = rand(nAbstract,nAction);
    for i=1:nAbstract
        piCurrent(i,:) = piCurrent(i,:)/sum(piCurrent(i,:));
        piCurrent(i,:) = epsilon/nAction + (1-epsilon)*piCurrent(i,:);
    end

    %piCurrent = 1/nAction*ones(nAbstract,nAction);
    
    Trand = zeros(nState,nState);
    for a=1:nAction
        Trand = Trand + T{a}(:,:)/nAction;
    end

    Tepsilon = cell(nAction,1);
    for a=1:nAction
		Tepsilon{a} = sparse(nState,nState);
        Tepsilon{a}(:,:) = epsilon*Trand + (1-epsilon)*T{a}(:,:);
    end
    
    Rinv = R';

    for iteration=1:100

        Tpi = zeros(nState);
        for i=1:nAction
            piA = piCurrent(:,i)'*sigma;
            piA = repmat(piA',1,nState);
            Tpi = Tpi + T{i}(:,:).*piA;
        end

        piV = (eye(nState)-gamma*Tpi)\Rinv;  %Passo 2a
        currentValue = bInit'*piV;

        disp([iteration currentValue]);

        %piG = (eye(nState)-gamma*Tpi + gamma*ones(nState,1)*steady')\R';
        bC = bInit'/(eye(nState)-gamma*Tpi);  %Passo 2b
        matrixW = zeros(nAbstract,nAction);
        for i=1:nAction
            Qg = (Tepsilon{i}(:,:)-Tpi)*piV;  %Passo 2c
            matrixW(:,i) = sigma*(bC'.*Qg);  %Passo 2d
        end


        %1) Fixed Step Global
        piBest = zeros(nAbstract,nAction);
        for i=1:nAbstract
			[a aStar] = max(matrixW(i,:));  %Passo 2e
			piBest(i,:) = epsilon/nAction;
			piBest(i,aStar) = piBest(i,aStar) + (1-epsilon);
        end

        delta = 1/(1+iteration/1); %Decreasing delta
        piNext = (1-delta)*piCurrent + delta*piBest;
        Tpi = zeros(nState);
        for i=1:nAction
            piA = piNext(:,i)'*sigma;
            piA = repmat(piA',1,nState);
            Tpi = Tpi + T{i}(:,:).*piA;
        end
        piV = (eye(nState)-gamma*Tpi)\Rinv;
        nextValue = bInit'*piV;    
        piCurrent = piNext;
        if (nextValue - currentValue < minIncremento) 
            break;
        end
    end

    piCurrent(sum(sigma,2)<=0,:) = 1/nAction;
    currentValue = nextValue;
    % piCurrent(sum(sigma,2)>0,:)
    % find((sum(sigma,2)>0))
end
