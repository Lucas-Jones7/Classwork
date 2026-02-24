library IEEE;              
use IEEE.STD_LOGIC_1164.ALL;

entity AND3 is
    port (
        A : in  bit;
        B : in  bit;
        C : in  bit;
        Y : out bit
    );
end AND3;

architecture behavior of AND3 is
begin
    Y <= A and B and C;
end behavior;

