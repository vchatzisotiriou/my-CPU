library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Extender is
	port (Input : in STD_LOGIC_VECTOR(15 downto 0);
			ExtOp : in STD_LOGIC_VECTOR(1 downto 0);
         Immed : out STD_LOGIC_VECTOR(31 downto 0));
end Extender;

architecture dataflow of Extender is

begin

Immed <= (31 downto 16 => Input(15)) & Input when ExtOp = "00" else -- Sign Extention 
			std_logic_vector(shift_left(unsigned((31 downto 16 => Input(15)) & Input), 2)) when ExtOp = "01" else -- Sign Extention and Shift by 2
			(31 downto 16 => '0') & Input when ExtOp = "10" else -- Zero Fill
         std_logic_vector(shift_left(unsigned((31 downto 16 => '0') & Input), 16)) when ExtOp = "11"; -- Zero Fill and Shift by 16
			
end dataflow;