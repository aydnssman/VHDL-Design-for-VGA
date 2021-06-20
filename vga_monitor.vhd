library ieee;
use ieee.std_logic_1164.all;

entity vga_monitor is
 port(clk, reset:     in std_logic;
      Hsync, Vsync:   buffer std_logic;
      r, g, b:        out std_logic;
      nblanck, nsync: out std_logic);
 end vga_monitor;

architecture Behavioral of vga_monitor is

 constant h1: integer:= 96;
 constant h2: integer:= 144;
 constant h3: integer:= 784;
 constant h4: integer:= 800;
 constant v1: integer:= 2;
 constant v2: integer:= 35;
 constant v3: integer:= 515;
 constant v4: integer:= 525;

 signal Hactive, Vactive, dena: std_logic;
 signal pixel_clk, pixel_clk1: std_logic;
 signal Vcount: positive range 1 to v4;
 signal Hcount: positive range 1 to h4;

 begin
 dena <= Hactive and Vactive;
 nblanck <= '1';
 nsync <= '0';

  p1: process(clk)
  begin
   if(clk'event and clk='1') then
    pixel_clk1 <= not pixel_clk1;
   end if;
  end process;
  
  p2: process(pixel_clk1)
  begin
   if(pixel_clk1'event and pixel_clk1='1') then
    pixel_clk <= not pixel_clk;
   end if;
  end process;

  p3: process(pixel_clk)
  begin
   if(pixel_clk'event and pixel_clk='1') then
   Hcount <= Hcount + 1;
    if(Hcount=h1) then
     Hsync <= '1';
    elsif (Hcount=h2) then
     Hactive <= '1';
    elsif (Hcount=h3) then
     Hactive <= '0';
    elsif (Hcount=h4) then
     Hsync <='0';
     Hcount <= 1;
    end if; 
   end if;
  end process;
  
  p4: process(Hsync)
  begin
   if(Hsync'event and Hsync='0') then
    Vcount <= Vcount + 1;
    if(Vcount=v1) then
     Vsync <= '1';
    elsif (Vcount=v2) then
     Vactive <= '1';
    elsif (Vcount=v3) then
     Vactive <= '0';
    elsif (Vcount=v4) then
     Vsync <= '0';
     Vcount <= 1;
    end if;
   end if;
  end process;
  
  AYDIN: process(pixel_clk)
  begin
  if(dena='1') then
  --  A
   if(HCount>=195 and HCount<=205 and Vcount>225 and Vcount<265) then
    r<='0'; 
    g<='1';
    b<='0';
    elsif(HCount>=205 and HCount<=235 and Vcount>215 and Vcount<225) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=205 and HCount<=235 and Vcount>235 and Vcount<245) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=235 and HCount<=245 and Vcount>225 and Vcount<265) then
     r<='0'; 
     g<='1';
     b<='0';
  -- Y
    elsif(HCount>=255 and HCount<=265 and Vcount>215 and Vcount<235) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=265 and HCount<=295 and Vcount>235 and Vcount<245) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=275 and HCount<=285 and Vcount>245 and Vcount<265) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=295 and HCount<=305 and Vcount>215 and Vcount<235) then
     r<='0'; 
     g<='1';
     b<='0';   
  -- D
    elsif(HCount>=315 and HCount<=325 and Vcount>215 and Vcount<265) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=325 and HCount<=355 and Vcount>215 and Vcount<225) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=325 and HCount<=355 and Vcount>255 and Vcount<265) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=355 and HCount<=365 and Vcount>225 and Vcount<255) then
     r<='0'; 
     g<='1';
     b<='0';
  -- I
    elsif(HCount>=375 and HCount<=385 and Vcount>215 and Vcount<265) then
     r<='0'; 
     g<='1';
     b<='0';
  -- N
    elsif(HCount>=395 and HCount<=405 and Vcount>215 and Vcount<265) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=405 and HCount<=415 and Vcount>225 and Vcount<235) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=415 and HCount<=425 and Vcount>235 and Vcount<245) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=425 and HCount<=435 and Vcount>245 and Vcount<255) then
     r<='0'; 
     g<='1';
     b<='0';
    elsif(HCount>=435 and HCount<=445 and Vcount>215 and Vcount<265) then
     r<='0'; 
     g<='1';
     b<='0'; 
    else
     r<='0'; 
     g<='0';
     b<='0';
    end if;
   end if;
  end process;
end Behavioral;