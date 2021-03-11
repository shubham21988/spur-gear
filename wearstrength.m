function Sw = wearstrength(b, Q, dp, BHN)
Sw = b * Q * dp * 0.16 * (BHN / 100)^2;
