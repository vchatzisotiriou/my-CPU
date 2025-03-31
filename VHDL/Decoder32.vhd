library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder32 is
    port (
         Input : in  STD_LOGIC_VECTOR (4 downto 0);
         Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder32;

architecture behavioral of Decoder32 is

begin
	process (Input)
	begin
		case Input is
			when "00000" => Output <= X"00000001";
         when "00001" => Output <= X"00000002";
         when "00010" => Output <= X"00000004";
         when "00011" => Output <= X"00000008";
         when "00100" => Output <= X"00000010";
         when "00101" => Output <= X"00000020";
         when "00110" => Output <= X"00000040";
         when "00111" => Output <= X"00000080";
         when "01000" => Output <= X"00000100";
         when "01001" => Output <= X"00000200";
         when "01010" => Output <= X"00000400";
         when "01011" => Output <= X"00000800";
         when "01100" => Output <= X"00001000";
         when "01101" => Output <= X"00002000";
         when "01110" => Output <= X"00004000";
         when "01111" => Output <= X"00008000";
         when "10000" => Output <= X"00010000";
         when "10001" => Output <= X"00020000";
         when "10010" => Output <= X"00040000";
         when "10011" => Output <= X"00080000";
         when "10100" => Output <= X"00100000";
         when "10101" => Output <= X"00200000";
         when "10110" => Output <= X"00400000";
         when "10111" => Output <= X"00800000";
         when "11000" => Output <= X"01000000";
         when "11001" => Output <= X"02000000";
         when "11010" => Output <= X"04000000";
         when "11011" => Output <= X"08000000";
         when "11100" => Output <= X"10000000";
         when "11101" => Output <= X"20000000";
         when "11110" => Output <= X"40000000";
         when "11111" => Output <= X"80000000";
         when others  => Output <= X"00000000";
		end case;
	end process;

end behavioral;