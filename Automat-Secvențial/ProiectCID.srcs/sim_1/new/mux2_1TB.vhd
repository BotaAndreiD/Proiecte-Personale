----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/02/2024 10:56:32 PM
-- Design Name: 
-- Module Name: mux2_1TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2_1TB is
--  Port ( );
end mux2_1TB;

architecture Behavioral of mux2_1TB is
 signal I0, I1, A, Y : STD_LOGIC;

    component Mux2_1
        Port ( I0 : out STD_LOGIC;
               I1 : in STD_LOGIC;
               A : in STD_LOGIC;
               Y : out STD_LOGIC);
    end component;
    
begin

 UUT: Mux2_1 port map (
        I0 => I0,
        I1 => I1,
        A => A,
        Y => Y
    );
 process
    begin
        -- Set?m valorile de intrare
        I0 <= '0';
        I1 <= '1';
        A <= '0';

        -- A?tept?m pentru o perioad? de timp
        wait for 10 ns;

        -- Schimb?m valoarea lui A
        A <= '1';

        -- A?tept?m pentru o perioad? de timp
        wait for 10 ns;

        -- Ad?ug? orice alte teste sau ac?iuni dorite

        wait;
    end process;
end Behavioral;
