LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY MEMSTAGE_testbench IS
END MEMSTAGE_testbench;
 
ARCHITECTURE behavior OF MEMSTAGE_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         CLK : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          CLK => CLK,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut
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

		Mem_WrEn <='0';
		ALU_MEM_Addr <=X"DEADBEEF";
		MEM_DataIn <=X"77777777";
      wait for 10 ns;
		
		Mem_WrEn <='1';
      wait for 10 ns;
		
		MEM_DataIn <=X"FFFFFFFF";
      wait for 10 ns;
		
		ALU_MEM_Addr <=X"C0FEBABE";
      wait for 10 ns;
		
		Mem_WrEn <='0';
		MEM_DataIn <=X"77777777";
      wait for 10 ns;
		
		Mem_WrEn <='1';
      wait for 10 ns;
		
		Mem_WrEn <='0';
      wait for 10 ns;

		wait;
   
	end process;
END;
