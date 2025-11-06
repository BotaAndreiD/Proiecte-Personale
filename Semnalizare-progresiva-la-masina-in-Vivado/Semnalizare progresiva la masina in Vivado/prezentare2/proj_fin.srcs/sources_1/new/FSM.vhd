library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Port ( led : out STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           R : in STD_LOGIC;
           Le : in STD_LOGIC;
           Ri : in STD_LOGIC;
           Av : in STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

constant fdiv: integer := 25;
constant ndiv: integer := 10**8 / fdiv;

signal clkdiv : std_logic;

constant ncnt: integer := 32;
signal cntL: integer := 0;
signal cntR: integer := 0;
signal cntA: integer := 0;

signal ledL, ledR, ledA : std_logic_vector (15 downto 0) := x"0000";

begin

divider: process(R, CLK)
    variable q: integer := 0;
begin
    if R = '1' then
        q := 0;
        clkdiv <= '0';
    elsif rising_edge(CLK) then
        if q = ndiv - 1 then
            q := 0;
            clkdiv <= '1';
        else
            q := q + 1;
            clkdiv <= '0';
        end if; 
    end if;
end process;

counter1: process(R, clkdiv)
  variable cntR_local : integer := 0; 
begin
    if R = '1' then
        cntR_local := 0;
    elsif rising_edge(clkdiv) then    
      if Ri = '1' then
         if cntR_local = ncnt -1 then
            cntR_local := 0;
         else
            cntR_local := cntR_local + 1;
         end if;
      else
         cntR_local := 0;
      end if;
    end if;
    
    cntR <= cntR_local;
    
end process;

--- DCD
with cntR select
    ledR <=  "1000000000000000" when 0,
            "1100000000000000" when 1,
            "1110000000000000" when 2,
            "1111000000000000" when 3,
            "1111100000000000" when 4,
            "1111110000000000" when 5,
            "1111111000000000" when 6,
            "1111111100000000" when 7,
            "1111111110000000" when 8,
            "1111111111000000" when 9,
            "1111111111100000" when 10,
            "1111111111110000" when 11,
            "1111111111111000" when 12,
            "1111111111111100" when 13,
            "1111111111111110" when 14,
            "1111111111111111" when 15,
            "0000000000000000" when others;

counter2: process(R, clkdiv)
  variable cntL_local : integer := 0; 
begin
    if R = '1' then
        cntL_local := 0;
    elsif rising_edge(clkdiv) then    
      if Le = '1' then
         if cntL_local = ncnt -1 then
            cntL_local := 0;
         else
            cntL_local := cntL_local + 1;
         end if;
      else
         cntL_local := 0;
      end if;
    end if;
    
    cntL <= cntL_local;
    
end process;

with cntL select
    ledL <=  "0000000000000001" when 0,
            "0000000000000011" when 1,
            "0000000000000111" when 2,
            "0000000000001111" when 3,
            "0000000000011111" when 4,
            "0000000000111111" when 5,
            "0000000001111111" when 6,
            "0000000011111111" when 7,
            "0000000111111111" when 8,
            "0000001111111111" when 9,
            "0000011111111111" when 10,
            "0000111111111111" when 11,
            "0001111111111111" when 12,
            "0011111111111111" when 13,
            "0111111111111111" when 14,
            "1111111111111111" when 15,
            "0000000000000000" when others;

counter3: process(Av, clkdiv)
  variable cntA_local : integer := 0; 
begin
    if R = '1' then
        cntA_local := 0;
    elsif rising_edge(clkdiv) then    
      if Av = '1' then
         if cntA_local = ncnt -1 then
            cntA_local := 0;
         else
            cntA_local := cntA_local + 1;
         end if;
      else
         cntA_local := 0;
      end if;
    end if;
    
    cntA <= cntA_local;
    
end process;

with cntA select
    ledA <=  "0000000110000000" when 0,
            "0000001111000000" when 1,
            "0000011111100000" when 2,
            "0000111111110000" when 3,
            "0001111111111000" when 4,
            "0011111111111100" when 5,
            "0111111111111110" when 6,
            "1111111111111111" when 7,
            "0000000110000000" when 16,
            "0000001111000000" when 17,
            "0000011111100000" when 18,
            "0000111111110000" when 19,
            "0001111111111000" when 20,
            "0011111111111100" when 21,
            "0111111111111110" when 22,
            "1111111111111111" when 23,
            "0000000000000000" when others;


LED <= ledR when Ri = '1' and Le = '0' and Av = '0' 
  else ledL when Ri = '0' and Le = '1' and Av = '0'
  else ledA when ( Ri = '0' and Le = '0' and Av = '1') or ( Ri = '1' and Le = '1' and Av = '0')
  else x"0000";

end Behavioral;
