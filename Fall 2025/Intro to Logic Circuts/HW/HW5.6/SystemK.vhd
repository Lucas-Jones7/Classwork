library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SystemK is
    port(
        A, B, C, D : in bit;
        F : out bit
    );
end SystemK;

architecture structural of SystemK is

    component INV1
        port (A : in bit; Y : out bit);
    end component;

    component AND3
        port (A, B, C : in bit; Y : out bit);
    end component;

    component OR4
        port (A, B, C, D : in bit; Y : out bit);
    end component;

    signal nA, nB, nC, nD : bit;
    signal term1, term2, term3, term4 : bit;

begin

    U1: INV1 port map(A => A, Y => nA);
    U2: INV1 port map(A => B, Y => nB);
    U3: INV1 port map(A => C, Y => nC);
    U4: INV1 port map(A => D, Y => nD);

    G1: AND3 port map(A => nA, B => nB, C => nC, Y => term1);
    G2: AND3 port map(A => nA, B => B,  C => C,  Y => term2);
    G3: AND3 port map(A => A,  B => nB, C => nC, Y => term3);
    G4: AND3 port map(A => A,  B => B,  C => D,  Y => term4);

    
    O1: OR4 port map(A => term1, B => term2, C => term3, D => term4, Y => F);

end structural;

