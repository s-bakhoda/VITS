function [pop,emp]=CreateInitialPopulation(data)


nvar=data.nvar ;
npop=1 ;

emp.x=[];
emp.fit=-inf;
emp.info=[];


pop=repmat(emp,npop,1);

for i=1:npop
pop(i).x=randperm(nvar);
pop(i)=fitness(pop(i),data);
end


end


