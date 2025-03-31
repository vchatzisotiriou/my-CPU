LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY DECSTAGE_testbench IS
END DECSTAGE_testbench;
 
ARCHITECTURE behavior OF DECSTAGE_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         ExtOp : IN  std_logic_vector(1 downto 0);
         Instr : IN  std_logic_vector(31 downto 0);
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal ExtOp : std_logic_vector(1 downto 0) := (others => '0');
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          CLK => CLK,
          RST => RST,
          RF_WrEn => RF_WrEn,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          ExtOp => ExtOp,
          Instr => Instr,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
		-- Toggle RST on DECSTAGE
		RST <= '1';
		wait for CLK_period;
		-- Decode a random instruction
		RST <= '0';
		Instr <= "00000000001000110001011001111111"; -- 00001 00011 00010
		wait for CLK_period;
		-- Cycle through Extender operations
		ExtOp <= "01";
		wait for CLK_period;
		ExtOp <= "10";
		wait for CLK_period;
		ExtOp <= "11";
		wait for CLK_period;
		-- Switch RF_B_sel
		RF_B_sel <= '1';
		RF_WrEn <= '1';
		wait for CLK_period;
		-- Write from ALU
		RF_WrData_sel <= '0';
		ALU_out <= X"DEADBEEF";
		wait for CLK_period;
		-- Write from Memory
		RF_WrData_sel <= '1';
		MEM_out <= X"C0FEBABE";
		wait for CLK_period;
		-- Read from Rw register
		Instr <= "00000000011000100000111001111111"; -- 00011 00010 00001 
		wait for CLK_period;	
		RST <= '1';
		
   wait;
   end process;

END;