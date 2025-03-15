clc
clear
close all
format  shortG


%% 

data=InsertData();

data.W=[0.5 0.5];

nvar=data.nvar;

%% 

NN=150; 

Maxiter=1500;                  
Miniter=250;
iterstop=180;   % for non-improvement condition

Limit=ceil((Maxiter-Miniter)*0.02);


%% 
tic

[Sol,emp]=CreateInitialPopulation(data);

gSol=Sol;   

TL=zeros(nvar,nvar); 

%% 
BEST=zeros(Maxiter,1);
MEAN=zeros(Maxiter,1);

for iter=1:Maxiter
    
    
    BestForbidden=emp;
    BestFree=emp;
    
    for i=1:NN
        
        
        % 
        NewSol=CreateNeighbor(Sol,data);
        
                
        % 
        if TL(NewSol.m(1),NewSol.m(2))>0 
            
            if NewSol.fit>BestForbidden.fit
                BestForbidden=NewSol;
            end
            
        else                             
            
            if NewSol.fit>BestFree.fit
                BestFree=NewSol;
            end
            
        end        
        
    end
        
    % 
    if isempty(BestFree.x) || (BestForbidden.fit>BestFree.fit && BestForbidden.fit>gSol.fit)
        Sol=BestForbidden;
    else
        Sol=BestFree;
    end
    
    
    
    % 
    TL=TL-1;
    TL=max(TL,0);    
    TL(Sol.m(1),Sol.m(2))=Limit;
    TL(Sol.m(2),Sol.m(1))=Limit;

    
    % 
    if Sol.fit>gSol.fit
        gSol=Sol;
    end
    
    
    % 
    BEST(iter)=gSol.fit;
    MEAN(iter)=mean([Sol.fit]);

    disp([' Iter = ' num2str(iter)  ' BEST = ' num2str(BEST(iter))])
    
if iter>Miniter && BEST(iter)==BEST(iter-iterstop)
      break
end
  
end



%% 
disp([ ' Best x = ' num2str(gSol.x)])
disp([ ' Best Fitness = ' num2str(gSol.fit)])
disp([ ' Time = ' num2str(toc)])
BEST=BEST(1:iter);

figure
semilogy(BEST,'vr')
hold on
plot(MEAN,'b') 
xlabel('Iteration')
ylabel('Fitness')
legend('BEST', 'MEAN')
title('Tabu Search')


sol=gSol;
Q=NaN(5*data.nj,5);
Q(1:data.nj,:)=[data.j sol.info.ST sol.info.FT sol.info.MJ sol.info.J1];
xlswrite('out.xlsx',Q,1,'a5');

Q=[ sol.info.OBJ sol.info.dead ];
xlswrite('out.xlsx',Q,1,'a2');

PlotBestSol(sol,data)
