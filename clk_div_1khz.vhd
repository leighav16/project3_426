library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clk_div_1kHz is
    Port ( clkin : in STD_LOGIC;
           reset : in STD_LOGIC;
           clkout : out STD_LOGIC);         -- determine if the output will be on the right or left 7 seg
end clk_div_1kHz;

architecture Behavioral of clk_div_1kHz is
signal count: STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
signal clkout_tmp: STD_LOGIC := '0';

begin
    process(clkin,reset)
        begin
            if(reset = '1') then
                count <= "0000000000000000";
                clkout_tmp <= '0';
            elsif(clkin'event and rising_edge(clkin)) then
                count <= count + '1';
            if (count = "1100001101010000") then
                clkout_tmp <= not clkout_tmp;
                count <= "0000000000000000";
            end if;
            end if;
            clkout <= clkout_tmp;
        end process;
end Behavioral;
