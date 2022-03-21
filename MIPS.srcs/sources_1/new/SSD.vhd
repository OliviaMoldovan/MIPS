----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 10:49:34 AM
-- Design Name: 
-- Module Name: SSD - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
Port( digit: in STD_LOGIC_VECTOR (15 downto 0);
    clk: in STD_LOGIC;
    cat:out STD_LOGIC_VECTOR (6 downto 0);
    an: out STD_LOGIC_VECTOR (3 downto 0));
end SSD;



architecture Behavioral of SSD is

signal cnt:STD_LOGIC_VECTOR(15 downto 0);
signal x:STD_LOGIC_VECTOR(3 downto 0);

begin

process(clk)
     begin 
        if rising_edge(clk) then
             cnt<=cnt+1;
        end if;
end process;

process (cnt)
  begin
   case cnt(15 downto 14) is
     when "00" => an <= "1110";
     when "01" => an <= "1101";
     when "10" => an <= "1011";
     when others => an <="0111";
   end case;
end process;

process (cnt,digit)
  begin
   case cnt(15 downto 14) is
     when "00" => x <= digit(3 downto 0);
     when "01" => x <= digit(7 downto 4);
     when "10" => x <= digit(11 downto 8);
     when others => x <= digit(15 downto 12);
   end case;
end process;

process(x)
    begin
         case x is
            when "0000" => cat <= "1000000";
            when "0001" => cat <= "1111001";
            when "0010" => cat <= "0100100";
            when "0011" => cat <= "0110000";
            when "0100" => cat <= "0011001";
            when "0101" => cat <= "0010010";
            when "0110" => cat <= "0000010";
            when "0111" => cat <= "1111000";
            when "1000" => cat <= "0000000";
            when "1001" => cat <= "0010000";
            when "1010" => cat <= "0001000";
            when "1011" => cat <= "0000011";
            when "1100" => cat <= "1000110";
            when "1101" => cat <= "0100001";
            when "1110" => cat <= "0000110";
            when "1111" => cat <= "0001111";
            when others => cat <= "0001110";
         end case;
end process;


end Behavioral;
