library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register0 is
    port (
			CLK : in  STD_LOGIC;
			RST : in STD_LOGIC;
         WE : in  STD_LOGIC;
         DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
         DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Register0;

architecture behavioral of Register0 is

begin
	DataOut <= x"00000000";
end behavioral;