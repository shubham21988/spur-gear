function m = modulecalc(kw, Cs, fs, zp, np, Cv, b_m, Sut, Y)
m = (60 * 10^6 * 3 * kw * Cs * fs / (pi * zp * np * Cv * b_m * Sut * Y))^(1/3);