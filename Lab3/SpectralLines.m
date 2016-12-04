clear all; close all; clc;  

x = linspace(0,pi); %one period of the function
 y = exp(-x/2); %given function
 x1 = linspace(-3*pi,3*pi, 600);%repeating the function to show periodicity
 %plotting the given function
 figure;
 subplot(5,1,1);
 plot(x1/pi, [y, y, y, y, y, y]); %showing six periods
 grid; xlabel('t/pi'); ylabel('y(t)'); title('exp(-t/2)');
 n = 1:10;
 a_n(1) = 0.504; a_n(n+1)=1.008./(1+16*n.^2); %cosine terms
 b_n(1) = 0; b_n(n+1)=0.504*8*n./(1+16*n.^2); %sine terms
C_n(1) = a_n(1); C_n(n+1) = sqrt(a_n(n+1).^2+b_n(n+1).^2);%spectral amplitude
theta_n(1) = 0; theta_n(n+1) = atan2(-b_n(n+1), a_n(n+1));%phase
n = [0,n];

subplot(5,1,2); stem(n, a_n); ylabel('a_n'); xlabel('n'); %plot cosine terms
subplot(5,1,3); stem(n, b_n); ylabel('b_n'); xlabel('n');%plot sine terms
subplot(5,1,4); stem(n, C_n); ylabel('C_n'); xlabel('n');%plot spectral amplitude
subplot(5,1,5); stem(n, theta_n); ylabel('\theta_n [rad]'); xlabel('n');%plot phase