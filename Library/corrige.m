dir = '~/Documents/Mestrado/Exp1/';
load([dir 'politicas_Ordem1']);

for i=2:size(L,2)    
    for t=1:4
        for r=1:10
            for j=2:size(L(i).Names,2)
                load([dir L(i).Names{1,1} '_t' int2str(t) '_r' int2str(r)]);
                nome = [dir L(i).Names{1,j} '_t' int2str(t) '_r' int2str(r)];
                disp(nome);
                save(nome, 'W', 'Wgain', 'Wreal', 'PiUse');
            end
        end                
    end
end