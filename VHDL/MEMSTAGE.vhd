library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEMSTAGE is
	port (CLK : in  STD_LOGIC;
			Mem_WrEn : in  STD_LOGIC;
         ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
         MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
         MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture structural of MEMSTAGE is

component MEM_RAM is
	port (clk : in  STD_LOGIC;
			we : in  STD_LOGIC;
			a : in STD_LOGIC_VECTOR (9 downto 0);
			d : in STD_LOGIC_VECTOR (31 downto 0);
         spo : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

begin

RAM: MEM_RAM
	port map( 
		clk => CLK,
		we => Mem_WrEn,
		a => ALU_MEM_Addr(11 downto 2),
		d => MEM_DataIn,
		spo => MEM_DataOut);	

end structural;