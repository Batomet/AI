close all 
clear
%tworzenie macierzy z poszczegolnymi literkami
A = [ 
-1,1,1,1,-1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,1,1,1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
];



B = [
1,1,1,1,-1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,1,1,1,-1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,1,1,1,-1;
];



C = [
1,1,1,1,1;
1,-1,-1,-1,-1;
1,-1,-1,-1,-1;
1,-1,-1,-1,-1;
1,-1,-1,-1,-1;
1,-1,-1,-1,-1;
1,1,1,1,1;
];



D = [
1,1,1,1,-1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,1,1,1,-1;
];


figure(1)  
hintonw(A) 
figure(2)
hintonw(B)
figure(3)
hintonw(C)
figure(4)
hintonw(D)

%przekształcanie na macierze kolumnowe
A = reshape(A,35,1);
B = reshape(B,35,1);
C = reshape(C,35,1);
D = reshape(D,35,1);


P = [A,B,C,D]; %"wkładam" gotowe macierze do macierzy P
whos


figure(5)
hintonw(P)

T = eye(4,4);



figure(6)
hintonw(T)

net = newp(P, T, 'hardlim', 'learnp');
disp('Rozmiary macierzy wag: ') 
disp(net.IW)
disp('Zawartość macierzy wag: ') 
disp(net.IW{1})
disp('Rozmiar wektora wsp. progowych: ') 
disp(net.b)
disp('Zawartość wektora wsp. progowych: ') 
disp(net.b{1})


net.trainParam.epochs = 100;
[net,tr] = train(net,P, T);
[Y] = sim(net,P);

% tworzenie plotów z odpowiedziami sieci na literki
for i = 1:4
    figure(6+i)
    subplot(1,2,1)
    hintonw(reshape(P(:,i),7,5))
    subplot(1,2,2)
    hintonw(Y(:,i))
    pause(2)
end


% na ocene db, zrobienie macierzy z przekłamaniami

%tworzenie nowych macierzy z zakłamaniami
%w każdej macierzy występuje 1 zakłamanie

A1 = [ 
-1,1,1,1,-1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,1,-1,1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
];
B1 = [
1,1,1,1,-1;
1,-1,-1,-1,1;
1,1,-1,-1,1;
1,1,1,1,-1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,1,1,1,-1;
];
C1 = [
-1,1,1,1,1;
1,-1,-1,-1,-1;
1,-1,-1,-1,-1;
1,-1,-1,-1,-1;
1,-1,-1,-1,-1;
1,-1,-1,-1,-1;
1,1,1,1,1;
];
D1 = [
1,1,1,1,-1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,1;
1,-1,-1,-1,-1;
1,1,1,1,-1;
];

%przekształcanie na macierze kolumnowe
A1 = reshape(A1,35,1);
B1 = reshape(B1,35,1);
C1 = reshape(C1,35,1);
D1 = reshape(D1,35,1);

%do jednej macierzy
PT = [A1,B1,C1,D1];
[Y] = sim(net,PT);
% tworzenie plotów z odpowiedziami sieci na literki
for i = 1:4
    figure(10+i)
    subplot(1,2,1)
    hintonw(reshape(PT(:,i),7,5))
    subplot(1,2,2)
    hintonw(Y(:,i))
    pause(2)
end

a = 14;
index = 1;
los(1,:) = randperm(35,28); %losuje j liczb z zakresu 1:35 
%powtorz 7 razy
for j = 1:7 %ile wylosowanych liczb
    for i = 1:4 %kolumny
       %tutaj tworze zaklamania do mac. PT
        if PT(los(index),i) == 1
            PT(los(index),i) = -1;
        elseif(PT(los(index),i) == -1)
            PT(los(index),i) = 1;
        end 

        [Y] = sim(net,PT);
        figure(a=a+1);
        subplot(1,2,1);
        hintonw(reshape(PT(:,i),7,5));
        subplot(1,2,2);
        hintonw(Y(:,i)); 
      
    end
end
