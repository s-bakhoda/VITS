function sol=fitness(sol,data)

%%



p=data.p ;
r=data.r ;
d=data.d ;
ben=data.ben ;
s=data.s;

vm=data.vm ;
cm=data.cm ;

Mach=data.Mach ;

nm=data.nm ;
nj=data.nj ;

%% 
x=sol.x;

%% 
a=x;
for v=1:nm-1
    b=find(a>nj);
    b=b(1);
    m=a(b)-nj;
    C=a(1:b-1);
    a(1:b)=[];
    Mach(m).C=C;
end

Mach(nm).C=a;

%% 

% ST=zeros(nj,1);
% FT=zeros(nj,1);
% MJ=zeros(nj,1);
% 
% for m=1:nm
%     C=Mach(m).C;
%     if isempty(C)
%         continue
%     end
%     
% for j=C
%     
%     rj=r(j);
%     pt=p(j).*vm(m);
%     
%     t1=rj;
%     t2=Mach(m).t;
% 
%     st=max(t1,t2);
%     ft=st+pt;
%     
%     ST(j)=st;
%     FT(j)=ft;
%     MJ(j)=m;
%     
%     
%     Mach(m).t=ft;
%     
% 
% end
% 
%     
% end


ST=zeros(nj,1);
FT=zeros(nj,1);
MJ=zeros(nj,1);
PT=zeros(nj,1);
PCC=zeros(nj,1);
% DELAY=zeros(nj,1);
% DP=zeros(nj,1);
% MDP=zeros(nj,1);
% % pdp=0.2;

for m=1:nm
    C=Mach(m).C;
    if isempty(C)
        continue
    end
    
for j=C
    
    rj=r(j);
    sj=s(j);
    pt=p(j).*vm(m);
    pcc=pt.*cm(m);
    
    t1=rj;
    t2=Mach(m).t;

    st=(max(t1,t2)) + (sj);
    ft=st+pt;
%     delay=ft-d;
% %     dp=delay.*pdp.*ben;
%     dp=delay.*ben.*(0.2);
    
    ST(j)=st;
    FT(j)=ft;
    MJ(j)=m;
    PT(j)=pt;
    PCC(j)=pcc;
%     DELAY(j)=delay;
%     DP(j)=dp;
%     MDP(j)= min(ben,dp);
     
    Mach(m).t=ft;
    

end

    
end




%% Cal CH

Jok=find(FT<=d);
Jno=find(FT>d);


%% Cal SCH


% OBJ(1)=sum(ben(Jok));
% 
% OBJ(2)=numel(Jok);
% 
% dead=numel(Jno);




% OBJ(1)=sum(ben(Jok));
% OBJ(1)=sum(ben(Jok)-PCC(Jok));
% OBJ(1)=sum(ben(Jok)) -  sum (PCC(Jok));
OBJ(1)=sum(ben(Jok)) -  sum (PCC(Jok));
% OBJ(1)=sum(ben) - sum(PCC) - sum(MDP(Jno)) ;
% OBJ(1)=sum(ben) - sum(PCC) ;
% OBJ(1)=sum(ben(Jok))+ sum(ben(Jno)) - sum(PCC(Jok)) + sum(PCC(Jno))- sum(DP(Jno)) ;
% OBJ(1)=sum(ben(Jok))+ sum(ben(Jno)) - sum(PCC(Jok)) + sum(PCC(Jno));

% OBJ(1)=sum(ben(Jok)- PCC(Jok))  +  sum( ben(Jno) - PCC(Jno) - ( min ( (FT(Jno)-d(Jno)) .* (0.1) .* (ben(Jno)) , (ben(Jno)) )) );

%%%%%%%
% OBJ(1)=sum(ben(Jok)- PCC(Jok))  +  sum( ben(Jno) - PCC(Jno) -  min ( (FT(Jno)-d(Jno)) .* (0.05) .* (ben(Jno)) , ben(Jno) ) );
%%%%%%%

% OBJ(1)=sum(ben(Jok)- PCC(Jok))  +  sum( ben(Jno) - PCC(Jno) - ( ( (FT(Jno)-d(Jno)) .* (0.05) .* (ben(Jno)) ) ));
% % (max(  (FT(Jno)-d(Jno))  , 0 ))
% OBJ(1)=sum(ben(Jok)- PCC(Jok))  +  sum( ben(Jno) - PCC(Jno) - ( ( (max(  (FT(Jno)-d(Jno))  , 0 ))  .* (0.1) .* (ben(Jno)) ) ));
% OBJ(1)=sum(ben(Jok)- PCC(Jok))  +  sum( ben(Jno) - PCC(Jno) );

% OBJ(1)=sum(ben(Jok))- sum(PCC(Jok))  +  sum( ben(Jno)) - sum(PCC(Jno)) -  min ( (FT(Jno)-d(Jno)) .* (0.05) .* (ben(Jno)) , (ben(Jno)) ) ;
% OBJ(1)=sum(ben(Jok)- PCC(Jok))  +  sum(ben(Jno) - PCC(Jno)) - ( min ( (FT(Jno)-d(Jno)) .* (0.05) .* (ben(Jno)) , (ben(Jno)) ));

OBJ(2)=numel(Jok);

dead=numel(Jno);

%% Cal OBJ

fit=sum(OBJ.*data.W);

J1=zeros(nj,1);
J1(Jok)=1;



sol.fit=fit;
sol.info.dead=dead;
sol.info.x=x;
sol.info.Mach=Mach;
sol.info.OBJ=OBJ;
sol.info.Jok=Jok;
sol.info.Jno=Jno;
sol.info.J1=J1;
sol.info.ST=ST;
sol.info.FT=FT;
sol.info.MJ=MJ;
sol.info.Realfit=OBJ(1);

end