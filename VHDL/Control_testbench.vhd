--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:25:34 03/30/2025
-- Design Name:   
-- Module Name:   C:/Users/admin/Library/Computer Organization/Projects/lab1/Control_testbench.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Control_testbench IS
END Control_testbench;
 
ARCHITECTURE behavior OF Control_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         Zero : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         PC_Sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         ExtOp : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         Mem_WrEn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal Zero : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC_Sel : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_B_sel : std_logic;
   signal RF_WrData_sel : std_logic;
   signal ExtOp : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal Mem_WrEn : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          CLK => CLK,
          RST => RST,
          Zero => Zero,
          Instr => Instr,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          ExtOp => ExtOp,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn
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
			-- opcode /--rs-/--rd-/--rt-/-------/-func- 
			-- 100000/00001/00111/00001/00000/110000   
			Instr <= "10000000001001110000100000110000"; -- add
			wait for CLK_period;
			Instr <= "10000000011001110000100000110001"; -- sub
			wait for CLK_period;
			Instr <= "10000010101001111011000000110010"; -- and
			wait for CLK_period;
			Instr <= "10000010101001110000000000110011"; -- or
			wait for CLK_period;
			Instr <= "10000000001001110000000000110100"; -- not
			wait for CLK_period;
			Instr <= "10000000010001000000000000111000"; -- sra
			wait for CLK_period;
			Instr <= "10000000010001000000000000111001"; -- srl
			wait for CLK_period;
			Instr <= "10000000010001000000000000111010"; -- sll
			wait for CLK_period;
			Instr <= "10000010011001000000000000111100"; -- rol
			wait for CLK_period;
			Instr <= "10000010011001000000000000111101"; -- ror
			wait for CLK_period;
			
			-- opcode /--rs-/--rd-/----immediate---
			Instr <= "11100000000001000000000000001111"; -- li
			wait for CLK_period;
			Instr <= "11100100000001000000000011110000"; -- lui
			wait for CLK_period;
			Instr <= "11000000000001000000111100000000"; -- addi
			wait for CLK_period;
			Instr <= "11001000000001001111000000000000"; -- andi
			wait for CLK_period;
			Instr <= "11001100000001000101010101010101"; -- ori
			wait for CLK_period;
			
			Instr <= "11111100000001000000000000000001"; -- b
			wait for CLK_period;
			Zero <= '0';			
			Instr <= "01000000001001000000000000000000"; -- beq false
			wait for CLK_period; 
			Zero <= '1';			
			Instr <= "01000000100001000000000000000011"; -- beq true
			wait for CLK_period;
			Zero <= '0';
			Instr <= "01000100101001000000000000000000"; -- bne false
			wait for CLK_period;
			Zero <= '1';
			Instr <= "01000100101001000000000000000111"; -- bne true
			wait for CLK_period;
			
			Zero <= '0';
			Instr <= "00111100101001000110000000000000"; -- lw
			wait for CLK_period;
			Instr <= "01111100101001000110000000000000"; -- sw
			wait for CLK_period;
			Instr <= "00000000000000000000000000000000"; -- nop
			wait for CLK_period;
      wait;
   end process;

END;
