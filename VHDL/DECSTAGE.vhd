library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DECSTAGE is
	port (CLK : in  STD_LOGIC;
         RST : in  STD_LOGIC;
         RF_WrEn : in  STD_LOGIC;
         RF_B_sel : in  STD_LOGIC;
         RF_WrData_sel : in  STD_LOGIC;
			ExtOp: in STD_LOGIC_VECTOR (1 downto 0);
			Instr : in  STD_LOGIC_VECTOR (31 downto 0);
         ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
         MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
         Immed : out  STD_LOGIC_VECTOR (31 downto 0);
         RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
         RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;


architecture structural of DECSTAGE is

component RegisterFile is
	port ( 
			CLK : in  STD_LOGIC;
			RST : in STD_LOGIC;
			WE : in  STD_LOGIC;
			Ard1 : in STD_LOGIC_VECTOR (4 downto 0);
			Ard2 : in STD_LOGIC_VECTOR (4 downto 0);
			Awrt : in STD_LOGIC_VECTOR (4 downto 0);
			Din : in STD_LOGIC_VECTOR (31 downto 0);
			Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
			Dout2 : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX32 is
	port (Input1 : in STD_LOGIC_VECTOR (31 downto 0);
			Input2 : in STD_LOGIC_VECTOR (31 downto 0);
			Sel : in STD_LOGIC;
			Output: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX05 is
	port (Input1 : in STD_LOGIC_VECTOR (4 downto 0);
			Input2 : in STD_LOGIC_VECTOR (4 downto 0);
			Sel : in STD_LOGIC;
			Output: out STD_LOGIC_VECTOR (4 downto 0));
end component;

component Extender is
	port (Input : in STD_LOGIC_VECTOR(15 downto 0);
			ExtOp : in STD_LOGIC_VECTOR(1 downto 0);
         Immed : out STD_LOGIC_VECTOR(31 downto 0));
end component;

signal mux5_output : STD_LOGIC_VECTOR(4 downto 0);
signal mux32_output : STD_LOGIC_VECTOR(31 downto 0);

begin

M05: MUX05
	port map(
		Input1 => Instr(15 downto 11), -- Rt
      Input2 => Instr(20 downto 16), -- Rd
      Sel => RF_B_sel,
      Output => mux5_output);

M32: MUX32
	port map(
		Input1 => ALU_out,
      Input2 => MEM_out,
      Sel => RF_WrData_sel,
      Output => mux32_output);

RF: RegisterFile
	port map(
      CLK => CLK,
      RST => RST,
      WE => RF_WrEn,
      Ard1 => Instr(25 downto 21), -- Rs
      Ard2 => mux5_output, -- Rt or Rd
      Awrt => Instr(20 downto 16), -- Rd
      Din => mux32_output,
      Dout1 => RF_A,
      Dout2 => RF_B);
    
EXD: Extender
	port map(
      Input => Instr(15 downto 0), -- Immed
      ExtOp => ExtOp,
      Immed => Immed);

end structural;