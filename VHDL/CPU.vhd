library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
    port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end CPU;

architecture structural of CPU is

component Datapath is
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
end component;

component Control is
	port (CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
			Zero : in  STD_LOGIC;
			Instr : in STD_LOGIC_VECTOR (31 downto 0);
			-- IFSTAGE:
			PC_Sel : out STD_LOGIC;
			PC_LdEn : out STD_LOGIC;
			-- DECSTAGE:
			RF_WrEn : out STD_LOGIC;
			RF_B_sel : out STD_LOGIC;
			RF_WrData_sel : out STD_LOGIC;
			ExtOp : out STD_LOGIC_VECTOR (1 downto 0);
			-- EXECSTAGE:
			ALU_Bin_sel : out STD_LOGIC; 
			ALU_func : out std_logic_vector (3 downto 0); 
			-- MEMSTAGE:
			Mem_WrEn : out std_logic);			  
end component;

-- IFSTAGE:
signal s_instr: STD_LOGIC_VECTOR (31 downto 0);
signal s_pc_sel : STD_LOGIC;
signal s_pc_lden : STD_LOGIC;

-- DECSTAGE:
signal s_rf_wren : STD_LOGIC;
signal s_rd_wrdata_sel :  STD_LOGIC;
signal s_rf_b_sel :  STD_LOGIC;
signal s_extop : STD_LOGIC_VECTOR(1 downto 0);

-- EXECSTAGE:
signal s_alu_bin_sel : STD_LOGIC;
signal s_alu_func : STD_LOGIC_VECTOR(3 downto 0);
signal s_zero : STD_LOGIC;

-- MEMSTAGE: 
signal s_mem_wren : STD_LOGIC;

begin

DATA: Datapath
	port map(
		CLK => CLK,
		RST => RST,
		PC_Sel => s_pc_sel,
		PC_LdEn => s_pc_lden,
		RF_WrEn => s_rf_wren,
		RF_B_sel => s_rf_b_sel,
		RF_WrData_sel => s_rd_wrdata_sel,
		ExtOp => s_extop,
		ALU_Bin_sel => s_alu_bin_sel,
		ALU_func => s_alu_func,
		Mem_WrEn => s_mem_wren,
		Zero => s_zero,
		Instr => s_instr);


CTRL: Control
	port map(
		CLK => CLK,
		RST => RST,
		Zero => s_zero,
		Instr => s_instr,
		PC_Sel => s_pc_sel,
		PC_LdEn => s_pc_lden,
		RF_WrEn => s_rf_wren,
		RF_B_sel => s_rf_b_sel,
		RF_WrData_sel => s_rd_wrdata_sel,
		ExtOp => s_extop,
		ALU_Bin_sel => s_alu_bin_sel,
		ALU_func => s_alu_func,
		Mem_WrEn => s_mem_wren);

end structural;