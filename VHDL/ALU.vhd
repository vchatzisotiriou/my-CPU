library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ALU is
	port (A : in  STD_LOGIC_VECTOR (31 downto 0);
			B : in  STD_LOGIC_VECTOR (31 downto 0);
			Op : in  STD_LOGIC_VECTOR (3 downto 0);
			Sout : out  STD_LOGIC_VECTOR (31 downto 0);
			Zero : out  STD_LOGIC;
			Cout : out  STD_LOGIC;
			Ovf : out  STD_LOGIC);
end ALU;

architecture behavioral of ALU is

signal tmp : STD_LOGIC_VECTOR (31 downto 0);
signal tco : STD_LOGIC_VECTOR (32 downto 0);

begin
    process (A, B, Op)
    begin
        case Op is
            when "0000" =>
                tmp <= A + B;
					 tco <= ('0' & A) + ('0' & B);                
            when "0001" =>
                tmp <= A - B;
					 tco <= ('0' & A) - ('0' & B);
            when "0010" =>
                tmp <= A and B;
            when "0011" =>
                tmp <= A or B;
            when "0100" =>
                tmp <= not A;
            when "1000" => -- shift right arithmetic
                tmp(30 downto 0) <= A(31 downto 1);
                tmp(31) <= A(31);
            when "1001" => -- shift right logical
                tmp(30 downto 0) <= A(31 downto 1);
                tmp(31) <= '0';
            when "1010" => -- shift left logical
                tmp(31 downto 1) <= A(30 downto 0);
                tmp(0) <= '0';
            when "1100" => -- rotate left
                tmp(31 downto 1) <= A(30 downto 0);
                tmp(0) <= A(31);
            when "1101" => -- rotate right
                tmp(30 downto 0) <= A(31 downto 1);
                tmp(31) <= A(0);
            when others =>
                tmp <= (others => 'X');
        end case;
    end process;
	 
    process (tmp)
    begin
        if tmp = X"00000000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
	 
	 process (Op, tco)
		begin
		if (Op = "0000") or (Op = "0001") then
			Cout <= tco(32); 
      else
         Cout <= '0'; 
      end if;
	end process;
	
	process (Op, A, B, tmp)
		begin
		if ((Op="0000") and ((A(31) = B(31)) and (A(31) /= tmp(31)))) or
			((Op="0001") and ((A(31) xor B(31)) and ((A(31) xnor tmp(31)))) = '1') then 
			Ovf <= '1';
		else
			Ovf <= '0';
		end if;
	end process;
	
	Sout <= tmp;
			  
end behavioral;