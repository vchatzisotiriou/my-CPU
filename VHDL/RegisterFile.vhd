library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFile is
	port ( 
			CLK : in  STD_LOGIC;
			RST : in STD_LOGIC;
			WE : in  STD_LOGIC;
			Ard1 : in STD_LOGIC_VECTOR (4 downto 0);
			Ard2 : in STD_LOGIC_VECTOR (4 downto 0);
			Awrt : in STD_LOGIC_VECTOR (4 downto 0);
			Din : in STD_LOGIC_VECTOR (31 downto 0);
			Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
			Dout2 : out STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;


architecture structural of RegisterFile is

component Decoder32 is
    port (Input : in  STD_LOGIC_VECTOR (4 downto 0);
         Output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Register0 is
    port (CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
         WE : in STD_LOGIC;
         DataIn : in STD_LOGIC_VECTOR (31 downto 0);
         DataOut : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Register32 is
    port (CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
         WE : in STD_LOGIC;
         DataIn : in STD_LOGIC_VECTOR (31 downto 0);
         DataOut : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX1024 is
    port (Input : in STD_LOGIC_VECTOR(1023 downto 0);
          Sel : in STD_LOGIC_VECTOR (4 downto 0);
          Output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

type REG_ARRAY is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);

signal decoder_output : STD_LOGIC_VECTOR (31 downto 0);
signal register_we : STD_LOGIC_VECTOR (31 downto 0);
signal register_output : REG_ARRAY;
signal mux_input: STD_LOGIC_VECTOR (1023 downto 0);

begin

dec: Decoder32
	port map (
		Input => Awrt,
		Output => decoder_output);

register_we(0)<= decoder_output(0) and WE;
reg0: Register0
	port map (
		CLK => CLK,
		RST => RST,
		WE => register_we(0),
		DataIn => Din,
		DataOut => register_output(0));

r: for i in 1 to 31 generate
	register_we(i) <= decoder_output(i) and WE;
	regn: Register32
		port map (
			CLK => CLK,
			RST => RST,
			WE => register_we(i),
			DataIn => Din,
			DataOut => register_output(i)); 
end generate;

u: for i in 0 to 31 generate -- convert REG_ARRAY to 1024 bit input
	mux_input(1024 - i*32 -1 downto 1024 - i*32 - 32) <= register_output(i);
end generate;

mux1: MUX1024
	port map (
		Input => mux_input,
		Sel => Ard1,
		Output => Dout1);
		
mux2: MUX1024
	port map (
		Input => mux_input,
		Sel => Ard2,
		Output => Dout2);

end structural;