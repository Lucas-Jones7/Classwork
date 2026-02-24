library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_1to8 is
    port (
        A   : in bit;
        Sel : in bit_vector (2 downto 0);
        F   : out bit_vector (7 downto 0)
    );
end entity;

architecture Behavioral of demux_1to8 is
begin
    -- Single driver using 'with ... select'
    with Sel select
        F <= "00000001" when "000",
             "00000010" when "001",
             "00000100" when "010",
             "00001000" when "011",
             "00010000" when "100",
             "00100000" when "101",
             "01000000" when "110",
             "10000000" when "111",
             "00000000" when others;  -- default
end architecture;

