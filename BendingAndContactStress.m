%paremeters
phi = 25 ;%pressure angle in degrees
w=8848.56 ;%angular velocity
mG= sqrt(19) ; %gear ratio for each stage
m= 2;%module
Dp=m*mG;%diameter
W=37.24; %force
Qv=11 ;%assumed value
b= 15*m ;%face width
F = b / 25.4;   % Face width in inches

%Wear

%calculation of geometric factor
I=((cosd(phi)*sind(phi))/2)*(mG/(mG+1)) ;

%calculation of Kv
V = w * Dp/2;         % mm/s
V = V / 1000;         % m/s

B = 0.25 * (12 - Qv)^(2/3);
A = 50 + 56 * (1 - B);
Vmax = ((A + (Qv - 3))^2) / (200);  % m/s;

if V > Vmax
    fprintf("Vmax exceeded\n")
    return;
end

Kv  = ((A + sqrt(200*V))/A)^B;

%calculation of Cpf
if F < 1
    Cpf = b/(10*Dp) - 0.025;
elseif F < 17
    Cpf = b / (10*Dp) - 0.0375 + 0.0125 * F;
elseif F<40
    Cpf = b / (10*Dp) - 0.1109 + 0.0207 * F - 0.000228 * F^2 ;
end

%Assumptions
Cmc = 1 ; %uncrowned
Cpm = 1 ; %located close to the center
Ce = 1 ;
Cp = 191 ;
Kr = 1 ;
Kt = 1 ;
Ch = 1 ;
Ko = 1 ;
Ks = 1 ;
Cf = 1 ;

%Calculation of Cma
Z = 0.0675;
Y = 0.0128;
X = -1*0.926*10^(-4);

Cma = Z + Y * F + X * F^2 ;

Km = 1 + Cmc * (Cpf * Cpm + Cma * Ce); %calculation of Km
Ec = Cp * sqrt(W*Ko*Kv*Ks*Km/(Dp*b*I));

L = 12000*60*w ;%12000hour assumed for long life 
Zn = 1.4488*(L)^(-0.023); %from figure 14-15

Sh= 1.2 ;%factor of safety
Sc= (Sh*Ec)/Zn ; 
fprintf('strenght need to be achived %f',Sc);

Sc= ;%detirmine from table according the above calculation
nc=(Sc*Zn)/Ec ;%factor of safety

%Bending

J =;
Eb = Wt * Ko * Kv * Ks * Km * Kb / (b * m * J); %bending stress
YN = 1.3558 * NCycle^(-0.0178);
St= ;
Eall= St*YN ;
n= Eall/Eb ; % factor of safety