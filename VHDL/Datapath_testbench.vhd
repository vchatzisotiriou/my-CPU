LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Datapath_testbench IS
END Datapath_testbench;
 
ARCHITECTURE behavior OF Datapath_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Datapath
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         ExtOp : IN  std_logic_vector(1 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         Mem_WrEn : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal ExtOp : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal Mem_WrEn : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Datapath PORT MAP (
          CLK => CLK,
          RST => RST,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          ExtOp => ExtOp,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn,
          Instr => Instr
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		wait for CLK_period;
      wait;
   end process;

END;