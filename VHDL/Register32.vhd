library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Register32 is
    port (
			CLK : in  STD_LOGIC;
			RST : in STD_LOGIC;
         WE : in  STD_LOGIC;
         DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
         DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Register32;

architecture behavioral of Register32 is

begin
	process
	begin
		wait until CLK'event and CLK = '1';
		if RST = '1' then
			DataOut <= X"00000000";
		elsif WE = '1' then
				DataOut <= DataIn;
		end if;
	end process;

end behavioral;