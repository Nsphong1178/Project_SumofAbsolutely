
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.myLib.all;
ENTITY testController IS
END testController;

ARCHITECTURE tb_arch OF testController IS

    -- Constants for clock period and half period
    CONSTANT clk_period : TIME := 10 ns;
    CONSTANT half_clk_period : TIME := clk_period / 2;

    -- Signals for testbench
    SIGNAL Clock, Reset, Start, test_i : std_logic := '0';
    SIGNAL RE_A, RE_B, WE_A, WE_B, LD_i, En_i, EN_Sum, Done : std_logic;

BEGIN

    -- Instantiate the Controller
    DUT: controller
        PORT MAP (
            Clock => Clock,
            Reset => Reset,
            Start => Start,
            RE_A => RE_A,
            RE_B => RE_B,
            WE_A => WE_A,
            WE_B => WE_B,
            LD_i => LD_i,
            En_i => En_i,
            EN_Sum => EN_Sum,
            test_i => test_i,
            Done => Done
        );

    -- Clock process
    Clock_Process: PROCESS
    BEGIN
        while now < 1000 ns loop
            Clock <= '0';
            wait for half_clk_period;
            Clock <= '1';
            wait for half_clk_period;
        end loop;
        wait;
    END PROCESS Clock_Process;

    -- Stimulus process
    Stimulus: PROCESS
    BEGIN
	Reset <= '0';
        Start <= '1';
	test_i <= '0';

        -- Add more stimulus as needed to test different scenarios

        wait for 100 ns;
        -- End simulation
        wait;
    END PROCESS Stimulus;

    -- Add assertions or checks if necessary

END tb_arch;
