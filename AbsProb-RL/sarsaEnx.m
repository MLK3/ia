%goals = 16;
aaMontaAbsorveAbstrato;

% bInit = zeros(nState,1);
% bInit(1) = 1;
runs = 1;

iteration = 100000;
%stepIncrement = 50;

Vm = zeros(iteration,1);

for r=runs
    piCurrent = rand(nAbstract,nAction);
    for i=1:nAbstract
        piCurrent(i,:) = piCurrent(i,:)/sum(piCurrent(i,:));
        piCurrent(i,:) = epsilon/nAction + (1-epsilon)*piCurrent(i,:);
    end

    Wadapt = zeros(nAction,nAbstract);
    
    step = initialStep;

    V = zeros(iteration,1);
    currentValue = 0;
	count = 0;

    for i=1:iteration

        E = zeros(nAction,nAbstract);

        [aux s] = max(cumsum(bInit)>rand);

        Wlocal = zeros(nAction,nAbstract);

        for t=0:500
            if (s==nState)
                break;
            end

            sAbs = find(sigma(:,s));

            [aux a] = max(cumsum(piCurrent(sAbs,:))>rand);

            E(a,sAbs) = E(a,sAbs) + 1/piCurrent(sAbs,a);
            E(:,sAbs) = E(:,sAbs) - 1;

            [aux nextS] = max(cumsum(T(s,:,a))>rand);

            s = nextS;

            Wlocal = Wlocal + (gamma^t)*R(s)*E;

        end
        
		count = count + 1;
        alpha = 1/i;
        Wadapt = Wadapt + alpha*(Wlocal-Wadapt);


        if mod(count,step) == 0 || i == iteration
			count = 0;
            step = step + stepIncrement;


            piBest = zeros(nAbstract,nAction);
            matrixW = Wadapt';
            for sAux=1:nAbstract
                [aux aStar] = max(matrixW(sAux,:));  %Passo 2e
                piBest(sAux,:) = epsilon/nAction;
                piBest(sAux,aStar) = piBest(sAux,aStar) + (1-epsilon);
            end

            delta = 0.05;
            piCurrent = (1-delta)*piCurrent + delta*piBest;


            Tpi = zeros(nState);
            for iA=1:nAction
                piA = piCurrent(:,iA)'*sigma;
                piA = repmat(piA',1,nState);
                Tpi = Tpi + T(:,:,iA).*piA;
            end

            piV = (eye(nState)-gamma*Tpi)\R';  %Passo 2a
            currentValue = bInit'*piV;

            disp(['Current value: ' num2str(currentValue)]);
            disp([num2str(100*i/iteration) ' % elapsed']);
        end

        V(i) = currentValue;  
        

    end  
    k = r-min(runs)+1;
    Vm = Vm + (V - Vm)/k;
    %save(['step' int2str(initialStep) '+' int2str(stepIncrement) '_alphai_g' int2str(goals) '_r' int2str(r)], 'V', 'piCurrent');
end

%save(['step' int2str(initialStep) '+' int2str(stepIncrement) 'm_alphai_g' int2str(goals)], 'Vm');
