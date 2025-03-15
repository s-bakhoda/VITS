function data=InsertData()



vm=[0.7 0.8 0.85 0.9 1 1.1 1.15 1.2 1.3 1.4];  %10

cm=[0.48 0.57 0.62 0.51 0.65 0.59 0.66 0.67 0.75 0.82];



% vm=[0.7 0.8 0.9 1 1.1 1.2 1.3 1.4     %16
%     0.7 0.8 0.9 1 1.1 1.2 1.3 1.4]; 

% cm=[0.48 0.57 0.51 0.65 0.59 0.67 0.75 0.82
%     0.48 0.57 0.51 0.65 0.59 0.67 0.75 0.82];



a=xlsread('data.xlsx',1);

nm=numel(vm);

j=a(:,1);   %
p=a(:,2);   %
r=a(:,3);   %
d=a(:,4);   %
ben=a(:,5); %
s=a(:,6);   %

nj=numel(p);

nvar=nj+nm-1;

% pdp=0.2;


emp.C=[];
emp.t=0;
Mach=repmat(emp,nm,1);

save data
data=load('data.mat');


 end