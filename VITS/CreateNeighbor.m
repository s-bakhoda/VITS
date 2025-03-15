function NewSol=CreateNeighbor(Sol,data)



x=Sol.x;

n=data.nvar;
i=randsample(n,2);

i1=min(i);
i2=max(i);

R=randi([1 2]);


switch R
    
    case 1
        x=Swap(x,i1,i2);
        
    case 2
        x=Reversion(x,i1,i2);
end


NewSol.x=x;
NewSol.m=[i1 i2];
NewSol=fitness(NewSol,data);


end


function y=Swap(x,i1,i2)



y=x;
y([i1 i2])=x([i2 i1]);

end

function y=Reversion(x,i1,i2)




y=x;
y(i1:i2)=x(i2:-1:i1);

end
