----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2021 11:26:37 AM
-- Design Name: 
-- Module Name: IDecode - Behavioral
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

entity IDecode is
  Port (clk:in std_logic;
          instr:in std_logic_vector(15 downto 0);
          WriteData: in std_logic_vector(15 downto 0);
          RegWrite:in std_logic;
          RegDst: in std_logic;
          ExtOp: in std_logic;
          enable: in std_logic;
          WriteAddres: in std_logic_vector(15 downto 0);
          ReadData1: out std_logic_vector(15 downto 0);
          ReadData2: out std_logic_vector(15 downto 0);
          Ext_Imm: out std_logic_vector(15 downto 0);
          func: out std_logic_vector(2 downto 0);
          sa: out std_logic;
          rt:out std_logic_vector(2 downto 0);
          rd:out std_logic_vector(2 downto 0));
end IDecode;

architecture Behavioral of IDecode is

signal WriteAdresss: std_logic_vector(2 downto 0);
signal we: STD_LOGIC;
signal en: std_logic;

component RF is
Port (    clk : in STD_LOGIC;
          RA1 : in STD_LOGIC_VECTOR (2 downto 0);
          RA2 : in STD_LOGIC_VECTOR (2 downto 0);
          WA : in STD_LOGIC_VECTOR (2 downto 0);
          WD : in STD_LOGIC_VECTOR (15 downto 0);
          we:in STD_LOGIC;
          RegWr : in STD_LOGIC;
          RD1 : out STD_LOGIC_VECTOR (15 downto 0);
          RD2 : out STD_LOGIC_VECTOR (15 downto 0));
end component;
begin
C1: RF port map(clk, instr(12 downto 10), instr(9 downto 7), WriteAdresss, WriteData, we,RegWrite, ReadData1,ReadData2);
func<=instr(2 downto 0);
sa<=instr(3);

process(instr, RegDst)
begin 
    if RegDst = '1' then
     WriteAdresss <= instr(6 downto 4);
    else 
    WriteAdresss <= instr(9 downto 7);
    end if;
end process;
 
process(instr, ExtOp)
begin
 if( ExtOp = '0' or (ExtOp='1' and instr(6)='0'))
    then Ext_imm <= "000000000" & instr(6 downto 0);
 else
    if(ExtOp = '1' and instr(6)='1')
     then Ext_imm <= "111111111" & instr(6 downto 0);
    end if;
   end if;
end process;
end Behavioral;
