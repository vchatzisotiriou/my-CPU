library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity Incrementor is
	port (A : in  STD_LOGIC_VECTOR (31 downto 0);
			Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Incrementor;

architecture behavioral of Incrementor is

begin

	Output <= A + 4;
	
end behavioral;