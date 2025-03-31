library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EXECSTAGE is
	port (ALU_Bin_sel : in  STD_LOGIC;
			ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			Immed : in  STD_LOGIC_VECTOR (31 downto 0);
			RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
			RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
			Zero: out STD_LOGIC;
			ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end EXECSTAGE;

architecture Structural of EXECSTAGE is

component MUX32 is
	port (Input1 : in STD_LOGIC_VECTOR (31 downto 0);
			Input2 : in STD_LOGIC_VECTOR (31 downto 0);
			Sel : in STD_LOGIC;
			Output: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component ALU is
	port (A : in  STD_LOGIC_VECTOR (31 downto 0);
			B : in  STD_LOGIC_VECTOR (31 downto 0);
			Op : in  STD_LOGIC_VECTOR (3 downto 0);
			Sout : out  STD_LOGIC_VECTOR (31 downto 0);
			Zero : out  STD_LOGIC;
			Cout : out  STD_LOGIC;
			Ovf : out  STD_LOGIC);
end component;

signal mux_out: STD_LOGIC_VECTOR (31 downto 0);

begin

MUX: MUX32
	port map( 
		Input1 => RF_B,
		Input2 => Immed,
		Sel => ALU_Bin_sel,
		Output => mux_out);
	
ALV: ALU
	port map( 
		A => RF_A,
		B => mux_out,
		Op => ALU_func,
		Sout => ALU_Out,
		Zero => Zero,
		Cout => open,
		Ovf => open);

end Structural;