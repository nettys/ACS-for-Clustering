clear;
%data = [5.1 3.5 1.4 0.2; 4.9 3 1.4 0.2; 4.7 3.2 1.3 0.2; 4.6 3.1 1.5 0.2; 5 3.6 1.4 0.2; 5.4 3.9 1.7 0.4; 4.6 3.4 1.4 0.3; 5 3.4 1.5 0.2; ];
data = csvread('Iris.csv',1);
%data = csvread('Wine.csv');

[N, n] = size(data);

K = 3; %Jumlah cluster
nAnts = 10;
MaxIterations = 3000;

tau0 = 0.01;
tau = tau0 * ones(N, K); %pheromone matrix
rho = 0.5;
percentage = 20;

%Ant
ant.S = [];
ant.w = zeros(N,K);
ant.m = zeros(K,n);
ant.fitness = [];
ants = repmat(ant, nAnts, 1);
topAnts = repmat(ant, ceil(percentage * nAnts /100),1);
topFitness = zeros(ceil(percentage * nAnts /100),1);

bestSolution = repmat(ants, MaxIterations,1);
bestFitnesses = zeros(MaxIterations,1);

q0 = 0.98;

for t=1:MaxIterations    
    for k=1:nAnts
        q = rand(N, 1);       
        ants(k).S = 1000;
        for i=1:N
            if q(i) < q0 %exploitation               
                cluster = exploitation(tau(i,:));
                ants(k).S = [ants(k).S cluster];                
            else %exploration
                cluster = exploration(tau(i,:));
                ants(k).S = [ants(k).S cluster];                
            end
        end
        
        ants(k).S(1) = [];       
        ants(k).w = weightMatrix(ants(k),N,K);        
        ants(k).m = centerCluster(ants(k).w, data, n);
        ants(k).fitness = fitness(data,ants(k),N,n,K);        
        
    end
    
    %LOCAL SEARCH
    
    sortedAnts = sortAnt(ants);  
%     for k=1:nAnts
%         disp(['Ants(k): ' num2str(k) ' S: ' num2str(sortedAnts(k).S) ' Fitness: ' num2str(sortedAnts(k).fitness)]);
%     end
    sortedAnts = localSearch(sortedAnts,N,K,percentage,0.01,data);
    
    
    ants = sortAnt(sortedAnts);
%     for k=1:nAnts
%         disp(['Ants(k): ' num2str(k) ' S: ' num2str(sortedAnts(k).S) ' Fitness: ' num2str(sortedAnts(k).fitness)]);
%     end
    
    %UPDATE PHEROMONE TRAILS
    topAntsIndex = topIndices(percentage, nAnts);
    topAnts = ants(topAntsIndex);
    %topAnts = ants(1:(ceil(percentage*N/100)));
    
    for k=1:size(topAnts,1)
        for i=1:N
            for j=1:K
                if topAnts(k).S(i) == j
                    tau(i,j) = ((1-rho) * tau(i,j)) + (1/topAnts(k).fitness);
                end
            end            
        end        
    end
    
    bestSolution(t) = ants(1);
    bestFitnesses(t) = ants(1).fitness;
    %disp(['Iteration: ' num2str(t) ' Best Ants - S: ' num2str(bestSolution(t).S) ' Fitness: ' num2str(bestSolution(t).fitness)]);
    disp(['Iteration: ' num2str(t) ' Best Ants - Fitness: ' num2str(bestSolution(t).fitness)]);
end

figure(1);
plot(bestFitnesses, 'LineWidth', 2);
xlabel('Number of Iterations');
ylabel('Best Cost');
grid on;

minFit = min(bestFitnesses);
minIdx = find(bestFitnesses == minFit);
minIdx = minIdx(1);
s = bestSolution(minIdx);
figure;
for i = 1:K
   idx = find(s.w(:,i));
   scatter3( data(idx,1) , data(idx,2) , data(idx,3) ); 
   hold on;
end 
hold off;