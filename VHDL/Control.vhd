library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
	port (CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
			Zero : in  STD_LOGIC;
			Instr : in STD_LOGIC_VECTOR (31 downto 0);
			-- IFSTAGE:
			PC_Sel : out STD_LOGIC;
			PC_LdEn : out STD_LOGIC;
			-- DECSTAGE:
			RF_WrEn : out STD_LOGIC;
			RF_B_sel : out STD_LOGIC;
			RF_WrData_sel : out STD_LOGIC;
			ExtOp : out STD_LOGIC_VECTOR (1 downto 0);
			-- EXECSTAGE:
			ALU_Bin_sel : out STD_LOGIC; 
			ALU_func : out std_logic_vector (3 downto 0); 
			-- MEMSTAGE:
			Mem_WrEn : out std_logic);			  
end Control;


architecture behavioral of Control is

begin

process (RST, Instr, Zero)
begin

	if RST = '0' then
		if (Instr(31 downto 0) /= X"00000000") then
			if (Instr(31 downto 26) = "100000") then -- R-type
				PC_Sel <= '0';
				PC_LdEn <= '1';
            RF_WrEn <= '1'; -- Enable writing on RF
            RF_WrData_sel <= '0'; -- ALU_out
            RF_B_sel <= '0'; -- R-type
				ExtOp <= "--"; -- not applicable
            ALU_Bin_sel <= '0'; -- RF_B
				ALU_func <= Instr(3 downto 0);  -- func field is 6 bits wide, but the first 2 bits are always "11"
            Mem_WrEn <= '0';

        elsif (Instr(31 downto 30) = "11" and Instr(28) = '0') then -- I-type
            PC_Sel <= '0';
            PC_LdEn <= '1';
            RF_WrEn <= '1'; -- Enable writing on RF
            RF_WrData_sel <= '0'; -- ALU_out
            RF_B_sel <= '1'; -- I-type
            ALU_Bin_sel <= '1'; -- Immed
            Mem_WrEn <= '0';
				
            if (Instr(28 downto 26) = "000") then -- li, addi
                ExtOp <= "00"; -- Sign Extension, without shift
                ALU_func <= "0000"; -- add
				
            elsif (Instr(28 downto 26) = "001") then -- lui
                ExtOp <= "11"; -- Zero-fill, shift by 16
                ALU_func <= "0000"; -- add

            elsif (Instr(28 downto 26) = "010") then -- andi
                ExtOp <= "10"; -- Zero-fill, without shift
                ALU_func <= "0010"; -- and

            elsif (Instr(28 downto 26) = "011") then -- ori
                ExtOp <= "10"; -- Zero-fill, without shift
                ALU_func <= "0011"; -- or
            end if;
			
        elsif (Instr(31 downto 26) = "111111" or Instr(31 downto 26)="010000" or Instr(31 downto 26) = "010001") then -- branch
				PC_LdEn <= '1';
            RF_WrEn <= '0'; -- Disable writing on RF
            RF_B_sel <= '1'; -- I-type
            RF_WrData_sel <= '-'; -- not applicable
            ExtOp <= "01"; -- Sign Extension, shift by 2
				ALU_func <= "0001"; -- Subtraction (always zero for b)
				ALU_Bin_sel <= '0'; -- RF_B (= rd)
            Mem_WrEn <= '0';		

            if (Instr(31 downto 26) = "111111" ) then -- b			
					PC_Sel <= '1';
					
            elsif (Instr(31 downto 26) = "010000") then -- beq					 
					if (Zero = '1') then	-- if (rs-rd=0 => rs=rd)
						PC_Sel <= '1'; 	-- PC <- PC + 4 + (SignExtend(Imm) << 2)
					else					  	-- if (rs!=rd)
						PC_Sel <= '0';   	-- PC <- PC + 4
					end if;

            elsif (Instr(31 downto 26) = "010001") then -- bne					 
					if(Zero = '1') then	-- if (rs-rd=0 => rs=rd) 
						PC_sel <= '0'; 	-- PC <- PC + 4
					else 						-- if (rs!=rd)
						PC_sel <= '1'; 	-- PC <- PC + 4 + (SignExtend(Imm) << 2) 
					end if;
					
				end if;
				
        elsif (Instr(31 downto 26) = "001111" or Instr(31 downto 26) = "000011") then -- lw, lb
				PC_Sel <= '0';
				PC_LdEn <= '1';
				RF_WrEn <= '1'; -- Enable writing on RF
				RF_WrData_sel <= '1'; -- MEM_out
				RF_B_sel <= '1'; -- I-type
				ExtOp  <= "00"; -- Sign Extension, without shift
				ALU_Bin_Sel <= '1'; -- Immed
				ALU_func <= "0000"; -- Addition
				Mem_WrEn <= '0'; -- Disable writing on MEM
		  
		  elsif (Instr(31 downto 26) = "011111" or Instr(31 downto 26) = "000111") then -- sw, sb
				PC_Sel <= '0';
				PC_LdEn <= '1';
				RF_WrEn <= '0'; -- Disable writing on RF
				RF_WrData_sel <= '-'; -- not applicable
				RF_B_sel <= '1'; -- I-type
				ExtOp  <= "00"; -- Sign Extension, without shift
				ALU_Bin_Sel <= '1'; -- Immed
				ALU_func <= "0000"; -- Addition
				Mem_WrEn <= '1'; -- Enable writing on MEM
			
			end if;
			
		else -- nop
			PC_Sel <= '0';
         PC_LdEn <= '1';
         RF_WrEn <= '-';
         RF_WrData_sel <= '-';
         RF_B_sel <= '-';
         ExtOp  <= "--";
         ALU_Bin_Sel <= '-';
         ALU_func <= "----"; 
         Mem_WrEn <= '-';
		
		end if;
		
	else
		PC_Sel <= '0';
		PC_LdEn <= '0';
		RF_WrEn <= '0';
		RF_B_sel <= '0';
		RF_WrData_sel <= '0';
		ExtOp <= "00";
		ALU_Bin_Sel <= '0';
		ALU_Func <= "0000";
		Mem_WrEn <= '0';
	
	end if;

end process;
end behavioral;