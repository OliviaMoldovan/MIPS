----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2021 08:17:17 PM
-- Design Name: 
-- Module Name: RF - Behavioral
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

entity RF is
Port (     clk : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (2 downto 0);
           RA2 : in STD_LOGIC_VECTOR (2 downto 0);
           WA : in STD_LOGIC_VECTOR (2 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           we:in STD_LOGIC;
           RegWr : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0));
end RF;

architecture Behavioral of RF is
type reg_array is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal reg_file : reg_array := (
     X"0001",
     X"0201",
     X"2402",
     X"1003",
     X"1234",
     X"0321",
     X"0041",
     X"9907",
     others => X"0000");

begin

   process(clk)
   begin
       if rising_edge(clk) then
          if RegWr='1' then
             reg_file(conv_integer(WA)) <= WD;
             end if;
        end if;
  end process;   

RD1<=reg_file(conv_integer(RA1));
RD2<=reg_file(conv_integer(RA2));

end Behavioral;
