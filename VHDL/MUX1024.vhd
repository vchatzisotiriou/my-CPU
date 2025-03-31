library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX1024 is
    port ( Input : in STD_LOGIC_VECTOR(1023 downto 0); -- 32 * 32bit
           Sel : in STD_LOGIC_VECTOR (4 downto 0);
           Output : out STD_LOGIC_VECTOR (31 downto 0));
end MUX1024;

architecture structural of MUX1024 is
	type REG_ARRAY is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
	signal register_array: REG_ARRAY;
begin
	u: for i in 0 to 31 generate -- convert 1024 bit input to REG_ARRAY
		register_array(i) <= Input(1024 - i*32 -1 downto 1024 - i*32 - 32); -- 32 bits total
	end generate;
	Output <= register_array(to_integer(unsigned(sel))); -- convert sel to integer and access the array
end structural;