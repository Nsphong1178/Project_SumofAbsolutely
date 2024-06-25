-- Entity Declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.myLib.all;
entity Accumulator is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        enable   : in  STD_LOGIC;
        A        : in  STD_LOGIC_VECTOR(7 downto 0);
        SUM      : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Accumulator;

-- Architecture Body
architecture Behavioral of Accumulator is
    signal accum_value : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    process (clk, reset)
    begin
        if reset = '1' then
            accum_value <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                accum_value <= accum_value + A;
            end if;
        end if;
    end process;

    SUM <= accum_value;
end Behavioral;

