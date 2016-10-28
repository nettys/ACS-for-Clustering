function f = fitness(data,ant,N,n,K)
    f=0;
    for i=1:K
      d = zeros(1,n);
      tempf = 0;
      for j=1:N
          d = (data(j,:) - ant.m(i,:)).^2;
          tempf = sum(d);
          %tempf = sqrt(tempf);
          tempf = tempf * ant.w(j,i);

          f = f + tempf;
      end
    end
end