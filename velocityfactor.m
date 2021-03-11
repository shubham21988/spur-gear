function Cv = velocityfactor(v)
if v < 10
    Cv = 3 / (3 + v);
elseif v < 20
    Cv = 6 / (6 + v);
else
    Cv = 5.6 / (5.6 + v^0.5);
end