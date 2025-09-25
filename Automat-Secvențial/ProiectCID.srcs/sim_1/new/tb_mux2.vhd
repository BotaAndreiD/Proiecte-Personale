library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux2 is
end tb_mux2;

architecture sim of tb_mux2 is
    -- Importeaz? entitatea mux2
    component mux2
        Port ( i0 : in STD_LOGIC;
               i1 : in STD_LOGIC;
               a : in STD_LOGIC;
               y : out STD_LOGIC);
    end component;

    -- Declara?iile semnalelor pentru testbench
    signal tb_i0, tb_i1, tb_a, tb_y : STD_LOGIC := '0';

begin
    -- Instan?iaz? multiplexorul
    uut: mux2 port map (i0 => tb_i0, i1 => tb_i1, a => tb_a, y => tb_y);

    -- Proces de stimulare
    process
    begin
        -- Test 1: a = '0', selecteaz? i0
        tb_i0 <= '1';
        tb_i1 <= '0';
        tb_a <= '0';
        wait for 10 ns;

        -- Test 2: a = '1', selecteaz? i1
        tb_i0 <= '0';
        tb_i1 <= '1';
        tb_a <= '0';
        wait for 10 ns;

        -- Alte teste pot fi ad?ugate aici
 tb_i0 <= '0';
        tb_i1 <= '1';
        tb_a <= '1';
        wait for 10 ns;
        
         tb_i0 <= '1';
        tb_i1 <= '0';
        tb_a <= '1';
        wait for 10 ns;
        
        
        wait;
    end process;


end sim;
