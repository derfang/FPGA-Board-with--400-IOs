-- vhdl-linter-disable unused
-- in this code we implement a RSI422 sender and receiver
-- RS422 is a differential serial protocol meaning that the signal is sent on two wires with opposite voltages
-- the receiver is a differential amplifier that amplifies the difference between the two signals
-- we send the signals in 8 bit chunks with a start bit and a stop bit (1 start bit, 8 data bits, 1 stop bit)
-- the start bit is always 0 and the stop bit is always 1 but we use active HIGH signals
-- the data bits are sent LSB first
-- buffer is placed after the FPGA so we onlt need 10TX and 10RX lines (as opposed to 20TX and 20RX lines)
-- there also need to be a RTS and CTS line to control the flow of data

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RS422 is
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

end RS422;

architecture RS422_arch of RS422 is
    
    signal data_out_buffer : std_logic_vector(79 downto 0);
    signal data_out_buffer0 : std_logic_vector(9 downto 0);
    signal data_out_buffer1 : std_logic_vector(9 downto 0);
    signal data_out_buffer2 : std_logic_vector(9 downto 0);
    signal data_out_buffer3 : std_logic_vector(9 downto 0);
    signal data_out_buffer4 : std_logic_vector(9 downto 0);
    signal data_out_buffer5 : std_logic_vector(9 downto 0);
    signal data_out_buffer6 : std_logic_vector(9 downto 0);
    signal data_out_buffer7 : std_logic_vector(9 downto 0);


    signal data_in_buffer : std_logic_vector(79 downto 0);
    signal data_in_buffer0 : std_logic_vector(9 downto 0);
    signal data_in_buffer1 : std_logic_vector(9 downto 0);
    signal data_in_buffer2 : std_logic_vector(9 downto 0);
    signal data_in_buffer3 : std_logic_vector(9 downto 0);
    signal data_in_buffer4 : std_logic_vector(9 downto 0);
    signal data_in_buffer5 : std_logic_vector(9 downto 0);
    signal data_in_buffer6 : std_logic_vector(9 downto 0);
    signal data_in_buffer7 : std_logic_vector(9 downto 0);

    
    type state_type is (idle, request_to_send, sending_start_bit, send_0, send_1, send_2, send_3, send_4, send_5, send_6, send_7, send_stop_bit);
    signal state : state_type := idle;
begin
    data_in_buffer0 <= data_in_buffer(9 downto 0);
    data_in_buffer1 <= data_in_buffer(19 downto 10);
    data_in_buffer2 <= data_in_buffer(29 downto 20);
    data_in_buffer3 <= data_in_buffer(39 downto 30);
    data_in_buffer4 <= data_in_buffer(49 downto 40);
    data_in_buffer5 <= data_in_buffer(59 downto 50);
    data_in_buffer6 <= data_in_buffer(69 downto 60);
    data_in_buffer7 <= data_in_buffer(79 downto 70);

    data_out_buffer(9 downto 0) <= data_out_buffer0;
    data_out_buffer(19 downto 10) <= data_out_buffer1;
    data_out_buffer(29 downto 20) <= data_out_buffer2;
    data_out_buffer(39 downto 30) <= data_out_buffer3;
    data_out_buffer(49 downto 40) <= data_out_buffer4;
    data_out_buffer(59 downto 50) <= data_out_buffer5;
    data_out_buffer(69 downto 60) <= data_out_buffer6;
    data_out_buffer(79 downto 70) <= data_out_buffer7;


    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when idle =>
                    if send = '1' then
                        data_in_buffer <= data_in;
                        ready <= '0';
                        state <= request_to_send;
                    end if;
                when request_to_send =>
                    RTS <= '1';
                    if CTS = '1' then
                        RTS <= '0';
                        state <= sending_start_bit;
                    end if;
                when sending_start_bit =>
                    TX <= "0000000000";
                    state <= send_0;
                when send_0 =>
                    TX <= data_in_buffer0;
                    state <= send_1;
                when send_1 =>
                    TX <= data_in_buffer1;
                    state <= send_2;
                when send_2 =>
                    TX <= data_in_buffer2;
                    state <= send_3;
                when send_3 =>
                    TX <= data_in_buffer3;
                    state <= send_4;
                when send_4 =>
                    TX <= data_in_buffer4;
                    state <= send_5;
                when send_5 =>
                    TX <= data_in_buffer5;
                    state <= send_6;
                when send_6 =>
                    TX <= data_in_buffer6;
                    state <= send_7;
                when send_7 =>
                    TX <= data_in_buffer7;
                    state <= send_stop_bit;
                when send_stop_bit =>
                    TX <= "1111111111";
                    ready <= '1';
                    state <= idle;
            end case;
        end if;
        if falling_edge(clk) then
            case state is
                when idle =>
                    data_out <= data_out_buffer;
                when request_to_send =>
                    null;
                when sending_start_bit =>
                    null;
                when send_0 =>
                    null;
                when send_1 =>
                    data_out_buffer0 <= RX;
                when send_2 =>
                    data_out_buffer1 <= RX;
                when send_3 =>
                    data_out_buffer2 <= RX;
                when send_4 =>
                    data_out_buffer3 <= RX;
                when send_5 =>
                    data_out_buffer4 <= RX;
                when send_6 =>
                    data_out_buffer5 <= RX;
                when send_7 =>
                    data_out_buffer6 <= RX;
                when send_stop_bit =>
                    data_out_buffer7 <= RX;
            end case;
        end if;
    end process;

end RS422_arch;

                    