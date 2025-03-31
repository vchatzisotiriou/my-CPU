LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RegisterFile_testbench IS
END RegisterFile_testbench;
 
ARCHITECTURE behavior OF RegisterFile_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WE : IN  std_logic;
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awrt : IN  std_logic_vector(4 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal WE : std_logic := '0';
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awrt : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          CLK => CLK,
          RST => RST,
          WE => WE,
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awrt => Awrt,
          Din => Din,
          Dout1 => Dout1,
          Dout2 => Dout2
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
		-- Toggle RST on the register file
		RST <= '1';
		wait for CLK_period;
		
		-- Read from random registers
		RST <= '0';
      Ard1 <= "10101";
      Ard2 <= "01010";
		wait for CLK_period;
		
		-- Check Read-Only status of R0
	   WE <= '1';
      Ard1 <= "00000";
      Awrt <= "00000";
      Din <= X"FFFFFFFF";
		wait for CLK_period;
				
		-- Write to random registers
		Awrt <= "01110";
		Din <= X"77777777";
		wait for CLK_period;
		
		Awrt <= "10001";
		Din <= X"88888888";
		wait for CLK_period;
		
		-- Read the data that was just written
		Ard1 <= "01110";
		Ard2 <= "10001";
		wait for CLK_period;
		
		-- Read and write in the same cycle
		Ard1 <= "11100";
		Awrt <= "00011";
		Din <= X"00C0FFEE";
		wait for CLK_period;
		
		-- Read and write in the same cycle and address
		Ard1 <= "11111";
		Awrt <= "11111";
		Din <= X"DEADBEEF";
		wait for CLK_period;
      wait;
   end process;
END;