%tangential force due to rated torque
function Pt = tangentialforce(Mt, dp, S, Cs, Cv, fs)
if Mt ~= 0
    Pt = 2 * Mt / dp;
else
    Pt = S * Cv / (Cs * fs);
end