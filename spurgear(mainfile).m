clear
clc
lewis_table = [0.289, 0.295, 0.302, 0.308, 0.314, 0.320, 0.326, 0.330, 0.333, 0.337, 0.340, 0.344, 0.348, 0.352, 0.355, 0.358, 0.364];

np = input("Enter rotaion speed (rpm) -");

zp = input("Enter no. of teeth in pinion/0 to continue -");
if zp == 0
    pressureangle = input("Enter the pressure angle (degrees) -");
    % minimum teeth taken from table
    if pressureangle == 20
        zp = 18;
    elseif pressureangle == 25
        zp = 11;
    else
        zp = 32;
    end
    speedratio = input("Enter speed ratio -");
    zg = speedratio * zp;
else
    zg = input("Enter number of teeth in gear -");
end
Y = lewis_table(zp - 14); % lewis form factor 

Sut = input("Enter ultimate tensile strength -");
fs = input("Enter factor of safety -");

Cs = input("Enter service factor/0 to continue -");
if Cs == 0
    Cs = input("Enter starting torque percentage to rated torque -") / 100;
end

Q = f_ratio(zg, zp); %f_ratio gives factor ratio

promt = "do you want to calculate the dimensions of gear? (0-No / 1-Yes) -";
if input(promt)
    kw = input("Enter the rated power in kilo watts -");
    
    Mt = transmittedtorque(kw, np, 0, 0);
    v = 5; 
    Cv = velocityfactor(v);
    bm = 10; 
    m = modulecalc(kw, Cs, fs, zp, np, Cv, bm, Sut, Y);
    m = ceil(m);
    
    [fs, Cv, Pef] = moduleassessment(m, zp, zg, m * bm, Mt, np, Cs, Sut, Y); 
    
    while fs < fs
        m = m + 1;
    end
    
    dp = m * zp;
    Pt = tangentialforce(Mt, dp, 0, 0, 0, 0); %tangential force
    BHN = s_hardness(Pef, fs, m * bm, Q, dp); % surface gardness
    
    
    fprintf("Transmitted torque - %dN-mm\n", Mt)
    fprintf("Trial value of pitch line velocity assumed to be 5m/s\n");
    fprintf("Module comes to be %dmm\n\n", m)
    
    fprintf("Factor of safety for module = %dmm, comes to be %d\n", m, fs)
    fprintf("Factor of safety is greater than required\n\n")
    fprintf("Surface hardness for gears-\n")
    fprintf("Surface hardness of gears is %dBHN\n", BHN)
    
else
    BHN = input("Enter surface hardness(BHN) -");
    m = input("Enter module(mm) -");
    b = input("Enter face width(mm) -");
    
    Sb = beamstrength(m, b, Sut, Y);
    K = mconstant(BHN);
    dp = m * zp;
    Sw = wearstrength(b, Q, dp, BHN);
    v = velocity(dp, np);
    Cv = velocityfactor(v);
    S = Sb * (Sb < Sw) + Sw * (Sw < Sb);
    Pt = tangentialforce(0, 0, S, Cs, Cv, fs);
    Mt = transmittedtorque(0, 0, Pt, dp);
    kw = ratedpower(np, Mt);
    
    
    fprintf("Beam strength = %dN\n\n", Sb)
    fprintf("Wear strength = %dN\n\n", Sw)
    fprintf("Effective load = %d*PtN\n\n", Cs/Cv)
    if Sb < Sw
        fprintf("Beam strength is less than wear strength\n")
    else
        fprintf("beam strength is greater then wear strength\n")
    end
    fprintf("Tangential force = %dN\n\n", Pt)
    fprintf("Rated power = %dkW\n", kw)
end