----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2021 06:52:58 PM
-- Design Name: 
-- Module Name: RAM - Behavioral
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



entity RAM is
Port ( WA : in STD_LOGIC_VECTOR (3 downto 0);
       WD : in STD_LOGIC_VECTOR (15 downto 0);
       MemWrite : in STD_LOGIC;
       clk : in STD_LOGIC;
       RD : out STD_LOGIC_VECTOR (15 downto 0));
end RAM;

architecture Behavioral of RAM is

type ram_type is array (0 to 15) of STD_LOGIC_VECTOR (15 downto 0);
signal RAM: ram_type := (
      X"0001",
      X"0002",
      X"0003",
      X"0004",
      X"0005",
      X"0006",
      X"0007",
      others => X"0000");
begin
   process(clk)
      begin
      if rising_edge(clk) then
             if MemWrite='1'  then
                     RAM(conv_integer(WA))<=WD;
                     RD<=WD;
              else RD<=RAM(conv_integer(WA));
           end if;
           end if;
      end process;


end Behavioral;

