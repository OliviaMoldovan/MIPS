----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2021 08:46:53 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
 Port (Instr: in std_logic_vector(2 downto 0);
        RegDst: out std_logic;
        RegWrite: out std_logic;
        AluSrc: out std_logic;
        Extop: out std_logic;
        AluOp: out std_logic_vector(1 downto 0);
        MemWrite: out std_logic;
        MemtoReg: out std_logic;
        Branch: out std_logic;
        Branchne:out std_logic;
        Jump: out std_logic);
end UC ;

architecture Behavioral of UC is

begin

process(Instr)
begin
RegDst<='0'; 
RegWrite<='0';
AluSrc<='0';
Extop<='0';
AluOp<="00";
MemWrite<='0';
MemtoReg<='0';
Branch<='0';
Branchne<='0';
Jump<='0';

     case(Instr) is
     when "000"=>
        RegDst<='1';
        RegWrite<='1';
        AluOp<="10";
        
     when "001"=>
        RegWrite<='1';
        AluSrc<='1';
        Extop<='1';
        AluOp<="00";
        
     when "010"=>
         RegWrite<='1';
        AluSrc<='1';
        Extop<='1';
        MemtoReg<='1';
        AluOp<="00";
        
        when "011"=>
        AluSrc<='1';
        Extop<='1';
        MemWrite<='1';
        AluOp<="00";
        
        when "100"=>
        Extop<='1';
        Branch<='1';
        AluOp<="01";
        
          when "101"=>
        Extop<='1';
        Branchne<='1';
        AluOp<="11";
        
         
          when "110"=>
        RegWrite<='1';
        Extop<='1';
        AluOp<="01";
        
         when "111"=>
        Jump<='1';
        
        when others=>
 RegDst<='X'; 
RegWrite<='X';
AluSrc<='X';
Extop<='X';
AluOp<="XX";
MemWrite<='X';
MemtoReg<='X';
Branch<='X';
Branchne<='X';
Jump<='X';

end case;
end process;

end Behavioral;

