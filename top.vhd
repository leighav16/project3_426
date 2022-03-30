library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity top is
PORT(clk_cpu, clk_in : in STD_LOGIC;
	 reset : in STD_LOGIC;
	 Inport0, Inport1 : in STD_LOGIC_VECTOR(7 downto 0);
	 Outport0, Outport1	: out STD_LOGIC_VECTOR(7 downto 0);
	 ANODE : out STD_LOGIC_VECTOR(3 downto 0);
	 SEG_OUT : out STD_LOGIC_VECTOR (6 downto 0));
end top;

architecture Behavioral of top is
component cpu is
PORT(clk : in STD_LOGIC;
	 reset : in STD_LOGIC;
	 Inport0, Inport1 : in STD_LOGIC_VECTOR(7 downto 0);
	 Outport0, Outport1	: out STD_LOGIC_VECTOR(7 downto 0);
	 SEG7out_R, SEG7out_L	: out STD_LOGIC_VECTOR(6 downto 0));
end component;


--component clk_div_1kHz is
--    Port ( clkin : in STD_LOGIC;
--           reset : in STD_LOGIC;
--           clkout : out STD_LOGIC);         -- determine if the output will be on the right or left 7 seg
--end component;

--component Multiplexer is
--    Port ( clk : in STD_LOGIC;
--           SEG_1 : in STD_LOGIC_VECTOR (6 downto 0);
--           SEG_2 : in STD_LOGIC_VECTOR (6 downto 0);
--           AN : out STD_LOGIC_VECTOR (3 downto 0);
--           SEG_out : out STD_LOGIC_VECTOR (6 downto 0));
--end component;

signal clk_1khz : STD_LOGIC;
signal SEG_R, SEG_L : STD_LOGIC_VECTOR(6 downto 0);

signal count: STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
signal clkout_tmp: STD_LOGIC := '0';

signal test1 : STD_LOGIC_VECTOR(6 downto 0) := "1001111";
signal test2 : STD_LOGIC_VECTOR(6 downto 0) := "0000110";

begin

--M1 : Multiplexer  PORT MAP (clk => clk_1khz, SEG_1 => SEG_R, SEG_2 => SEG_L, AN => ANODE, SEG_OUT => SEG_OUT);
--D1 : clk_div_1khz PORT MAP (clkin => clk_in, reset => reset, clkout => clk_1khz);
C1 : cpu          PORT MAP (clk => clk_cpu, reset => reset, Inport0 => Inport0, Inport1 => Inport1, Outport0 => Outport0,
                            Outport1 => Outport1, SEG7out_R => SEG_R, SEG7out_L => SEG_L);

process(clk_1khz)
begin
    case clk_1khz is
        when '0' =>
            ANODE <= "1110";
--            SEG_out(6 to 0) <= SEG_R;
            SEG_OUT <= SEG_R;
        when '1' =>
            ANODE <= "1101";
--            SEG_out(6 to 0) <= SEG_L;
            SEG_OUT <= SEG_L;
        when others =>
            ANODE <= "XXXX";
            SEG_out(6 to 0) <= "XXXXXXX";
    end case;
end process;

process(clk_in,reset)
begin
    if(reset = '1') then
        count <= "0000000000000000";
        clkout_tmp <= '0';
    elsif(clk_in'event and rising_edge(clk_in)) then
        count <= count + '1';
    if (count = "1100001101010000") then
        clkout_tmp <= not clkout_tmp;
        count <= "0000000000000000";
    end if;
    end if;
    clk_1khz <= clkout_tmp;
end process;

end Behavioral;
