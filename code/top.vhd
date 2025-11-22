-- vhdl-linter-disable unused
-- top module containing all ports and instantiations

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
    port (
        clk50MHz : in std_logic;
        toIOB4_SCK : out std_logic;
        toIOB4_NSS : out std_logic;
        toIOB4_MOSI : out std_logic;
        toIOB4_MISO : in std_logic;
        toIOB6_SCK : out std_logic;
        toIOB6_NSS : out std_logic;
        toIOB5_MISO : in std_logic;
        toIOB7_MOSI : out std_logic;
        toIOB7_SCK : out std_logic;
        toIOB7_NSS : out std_logic;
        toIOB6_MOSI : out std_logic;
        toIOB7_MISO : in std_logic;
        toIOB6_MISO : in std_logic;
        toIOB5_SCK : out std_logic;
        toIOB3_MISO : in std_logic;
        toIOB5_NSS : out std_logic;
        toIOB5_MOSI : out std_logic;
        toIOB3_NSS : out std_logic;
        toIOB3_SCK : out std_logic;
        toIOB3_MOSI : out std_logic;
        toIOB2_NSS : out std_logic;
        toIOB2_MISO : in std_logic;
        toIOB2_SCK : out std_logic;
        toIOB2_MOSI : out std_logic;
        toIOB8_SCK : out std_logic;
        toIOB8_NSS : out std_logic;
        toIOB8_MOSI : out std_logic;
        toIOB8_MISO : in std_logic;
        toIOB9_SCK : out std_logic;
        toIOB9_NSS : out std_logic;
        toIOB9_MOSI : out std_logic;
        toIOB9_MISO : in std_logic;
        toIOB10_SCK : out std_logic;
        toIOB10_NSS : out std_logic;
        toIOB10_MOSI : out std_logic;
        toIOB10_MISO : in std_logic;
        TXD3 : out std_logic;
        RXD3 : in std_logic;
        TXD2 : out std_logic;
        RXD2 : in std_logic;
        DIR2 : out std_logic;
        DIR1 : out std_logic;
        TXD1 : out std_logic;
        RXD1 : in std_logic;
        DIR3 : out std_logic;
        TXD4 : out std_logic;
        RXD4 : in std_logic;
        DIR4 : out std_logic;
        TXD5 : out std_logic;
        RXD5 : in std_logic;
        DIR5 : out std_logic;
        QSPI_CLK : out std_logic;
        QSPI_D0 : inout std_logic;
        QSPI_D1 : inout std_logic;
        QSPI_D2 : inout std_logic;
        QSPI_D3 : inout std_logic;
        TDI : in std_logic;
        TDO : out std_logic;
        TCK : in std_logic;
        TMS : in std_logic;
        toIOB1_SCK : out std_logic;
        toIOB1_NSS : out std_logic;
        toIOB1_MOSI : out std_logic;
        toIOB1_MISO : in std_logic;
        RGMII_TXCLK : out std_logic;
        RGMII_TXD0 : out std_logic;
        RGMII_TXD1 : out std_logic;
        RGMII_TXD2 : out std_logic;
        RGMII_TXD3 : out std_logic;
        RGMII_TXEN : out std_logic;
        RGMII_RXCLK : in std_logic;
        RGMII_RXD0 : in std_logic;
        RGMII_RXD1 : in std_logic;
        RGMII_RXD2 : in std_logic;
        RGMII_RXD3 : in std_logic;
        RGMII_RXDV : in std_logic;
        RGMII_MDC : out std_logic;
        RGMII_MDIO : inout std_logic;
        ENET_REF_CLK : in std_logic;
        RGMII_INT : in std_logic;
        DIR10 : out std_logic;
        TXD10 : out std_logic;
        RXD10 : in std_logic;
        PL_CLK : out std_logic;
        TXD8 : out std_logic;
        RXD8 : in std_logic;
        TXD7 : out std_logic;
        RXD7 : in std_logic;
        DIR7 : out std_logic;
        DIR8 : out std_logic;
        DIR6 : out std_logic;
        TXD6 : out std_logic;
        TXD9 : out std_logic;
        RXD9 : in std_logic;
        DIR9 : out std_logic;
        RXD6 : in std_logic
        );
end entity top;

architecture rtl of top is

begin
    DIR8 <= '1';
    DIR7 <= '1';
end architecture rtl;