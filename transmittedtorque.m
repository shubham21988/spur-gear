function Mt = transmittedtorque(kw, np, Pt, dp)
if kw ~= 0
    Mt = 60 * 10^6 * kw / (2 * pi * np);
else
    Mt = Pt * dp / 2;
end
