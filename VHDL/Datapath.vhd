library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath is
	port (CLK : in STD_LOGIC;
         RST : in STD_LOGIC;  			  
			-- IFSTAGE:
			PC_Sel : in STD_LOGIC;
			PC_LdEn : in STD_LOGIC;
			-- DECSTAGE:
			RF_WrEn : in STD_LOGIC;
			RF_B_sel : in STD_LOGIC;
			RF_WrData_sel : in STD_LOGIC;
			ExtOp : in STD_LOGIC_VECTOR(1 downto 0);
			-- EXECSTAGE:
			ALU_Bin_sel : in  STD_LOGIC; 
			ALU_func : in std_logic_vector(3 downto 0); 
			-- MEMSTAGE:
			Mem_WrEn : in  std_logic;	
			
			Zero : out  STD_LOGIC;
			Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end Datapath;


architecture structural of Datapath is

component IFSTAGE is
    port (CLK : in  STD_LOGIC;
         RST : in  STD_LOGIC;
			PC_Sel : in  STD_LOGIC;
         PC_LdEn : in  STD_LOGIC;
			PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
			Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component DECSTAGE is
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
end component;

component EXECSTAGE is
	port (ALU_Bin_sel : in  STD_LOGIC;
			ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			Immed : in  STD_LOGIC_VECTOR (31 downto 0);
			RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
			RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
			Zero : out STD_LOGIC;
			ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MEMSTAGE is
	port (CLK : in  STD_LOGIC;
			Mem_WrEn : in  STD_LOGIC;
         ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
         MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
         MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal s_instr : STD_LOGIC_VECTOR (31 downto 0);
signal s_rf_a : STD_LOGIC_VECTOR (31 downto 0);
signal s_rf_b : STD_LOGIC_VECTOR (31 downto 0);
signal s_alu_out : STD_LOGIC_VECTOR (31 downto 0);
signal s_mem_out : STD_LOGIC_VECTOR (31 downto 0);
signal s_immed : STD_LOGIC_VECTOR (31 downto 0);

begin

	IFS: IFSTAGE port map(
		CLK => CLK,
		RST => RST,
		PC_Sel => PC_Sel,
		PC_LdEn => PC_LdEn,
		PC_Immed => s_immed,
		
		Instr => s_instr);
	
	DEC: DECSTAGE port map(
		CLK => CLK,
		RST => RST,
		RF_WrEn => RF_WrEn,
		RF_B_sel => RF_B_sel,
		RF_WrData_sel => RF_WrData_sel,
		ExtOp => ExtOp,
		Instr => s_instr,
		ALU_out => s_alu_out,
		MEM_out => s_mem_out,
		
		Immed => s_immed,
		RF_A => s_rf_a,
		RF_B => s_rf_b);
	
	EXE: EXECSTAGE port map(
		ALU_Bin_sel => ALU_Bin_sel,
		ALU_func => ALU_func,
		Immed => s_immed,
		RF_A => s_rf_a,
		RF_B => s_rf_b,
		
		Zero => Zero,
		ALU_out => s_alu_out);
	
	MEM: MEMSTAGE port map(
		CLK => CLK,
		Mem_WrEn => Mem_WrEn,
		ALU_MEM_Addr => s_alu_out,
		MEM_DataIn => s_rf_b,
		
		MEM_DataOut => s_mem_out);

Instr <= s_instr;

end structural;