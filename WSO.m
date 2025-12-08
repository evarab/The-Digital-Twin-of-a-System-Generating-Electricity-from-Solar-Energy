%%       Dr.Tummala.S.L.V.Ayyarao
%% https://scholar.google.co.in/citations?user=X7i25FAAAAAJ&hl=en&oi=sra
%% GMR Institute of Technology, India
%% Ayyarao, TummalaS LV, N. S. S. RamaKrishna, Rajvikram Madurai Elavarasam, Nishanth Polumahanthi, M. Rambabu, Gaurav Saini, Baseem Khan, and Bilal Alatas. "War Strategy Optimization Algorithm: A New Effective Metaheuristic Algorithm for Global Optimization." IEEE Access (2022).
%% https://ieeexplore.ieee.org/abstract/document/9718247
%% Code developed by Tummala.S.L.V.Ayyarao
%% Ayyarao, Tummala SLV, and Polamarasetty P. Kumar. "Parameter estimation of solar PV models with a new proposed war strategy optimization algorithm." International Journal of Energy Research (2022).
%% https://onlinelibrary.wiley.com/doi/abs/10.1002/er.7629
%% Improved version of the code will be updated soon
function [King_fit,King,Convergence_curve]=WSO(Soldiers_no,Max_iter,lb,ub,dim,fobj)
% global W1 fitness_history position_history  Trajectories l
% fitness_history=zeros(Soldiers_no,Max_iter);
% position_history=zeros(Soldiers_no,Max_iter,dim);
% initialize alpha, beta, and delta_pos

King=zeros(1,dim);
King_fit=inf;
Positions=initialization(Soldiers_no,dim,ub,lb);
pop_size=size(Positions,1);Convergence_curve=zeros(1,Max_iter);

Positions_new=zeros(size(Positions));
fitness_old=inf*ones(1,pop_size);
fitness_new=inf*ones(1,pop_size);
l=1;% Loop counter
W1=1.5*ones(1,pop_size);

Wg=zeros(1,pop_size);


Trajectories=zeros(Soldiers_no,Max_iter);
% Main loop
R=0.8;
for  j=1:size(Positions,1)
         fitness=fobj(Positions(j,:));
         fitness_old(j)=fitness;

        if fitness<King_fit
            King_fit=fitness;
            King=Positions(j,:);
        end
        
end
 
while l<Max_iter
%     l
[~,tindex]=sort(fitness_old);
Co=Positions(tindex(2),:);
  
  iter =l;
   com=randperm(pop_size);  
    for i=1:pop_size
        RR=rand;
        if RR<R

             D_V(i,:)=2*RR*(King-Positions(com(i),:))+1*W1(i)*rand*(Co-Positions(i,:)); 
        else
            D_V(i,:)=2*RR*(Co-King)+1*rand*(W1(i)*King-Positions(i,:)); 
        end
            

            Positions_new(i,:)=Positions(i,:)+D_V(i,:);
            Flag4ub=Positions_new(i,:)>ub;
        
            Flag4lb=Positions_new(i,:)<lb;
        
            Positions_new(i,:)=(Positions_new(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;  
            fitness=fobj(Positions_new(i,:));
            fitness_new(i) = fitness;

        if fitness<King_fit
            King_fit=fitness;
            King=Positions_new(i,:);
        end
%         Co

        if fitness<fitness_old(i)
            Positions(i,:)=Positions_new(i,:);
            fitness_old(i)=fitness;
%         else
            Wg(i)=Wg(i)+1;
            W1(i)=1*W1(i)*(1-Wg(i)/Max_iter)^2;

        end
%         [~,tindex1]=max(fitness_old);
%         Positions(tindex1,:)=lb+rand*(ub-lb);
%         W1(tindex1)=0.5;

              
    end
    if l<1000
        [~,tindex1]=max(fitness_old);
        Positions(tindex1,:)=lb+rand*(ub-lb);

    end

    l=l+1;    
    Convergence_curve(l)=King_fit;
end



