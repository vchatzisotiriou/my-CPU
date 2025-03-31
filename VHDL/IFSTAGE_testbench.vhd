LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IFSTAGE_testbench IS
END IFSTAGE_testbench;
 
ARCHITECTURE behavior OF IFSTAGE_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         PC_Immed : IN  std_logic_vector(31 downto 0);
         Instr : out  STD_LOGIC_VECTOR (31 downto 0));
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          CLK => CLK,
          RST => RST,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          PC_Immed => PC_Immed,
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
		-- Toggle RST on IFSTAGE
		-- Expected result: Everything resets
		RST <= '1';
		wait for CLK_period*2;
		
		-- Fetch the next instruction
		-- Expected result: PC = PC + 4
		RST <= '0';
		PC_Sel <= '0'; -- PC+4
		PC_LdEn<= '1';
		wait for CLK_period*8;
		
		-- Switch between PC_Sel with PC_LdEn = 0
		-- Expected result: PC is unaffected
		PC_LdEn<= '0';
		PC_Sel<= '1';
		wait for CLK_period*2;
		
		PC_Sel<= '0'; 
		wait for CLK_period*2;
		
		-- Load PC_Immed while PC_Sel = 0
		-- Expected result: PC_Immed is ignored
		PC_Immed <= X"00000008";
		PC_Sel <= '0'; -- PC+4
		PC_LdEn<= '1';
		wait for CLK_period*2;
		
		-- Load PC_Immed while PC_Sel = 1
		-- Expected result: PC_Immed is added to PC
		PC_Sel<= '1'; -- PC+4+Immed
		wait for CLK_period*2;
		
		-- Add different PC_Immed
		-- Expected result: PC_Immed is added to PC
		PC_Immed <= X"000000FF";
		wait for CLK_period*2;
		
		RST<= '1';
      wait for CLK_period;
      wait;
   end process;
END;