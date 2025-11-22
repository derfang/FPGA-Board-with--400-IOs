-- vhdl-linter-disable unused
-- test bench for RS422

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RS422_tb is
end RS422_tb;

architecture test of RS422_tb is

    component RS422 is
        port(
        clk : in std_logic;
        data_in : in std_logic_vector(79 downto 0); -- 10 bytes of data
        data_out : out std_logic_vector(79 downto 0); -- 10 bytes of data
        RTS : out std_logic := '0';
        CTS : in std_logic := '0';
        TX : out std_logic_vector(9 downto 0);
        RX : in std_logic_vector(9 downto 0);
        send : in std_logic;
        ready : out std_logic
    );
    end component;

    signal clk : std_logic := '0';
    signal data_in1 : std_logic_vector(79 downto 0) := (others => '0');
    signal data_in2 : std_logic_vector(79 downto 0) := (others => '0');
    signal data_out2 : std_logic_vector(79 downto 0) := (others => '0');
    signal data_out1 : std_logic_vector(79 downto 0) := (others => '0');

    signal RTS : std_logic := '0';
    signal CTS : std_logic := '0';
    signal TX1 : std_logic_vector(9 downto 0) := (others => '0');
    signal RX1 : std_logic_vector(9 downto 0) := (others => '0');
    signal TX2 : std_logic_vector(9 downto 0) := (others => '0');
    signal RX2 : std_logic_vector(9 downto 0) := (others => '0');

    signal send : std_logic := '0';
    signal ready : std_logic := '0';

        -- Procedure for clock generation
    procedure clk_gen(signal clkin : out std_logic; constant FREQ : real ; constant DUTY_CYCLE_PERSENTAGE : real) is
        constant PERIOD    : time := 1 sec / FREQ;        -- Full period
        constant HIGH_TIME : time := PERIOD * DUTY_CYCLE_PERSENTAGE/100.0;  -- High time; always < PERIOD
        constant LOW_TIME  : time := PERIOD - HIGH_TIME;  -- Low time; PERIOD = HIGH_TIME + LOW_TIME
    begin
                -- Check the arguments
        -- assert (HIGH_TIME /= 0 fs) report "clk_plain: High time is zero; time resolution to large for frequency" severity FAILURE;
        -- Generate a clock cycle
        loop
            clkin <= '0';
            wait for HIGH_TIME;
            clkin <= '1';
            wait for LOW_TIME;
        end loop;
    end procedure;

begin
    
        -- Instantiate the Unit Under Test (UUT)
        -- we make two instances of the unit under test to test the full duplex functionality

        uut1: RS422 port map (
            clk => clk,
            data_in => data_in1,
            data_out => data_out1,
            RTS => RTS,
            CTS => CTS,
            TX => TX1,
            RX => RX1,
            send => send,
            ready => ready
        );

        uut2: RS422 port map (
            clk => clk,
            data_in => data_in2,
            data_out => data_out2,
            RTS => RTS,
            CTS => CTS,
            TX => TX2,
            RX => RX2,
            send => send,
            ready => ready
        );

        RX1 <= TX2;
        RX2 <= TX1;
        -- Clock making
        clk_gen(clk, 1.0e6, 50.0); -- 100 MHz clock with 50% duty cycle is T = 1 us
        
        -- Stimulus process
        stim_proc: process
        begin
            -- hold reset state for 100 ns.
            wait for 1 us;
            
            -- insert stimulus here
            -- data_in1 <= x"FAFAFAFAFAFAFAFAFAFA";
            -- data_in2 <= x"5A5A5A5A5A5A5A5A5A5A";
            data_in1 <= x"00000000000000000000";
            data_in2 <= x"FFFFFFFFFFFFFFFFFFFF";
            wait for 1 us;

            send <= '1';
            wait for 1 us;
            CTS <= '1';
            send <= '0';
            wait;
        end process;
    
end test;

