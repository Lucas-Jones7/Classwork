library ieee;

entity SystemI is
    port (
        A, B, C, D : in  bit;
        F          : out bit
    );
end entity SystemI;

architecture Behavioral of SystemI is
begin
   

    F <= (not A and not B and not C and D) or
         (not A and not B and C and D) or
         (A and not B and not C and D) or
         (A and not B and C and D);
end architecture Behavioral;

