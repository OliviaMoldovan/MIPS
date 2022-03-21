----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2021 09:59:34 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
 Port ( clk : in STD_LOGIC;
          en : in STD_LOGIC;
          DataIn : in STD_LOGIC_VECTOR(15 downto 0);
          RD2 : in STD_LOGIC_VECTOR(15 downto 0);
          MemWrite : in STD_LOGIC;            
          MemData : out STD_LOGIC_VECTOR(15 downto 0);
          ALURes : out STD_LOGIC_VECTOR(15 downto 0));
end MEM;

architecture Behavioral of MEM is

type ram is array (0 to 31) of STD_LOGIC_VECTOR(15 downto 0);
signal  r: ram := (
    x"0000",
    x"0001",
    x"0010",
    x"0011",
    x"0100",
    x"0101",
    others => x"0000");

begin
    process(clk) 			
    begin
        if rising_edge(clk) then
            if en = '1' and MemWrite='1' then
                r(conv_integer(DataIn(4 downto 0))) <= RD2;			
            end if;
        end if;
    end process;

MemData <= r(conv_integer(DataIn(4 downto 0)));
ALURes <= DataIn;


end Behavioral;
