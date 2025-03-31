library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX32 is
	port (Input1 : in STD_LOGIC_VECTOR (31 downto 0);
			Input2 : in STD_LOGIC_VECTOR (31 downto 0);
			Sel : in STD_LOGIC;
			Output: out STD_LOGIC_VECTOR (31 downto 0));
end MUX32;

architecture behavioral of MUX32 is

begin

	Output <= Input1 when Sel = '0' else Input2;

end behavioral;