LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY EXECSTAGE_testbench IS
END EXECSTAGE_testbench;
 
ARCHITECTURE behavior OF EXECSTAGE_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXECSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXECSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out
        );

   -- Stimulus process
   stim_proc: process
   begin      
		-- Addition (Ovf = 1)
		RF_A <= x"7FFFFFFF";
		RF_B <= x"00000001";
		ALU_Bin_sel <= '0';
		ALU_Func <= "0000";
      wait for 50 ns;
		
		-- Addition (Cout = 1)
		RF_A <= x"00000001";
		Immed <= x"FFFFFFFF";
		ALU_Bin_sel <= '1';
      wait for 50 ns;
		
		-- Subtraction (Ovf = 1)
		RF_A <= x"7FFFFFFF";
		RF_B <= x"80000000";
		ALU_Bin_sel <= '0';
		ALU_Func <="0001";
      wait for 50 ns;
		
		-- Subtraction (Cout = 1)
		RF_A <= x"80000000";
		Immed <= x"FFFFFFFF";
		ALU_Bin_sel <= '1';
      wait for 50 ns;
		
		-- Logical AND
		RF_A <= x"11111111";
		RF_B <= x"22222222";
		ALU_Bin_sel <= '0';
		ALU_Func <="0010";
      wait for 50 ns;
		
		-- Logical OR
		Immed <= x"00000002";
		ALU_Bin_sel <= '1';
		ALU_Func <="0011";
		wait for 50 ns;
		
		-- Logical NOT
		RF_B <= x"00000002";
		ALU_Bin_sel <= '0';
		ALU_Func <="0100";
		wait for 50 ns;
		
		-- Shift Right Arithmetic
		RF_A <= x"F000000F";
		ALU_Bin_sel <= '1';
		ALU_Func <="1000";
		wait for 50 ns;
		
		-- Shift Right Logical
		ALU_Bin_sel <= '0';
		ALU_Func <="1001";
		wait for 50 ns;

		-- Shift Left Logical
		RF_A <= x"F000000F";
		ALU_Bin_sel <= '1';
		ALU_Func <="1010";
		wait for 50 ns;
		
		-- Rotate Left
		RF_A <= x"1FFFFFFF";
		ALU_Bin_sel <= '0';
		ALU_Func <="1100";
		wait for 50 ns;
		
		-- Rotate Right
		RF_A <= x"FFFFFFF1";
		ALU_Bin_sel <= '1';
		ALU_Func <="1101";
		wait for 50 ns;
		wait;
	
	end process;
END;