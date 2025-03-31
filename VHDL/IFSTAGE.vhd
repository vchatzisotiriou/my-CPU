library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IFSTAGE is
    port (CLK : in  STD_LOGIC;
         RST : in  STD_LOGIC;
			PC_Sel : in  STD_LOGIC;
         PC_LdEn : in  STD_LOGIC;
			PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
         Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;


architecture structural of IFSTAGE is

component Register32 is
    port (
			CLK : in  STD_LOGIC;
			RST : in STD_LOGIC;
         WE : in  STD_LOGIC;
         DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
         DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Incrementor is
	port (A : in  STD_LOGIC_VECTOR (31 downto 0);
			Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Adder is
	port (A : in  STD_LOGIC_VECTOR (31 downto 0);
			B : in  STD_LOGIC_VECTOR (31 downto 0);
			Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX32 is
	port (Input1 : in STD_LOGIC_VECTOR (31 downto 0);
			Input2 : in STD_LOGIC_VECTOR (31 downto 0);
			Sel : in STD_LOGIC;
			Output: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component IF_MEM is
	port (CLK: in STD_LOGIC;
         Addr : in  STD_LOGIC_VECTOR (31 downto 0);
         Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal adder_output : STD_LOGIC_VECTOR (31 downto 0);
signal incrm_output : STD_LOGIC_VECTOR (31 downto 0);
signal reg_output : STD_LOGIC_VECTOR (31 downto 0);
signal mux_output : STD_LOGIC_VECTOR (31 downto 0);

begin


INC: Incrementor
	port map(
		A => reg_output,
		Output => incrm_output);

ADR: Adder
	port map(
		A => PC_Immed,
		B => incrm_output,
		Output => adder_output);

MUX: MUX32
	port map(
		Input1 => incrm_output,
		Input2 => adder_output,
		Sel => PC_Sel,
		Output => mux_output);

PCR: Register32
	port map(
		CLK => CLK,
		RST => RST,
		WE => PC_LdEn,
		DataIn => mux_output,
		DataOut => reg_output);

MEM: IF_MEM
	port map( 
		CLK => CLK,
		Addr => reg_output,
		Instr => Instr);

end structural;