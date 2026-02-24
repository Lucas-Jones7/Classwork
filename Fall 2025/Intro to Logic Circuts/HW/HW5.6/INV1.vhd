library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity INV1 is
    port (A : in bit; Y : out bit);
end INV1;

architecture behavior of INV1 is
begin
    Y <= not A;
end behavior;

