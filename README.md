#
# ACS for Clustering Manual
#
## The application of Ant Colony System for clustering problem.

Untuk menjalankan program gunakan file *main.m*. 

*main.m* akan membaca data *Iris.csv* yang akan dikelompokkan menjadi beberapa cluster. 

Beberapa variable awal yang digunakan untuk algoritma ini adalah:
- K = 3, jumlah cluster awal
- nAnts = 10, jumlah semut yang digunakan
- MaxIterations = 3000, jumlah iterasi yang digunakan

Untuk pheromone awal yang digunakan adalah 0.1 dengan **rho** = 0.5. Angka 0.5 digunakan sebagai **rho** berdasarkan beberapa percobaan yang dilakukan. 0.5 memberikan hasil fitness yang cenderung cepat mendekati minimum.

Pada algoritma ini, transition rule yg digunakan adalah 98% *exploitation* dan 2% *exploration*. 
Berikut ini adalah keterangan fungsi-fungsi yang digunakan dalam aloritma ini:

Fungsi `exploitation` digunakan untuk menentukan cluster sebuah sampel berdasarkan konsentrasi *pheromone*. Cluster yang memiliki konsentrasi pheromone tertinggi akan dipilih sebagai cluster dari sampel tersebut. Parameter yang digunakan untuk fungsi ini adalah **tau** dari sampel:
```
> exploitation(tau)
```
Sebagai contoh tau dari S1 adalah berikut:
```
0.0242    0.0033    0.0031
```
Cluster 1 memiliki konsentrasi pheromone paling tinggi yaitu 0.0242. Maka S1 masuk ke dalam cluster pertama.

Fungsi `exploration` digunakan untuk menentukan cluster sebuah sampel berdasarkan kemungkinan pheromone yang sudah dinormalisasi dan variabel acak. Parameter yang digunakan untuk fungsi ini adalah **tau** dari sampel:
```
> exploration(tau)
```
Sebagai contoh, berikut adalah pheromone (tau) dari sampel 1 (S1) yang sudah dinormalisasi terhadap 1:
```
0.3825   0.3695   0.2479
```
Jingka angka yang dibangkitkan <= 0.3825 maka S1 akan masuk ke dalam cluster 1, apabila angka yang dibangkitkan > 0.3825 dan <= 0.752 maka S1 akan masuk ke dalam cluster 2, dan jika angka yang dibangkitkan > 0.752 maka S1 masuk ke dalam cluster 3.

Fungsi `weightMatrix` adalah fungsi yang menentukan kepemilikian cluster. Apabila sebuah sampel masuk ke dalam cluster 1, maka nilainya adalah 1 selain itu nilainya 0. Parameter fungsi ini adalah:
```
> weightMarix(ant,N,K)
%ant = semut yang akan ditentukan weightMatrix-nya
%N = jumlah sampel
%K = jumlah cluster
```
weightMatrix dari S1 menunjukkan bahwa S1 masuk ke dalam cluster 2:
```
0     1     0
```

Fungsi `centerCluster` digunakan untuk menghitung nilai tengah cluster terhadap attribute yang dimiliki sampel. Nilai tengah ini nantinya akan digunakan untuk menghitung nilai **fitness function**:
```
> centerCluster(w,data,n)
%w = weightMatrix dari semut
%data = data iris
%n = jumlah attribute
```

Fungsi `fitness` digunakan untuk menghitung nilai fitness seekor semut. Masing-masing semut menyimpan data cluster setiap sampel. Cluster-cluster yang dihasilkan ini dihitung nilai fitness-nya, semakin kecil nilainya maka semakin besar kemungkinan cluster yang dipilih adalah benar. Nilai fitness ini dihitung menggunakan euclidean distance nilai attribute sampel terhadap nilai tengah cluster yang sudah dihitung sebelumnya. 
```
> fitness(data,ant,N,n,K)
%data = data iris
%ant = semut yang akan dihitung nilai fitness-nya
%N = jumlah sampel
%n = jumlah attribute
%K = jumlah cluster
```

Fungsi `sortAnt` digunakan untuk mengurutkan semut berdasarkan nilai fitness-nya secara *ascending*. Nantinya 20% dari semut yang memiliki nilai tertinggi akan digunakan untuk *local search*.
```
> sortAnt(ants)
%ants = struct semut yang akan diurutkan berdasarkan nilai fitness
```

Fungsi `localSearch` digunakan untuk mencoba solusi yang lebih baik dibandingkan solusi yang sudah ada sekarang. 20% dari semut yang sudah memiliki nilai fitness tertinggi akan dicoba dimasukkan ke dalam cluster baru secara acak. Kemudian, nilai fitness yang baru dihitung. Apabila nilai fitness yang baru lebih kecil dibanding nilai fitness yang sebelumnya, maka solusi akan menggunakan cluster baru yang dipilih secara acak tersebut.
```
> localSearch(ants, N, K, percentage, p, data)
```

Fungsi `randomCluster` digunakan untuk menentukan cluster secara acak dalam pencarian solusi yang lebih baik *local search*:
```
> randomCluster(currentCluster, K)
%currentCluster = cluster yang dipilih saat ini
%K = jumlah cluster
```

Fungsi `topIndices` digunakan untuk mendapatkan index semut yang memiliki nilai fitness tertinggi:
```
> topIndices(percentage, n)
%percentage = persentase jumlah semut
%n = jumlah semut
```

Setelah melakukan *local search*, maka dilakukan *update pheromone trail* yang fungsinya untuk mengupdate semua nilai pheromone matrix menggunakan fitness function dari 20% semut yang memiliki nilai fitness tertinggi. 
```
    for k=1:size(topAnts,1)
	    for i=1:N
	        for j=1:K
	            if topAnts(k).S(i) == j
	                tau(i,j) = ((1-rho) * tau(i,j)) + (1/topAnts(k).fitness);
            end
        end            
    end 
```

Setelah melakukan beberapa percobaan, didapatkan hasil nilai fitness minimum = **78.9408**.

![alt text](https://raw.githubusercontent.com/nettys/ACS-for-Clustering/master/bestFitness.png "Best Fitness")

Berikut ini adalah grafik performa dari 3000 iterasi yang dilakukan:

![alt text](https://raw.githubusercontent.com/nettys/ACS-for-Clustering/master/Performance.png "Performance")

Jika dilihat dari grafik di atas, nilai fitness sudah menyentuh angka di bawah seratus saat sudah berada pada iterasi sekitar 1000.
Dengan menggunakan syntax berikut ini:
```
> find(bestFitnesses == min(bestFitnesses))
```
nilai fitness = 78.9408 didapat pada iterasi ke 1056.

Berikut ini adalah hasil plotting cluster yang dilakukan menggunakan 3 variabel:

![alt text](https://raw.githubusercontent.com/nettys/ACS-for-Clustering/master/Plot.png "Plotting")