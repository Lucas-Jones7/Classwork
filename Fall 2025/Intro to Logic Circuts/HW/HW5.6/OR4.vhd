entity OR4 is
    port (A, B, C, D : in bit; Y : out bit);
end OR4;

architecture behavior of OR4 is
begin
    Y <= A or B or C or D;
end behavior;

