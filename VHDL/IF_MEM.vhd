library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_MEM is
	port (CLK: in STD_LOGIC;
         Addr : in  STD_LOGIC_VECTOR (31 downto 0);
         Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_MEM;

architecture structural of IF_MEM is

component IF_ROM
	port (a : in STD_LOGIC_VECTOR(9 downto 0);
			spo : out STD_LOGIC_VECTOR(31 downto 0));
end component;

begin

rom: IF_ROM
	port map( -- PC is a multiple of 4 so the last 2 bits are 0
		a => Addr(11 downto 2), -- therefore, we truncate them and keep the address
      spo => Instr);

end structural;