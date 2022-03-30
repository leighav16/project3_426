library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer is
    Port ( clk : in STD_LOGIC;
           SEG_1 : in STD_LOGIC_VECTOR (6 downto 0);
           SEG_2 : in STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (3 downto 0);
           SEG_out : out STD_LOGIC_VECTOR (6 downto 0));
end Multiplexer;

architecture Behavioral of Multiplexer is
begin
    process(clk)
    begin
        case clk is
            when '0' =>
                AN <= "1110";
                SEG_out <= SEG_1;
            when '1' =>
                AN <= "1101";
                SEG_out <= SEG_2;
            when others =>
                AN <= "XXXX";
                SEG_out <= "XXXXXXX";
        end case;
    end process;
end Behavioral;