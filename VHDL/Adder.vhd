library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity Adder is
	port (A : in  STD_LOGIC_VECTOR (31 downto 0);
			B : in  STD_LOGIC_VECTOR (31 downto 0);
			Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Adder;

architecture Behavioral of Adder is

begin

	Output <= A + B;

end Behavioral;