library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_cnt3b is
end tb_cnt3b;

architecture sim of tb_cnt3b is
  -- Importeaz? entitatea counter-ului
  component cnt3b
    Port ( d : in STD_LOGIC_VECTOR (2 downto 0);
           r : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           ld : in STD_LOGIC;
            c : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (2 downto 0));
  end component;

  component mux2 is
    Port ( i0 : in STD_LOGIC;
           i1 : in STD_LOGIC;
           a : in STD_LOGIC;
           y : out STD_LOGIC);
  end component;

  -- Declara?ii de semnale pentru testbench
  signal tb_clk, tb_r, tb_en, tb_ld, tb_qc, tb_yb3,tb_ya2: STD_LOGIC := '0';
  signal tb_d, tb_q : STD_LOGIC_VECTOR (2 downto 0) := "000";
  signal tb_i0b1,tb_i1b2,tb_ab1,tb_yb1:std_logic;
  signal tb_i0b3,tb_i1b4,tb_ab2,tb_yb2:std_logic;
  signal tb_i0b5,tb_i1b6,tb_ab3:std_logic;
  signal tb_i0a1,tb_i1a2,tb_aa1,tb_ya1:std_logic;
 signal tb_i0a3,tb_i1a4,tb_aa2:std_logic;


begin
  -- Instan?iaz? counter-ul
  uut_counter: cnt3b
    port map (d => tb_d, r => tb_r, clk => tb_clk, en => tb_en, ld => tb_ld, q => tb_q, c => tb_qc);

  -- Instan?iaz? multiplexorul pentru B
  uut_muxload_b1: mux2
    port map (i0 => tb_i0b1, i1 => tb_i1b2, a => tb_ab1, y => tb_yb1);

  uut_muxload_b2: mux2
   port map (i0 => tb_i0b3, i1 => tb_i1b4, a => tb_ab2, y => tb_yb2);

  uut_muxload_b3: mux2
   port map (i0 => tb_i0b5, i1 => tb_i1b6, a => tb_ab3, y => tb_yb3);

  -- Instan?iaz? multiplexorul pentru A
  uut_muxload_a1: mux2
     port map (i0 => tb_i0a1, i1 => tb_i1a2, a => tb_aa1, y => tb_ya1);

  uut_muxload_a2: mux2
   port map (i0 => tb_i0a3, i1 => tb_i1a4, a => tb_aa2, y => tb_ya2);
  process
  begin
    wait for 5 ns;
    tb_clk <= not tb_clk;
  end process;

  -- Procesul de stimulare
  process
  begin

tb_r <='1';
 tb_i0b1 <= '0'; --intrare i0 la primul muxB
   tb_i1b2 <= '0'; --intrare i1 la primul muxB
   tb_ab1<= '0'; --adresa a la primul muxB
   
    tb_i0b3 <= '0'; --intrare i0 la al doilea muxB
   tb_i1b4 <=  '0'; --intrare i1 la al doilea muxB
   tb_ab2<= '0'; --adresa a la al doilea muxB
   
      tb_i0b5 <= '0'; --intrare i0 la ultimul muxB
    tb_i1b6 <= '0';  --intrare i1 la ultimul mux B
   tb_ab3<= '0';      --adresa la ultimul muxB
   
      tb_i0a1 <= '0'; --intrare i0 la primul muxA
   tb_i1a2 <= '0';  --intrare i1 la primul muxA
   tb_aa1<= '0';   --adresa  la primul muxA
   
     tb_i0a3 <= '0';   --intrare i0 la ultimul muxA
   tb_i1a4 <= '0';    --intrare i1 la ultimul muxA
   tb_aa2<= '0';     --adresa la ultimuk muxA
   
