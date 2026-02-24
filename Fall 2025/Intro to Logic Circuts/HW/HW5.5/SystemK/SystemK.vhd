entity SystemK is
    port (
        A : in  bit;
        B : in  bit;
        C : in  bit;
        D : in  bit;
        F : out bit
    );
end entity SystemK;

architecture Behavioral of SystemK is
begin
        with A & B & C & D select
        F <= '1' when "0000",  -- 0
             '1' when "0001",  -- 1
             '1' when "0010",  -- 2
             '1' when "0100",  -- 4
             '1' when "0101",  -- 5
             '1' when "0110",  -- 6
             '1' when "1000",  -- 8
             '1' when "1001",  -- 9
             '1' when "1010",  -- 10
             '1' when "1100",  -- 12
             '1' when "1101",  -- 13
             '1' when "1110",  -- 14
             '0' when others;
end architecture Behavioral;

