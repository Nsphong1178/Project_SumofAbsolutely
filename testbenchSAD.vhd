library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.myLib.all;
entity testbenchSAD is
end entity testbenchSAD;

architecture testbench of testbenchSAD is

    -- Constants for testbench
    constant DATA_WIDTH : integer := 8;
    constant ADDR_WIDTH : integer := 2;

    -- Signals to connect to SAD
    signal Clock, Reset, Start : std_logic;
    signal WE_A, WE_B : std_logic;
    signal dataA, dataB : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal addrIn_A, addrIn_B : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal Done : std_logic;
    signal Sum_out : std_logic_vector(DATA_WIDTH - 1 downto 0);

begin

    -- Instantiate the SAD
    UUT: entity work.SAD
        generic map (
            DATA_WIDTH => DATA_WIDTH,
            ADDR_WIDTH => ADDR_WIDTH
        )
        port map (
            Clock => Clock,
            Reset => Reset,
            Start => Start,
            WE_A => WE_A,
            WE_B => WE_B,
            dataA => dataA,
            dataB => dataB,
            addrIn_A => addrIn_A,
            addrIn_B => addrIn_B,
            Done => Done,
            Sum_out => Sum_out
        );

    -- Clock generation
    Clock_sig: process
    begin
        while true loop
            Clock <= '0';
            wait for 10 ns;
            Clock <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- Stimulus process
    Stimulus: process
    begin
        -- Initialize signals
        Reset <= '0';
        Start <= '0';
        WE_A <= '0';
        WE_B <= '0';
        dataA <= (others => '0');
        dataB <= (others => '0');
        addrIn_A <= (others => '0');
        addrIn_B <= (others => '0');

        -- Apply reset
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';
        wait for 20 ns;

        -- Start the process
        Start <= '1';
        wait for 20 ns;
        Start <= '0';
        wait for 40 ns;

        -- Load data for matrix 2x2 (A and B)
        -- A = [1, 2; 3, 4]
        -- B = [5, 6; 7, 8]

        -- Load values into memory block A
        dataA <= "00000010";  -- 1
        WE_A <= '1';
        wait for 20 ns;
        WE_A <= '0';

        dataA <= "00000001";  -- 2
        addrIn_A <= "01";
        WE_A <= '1';
        wait for 20 ns;
        WE_A <= '0';

        dataA <= "00000000";  -- 3
        addrIn_A <= "10";
        WE_A <= '1';
        wait for 20 ns;
        WE_A <= '0';

        dataA <= "00000100";  -- 4
        addrIn_A <= "11";
        WE_A <= '1';
        wait for 20 ns;
        WE_A <= '0';

        -- Load values into memory block B
        dataB <= "00000101";  -- 5
        WE_B <= '1';
        wait for 20 ns;
        WE_B <= '0';

        dataB <= "00000110";  -- 6
        addrIn_B <= "01";
        WE_B <= '1';
        wait for 20 ns;
        WE_B <= '0';

        dataB <= "00000111";  -- 7
        addrIn_B <= "10";
        WE_B <= '1';
        wait for 20 ns;
        WE_B <= '0';

        dataB <= "00001000";  -- 8
        addrIn_B <= "11";
        WE_B <= '1';
        wait for 20 ns;
        WE_B <= '0';

        -- Enable computation and wait for completion
        Start <= '1';
        wait until Done = '1';
        Start <= '0';
        wait for 100 ns;

        -- After computation is done, assert reset
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';

        -- Wait indefinitely to keep simulation alive
        wait;
    end process;

end architecture testbench;