wait for 5ns;
tb_r <='0';
  tb_ld<='1';
  tb_d<="000";
  tb_qc<='1';
   tb_i0b1 <= '0'; --intrare i0 la primul muxB
   tb_i1b2 <= '0'; --intrare i1 la primul muxB
   tb_ab1<= '0'; --adresa a la primul muxB
   
    tb_i0b3 <= '1'; --intrare i0 la al doilea muxB
   tb_i1b4 <=  '1'; --intrare i1 la al doilea muxB
   tb_ab2<= '0'; --adresa a la al doilea muxB
   
      tb_i0b5 <= '0'; --intrare i0 la ultimul muxB
    tb_i1b6 <= '1';  --intrare i1 la ultimul mux B
   tb_ab3<= '0';      --adresa la ultimul muxB
   
      tb_i0a1 <= '1'; --intrare i0 la primul muxA
   tb_i1a2 <= '0';  --intrare i1 la primul muxA
   tb_aa1<= '0';   --adresa  la primul muxA
   
     tb_i0a3 <= '0';   --intrare i0 la ultimul muxA
   tb_i1a4 <= '1';    --intrare i1 la ultimul muxA
   tb_aa2<= '0';     --adresa la ultimuk muxA
   
   wait for 10 ns;
    tb_ld<='1';
   tb_d<="100";
   tb_qc <= '1';
   tb_i0b1 <= '0'; --intrare i0 la primul muxB
   tb_i1b2 <= '0'; --intrare i1 la primul muxB
   tb_ab1<= '0'; --adresa a la primul muxB
   
    tb_i0b3 <= '1'; --intrare i0 la al doilea muxB
   tb_i1b4 <=  '1'; --intrare i1 la al doilea muxB
   tb_ab2<= '0'; --adresa a la al doilea muxB
   
      tb_i0b5 <= '0'; --intrare i0 la ultimul muxB
    tb_i1b6 <= '1';  --intrare i1 la ultimul mux B
   tb_ab3<= '1';      --adresa la ultimul muxB
   
      tb_i0a1 <= '1'; --intrare i0 la primul muxA
   tb_i1a2 <= '0';  --intrare i1 la primul muxA
   tb_aa1<= '0';   --adresa  la primul muxA
   
     tb_i0a3 <= '1';   --intrare i0 la ultimul muxA
   tb_i1a4 <= '0';    --intrare i1 la ultimul muxA
   tb_aa2<= '1';     --adresa la ultimuk muxA
   
   wait for 10 ns;
   
     tb_ld<='1';
   tb_d<="110";
   tb_qc <= '0';
   tb_i0b1 <= '0'; --intrare i0 la primul muxB
   tb_i1b2 <= '0'; --intrare i1 la primul muxB
   tb_ab1<= '1'; --adresa a la primul muxB
   
    tb_i0b3 <= '1'; --intrare i0 la al doilea muxB
   tb_i1b4 <=  '1'; --intrare i1 la al doilea muxB
   tb_ab2<= '1'; --adresa a la al doilea muxB
   
      tb_i0b5 <= '0'; --intrare i0 la ultimul muxB
    tb_i1b6 <= '1';  --intrare i1 la ultimul mux B
   tb_ab3<= '1';      --adresa la ultimul muxB
   
      tb_i0a1 <= '1'; --intrare i0 la primul muxA
   tb_i1a2 <= '0';  --intrare i1 la primul muxA
   tb_aa1<= '1';   --adresa  la primul muxA
   
     tb_i0a3 <= '0';   --intrare i0 la ultimul muxA
   tb_i1a4 <= '1';    --intrare i1 la ultimul muxA
   tb_aa2<= '1';     --adresa la ultimuk muxA
   
   wait for 10 ns;
   
     tb_ld<='1';
   tb_d<="011";
   tb_qc <= '0';
   tb_i0b1 <= '1'; --intrare i0 la primul muxB
   tb_i1b2 <= '0'; --intrare i1 la primul muxB
   tb_ab1<= '1'; --adresa a la primul muxB
   
    tb_i0b3 <= '1'; --intrare i0 la al doilea muxB
   tb_i1b4 <=  '0'; --intrare i1 la al doilea muxB
   tb_ab2<= '1'; --adresa a la al doilea muxB
   
      tb_i0b5 <= '0'; --intrare i0 la ultimul muxB
    tb_i1b6 <= '0';  --intrare i1 la ultimul mux B
   tb_ab3<= '1';      --adresa la ultimul muxB
   
      tb_i0a1 <= '0'; --intrare i0 la primul muxA
   tb_i1a2 <= '0';  --intrare i1 la primul muxA
   tb_aa1<= '1';   --adresa  la primul muxA
   
     tb_i0a3 <= '1';   --intrare i0 la ultimul muxA
   tb_i1a4 <= '0';    --intrare i1 la ultimul muxA
   tb_aa2<= '0';     --adresa la ultimuk muxA
   
   wait for 10 ns;
   tb_en <='1';
   wait for 5 ns;
   tb_en <='0';
     tb_ld<='1';
   tb_d<="001";
   tb_qc <= '1';
   tb_i0b1 <= '0'; --intrare i0 la primul muxB
   tb_i1b2 <= '0'; --intrare i1 la primul muxB
   tb_ab1<= '0'; --adresa a la primul muxB
   
    tb_i0b3 <= '1'; --intrare i0 la al doilea muxB
   tb_i1b4 <=  '0'; --intrare i1 la al doilea muxB
   tb_ab2<= '0'; --adresa a la al doilea muxB
   
      tb_i0b5 <= '1'; --intrare i0 la ultimul muxB
    tb_i1b6 <= '0';  --intrare i1 la ultimul mux B
   tb_ab3<= '0';      --adresa la ultimul muxB
   
      tb_i0a1 <= '0'; --intrare i0 la primul muxA
   tb_i1a2 <= '0';  --intrare i1 la primul muxA
   tb_aa1<= '0';   --adresa  la primul muxA
   
     tb_i0a3 <= '1';   --intrare i0 la ultimul muxA
   tb_i1a4 <= '0';    --intrare i1 la ultimul muxA
   tb_aa2<= '0';     --adresa la ultimuk muxA
   
   wait for 10 ns;
   
     tb_ld<='1';
   tb_d<="111";
   tb_qc <= '0';
   tb_i0b1 <= '1'; --intrare i0 la primul muxB
   tb_i1b2 <= '0'; --intrare i1 la primul muxB
   tb_ab1<= '1'; --adresa a la primul muxB
   
    tb_i0b3 <= '1'; --intrare i0 la al doilea muxB
   tb_i1b4 <=  '0'; --intrare i1 la al doilea muxB
   tb_ab2<= '1'; --adresa a la al doilea muxB
   
      tb_i0b5 <= '0'; --intrare i0 la ultimul muxB
    tb_i1b6 <= '0';  --intrare i1 la ultimul mux B
   tb_ab3<= '1';      --adresa la ultimul muxB
   
      tb_i0a1 <= '0'; --intrare i0 la primul muxA
   tb_i1a2 <= '0';  --intrare i1 la primul muxA
   tb_aa1<= '1';   --adresa  la primul muxA
   
     tb_i0a3 <= '1';   --intrare i0 la ultimul muxA
   tb_i1a4 <= '0';    --intrare i1 la ultimul muxA
   tb_aa2<= '1';     --adresa la ultimuk muxA
   
   wait for 10 ns;
   tb_r <='1';
    wait;

  end process;

end sim;
