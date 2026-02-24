entity top is
  port (SW    : in bit_vector (3 downto 0);
		  LEDR  : out bit_vector (3 downto 0);
		  Prime : out bit);
end entity;

architecture top_arch of top is 
	
	begin
	
		LEDR <= SW;
		
		with SW select
        Prime <= '1' when "0010",   
                 '1' when "0011",   
                 '1' when "0101",   
                 '1' when "0111",  
                 '1' when "1011",   
                 '1' when "1101",   
                 '0' when others;
					  
end architecture;