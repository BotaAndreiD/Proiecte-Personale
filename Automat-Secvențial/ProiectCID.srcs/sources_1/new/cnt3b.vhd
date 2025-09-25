
-- Compan
-- Engineer: 
-- 
-- Create Date: 01/03/2024 12:02:47 PM
-- Design Name: 
-- Module Name: cnt3b - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cnt3b is
    Port ( d : in STD_LOGIC_VECTOR (2 downto 0);
           r : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           ld : in STD_LOGIC;
           c : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (2 downto 0));
end cnt3b;

architecture Behavioral of cnt3b is

signal qint : std_logic_vector (2 downto 0);

begin 

count3b: process (r,clk)

begin

if r = '1' then 

qint <="000";
elsif (rising_edge(clk) and ld = '1' ) then 
 if (d = "110") then
      qint <= "011"; 
      end if;
      if (d = "000") then
      qint <= "100"; 
      end if;
      if (d = "111") then
      qint <= "000"; 
      end if;
      if (d = "011") then
      qint <= "001"; 
      end if;
      if (d = "001") then
      qint <= "111"; 
      end if;
      if (d = "100") then
      qint <= "110"; 
      end if;
elsif (rising_edge(clk) and ld ='0' and en = '0' ) then
qint <= qint + 1;
else
    qint <= qint;
end if ;

end process;
q <= qint;
end Behavioral;
