LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_signed.ALL; 

ENTITY ALU_testbench IS
END ALU_testbench;
 
ARCHITECTURE behavior OF ALU_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Sout : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Sout : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Sout => Sout,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        ); 

   -- Stimulus process
   stim_proc: process
   begin
      A <= X"FFFFFFFF";
      B <= X"00000001";
      Op <= "0000";
      wait for 10ns;
      Op <= "0001";
      wait for 10ns;
      Op <= "0010";
      wait for 10ns;
      Op <= "0011";
      wait for 10ns;
      Op <= "0100";
      wait for 10ns;
      Op <= "1000";
      wait for 10ns;
      Op <= "1001";
      wait for 10ns;
      Op <= "1010";
      wait for 10ns;
      Op <= "1100";
      wait for 10ns;
      Op <= "1101";
      wait for 10ns;
      wait;
   end process;

END;