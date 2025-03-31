LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;
 
ENTITY MUX1024_testbench IS
END MUX1024_testbench;
 
ARCHITECTURE behavior OF MUX1024_testbench IS 
 
    COMPONENT MUX1024
    PORT(
         Input : IN  std_logic_vector(1023 downto 0);
         Sel : IN  std_logic_vector(4 downto 0);
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(1023 downto 0) := (others => '0');
   signal Sel : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
	
	type REG_ARRAY is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
	signal register_array: REG_ARRAY;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX1024 PORT MAP (
          Input => Input,
          Sel => Sel,
          Output => Output
        ); 
		  
	u: for i in 0 to 31 generate -- convert REG_ARRAY to 1024 bit input
		Input(1024 - i*32 -1 downto 1024 - i*32 - 32) <= register_array(i);
	end generate;
	
   -- Stimulus process
   stim_proc: process
   begin
		i: for i in 0 to 31 loop
			j: for j in 0 to 31 loop
				register_array(j) <= std_logic_vector(to_unsigned(i*32 + j, 32));
				sel <= std_logic_vector(to_unsigned(j, 5));
				wait for 20 ns;
			end loop;
		end loop;
		wait;
   end process;

END;