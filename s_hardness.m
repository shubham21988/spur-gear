function BHN = s_hardness(Pef, fs, b, Q, dp)
BHN = (Pef * fs / 0.16 / dp / Q / b * 100^2)^0.5;