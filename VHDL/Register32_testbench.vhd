LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Register32_testbench IS
END Register32_testbench;
 
ARCHITECTURE behavior OF Register32_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Register32
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WE : IN  std_logic;
         DataIn : IN  std_logic_vector(31 downto 0);
         DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal WE : std_logic := '0';
   signal DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Register32 PORT MAP (
          CLK => CLK,
          RST => RST,
          WE => WE,
          DataIn => DataIn,
          DataOut => DataOut
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
		RST <= '1';
		wait for CLK_period;
      
		RST <= '0';
		WE <= '1';
		DataIn <= X"33333333";
		wait for CLK_period;  
      
		WE <= '0';
		DataIn <= X"FFFFFFFF";
		wait for CLK_period;  

		WE <= '1';
		wait for CLK_period; 
		
		RST<= '1';
		wait for CLK_period;
      wait;
   end process;

END;