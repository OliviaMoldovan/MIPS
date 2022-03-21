----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2021 09:25:27 PM
-- Design Name: 
-- Module Name: ExecutionUnit - Behavioral
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

entity ExecutionUnit is
Port (     PC : in STD_LOGIC_VECTOR(15 downto 0);
           ReadData1 : in STD_LOGIC_VECTOR (15 downto 0);
           ReadData2 : in STD_LOGIC_VECTOR (15 downto 0);
           ExtImm : in STD_LOGIC_VECTOR (15 downto 0);
           func : in STD_LOGIC_VECTOR (2 downto 0);
           sa : in STD_LOGIC; 
           rt:in std_logic_vector(2 downto 0);
           rd:in std_logic_vector(2 downto 0);
           iesireMuxRegDst: out std_logic_vector(2 downto 0);
           ALUsrc : in STD_LOGIC;
           ALUOp : in STD_LOGIC_VECTOR(1 downto 0);  
           ALURes : out STD_LOGIC_VECTOR(15 downto 0);
           BranchAddr : out STD_LOGIC_VECTOR(15 downto 0);
           zero : out STD_LOGIC);
end ExecutionUnit;

architecture Behavioral of ExecutionUnit is

signal op2:std_logic_vector(15 downto 0); -- poate fi ori readdata2 ori imediatul extins;
signal AluCtrl: std_logic_vector(2 downto 0);
signal mult: std_logic_vector(31 downto 0);

begin
mult<=ReadData1*op2;
op2<=ReadData1 when ALUSrc='0' else ExtImm;
BranchAddr <= ExtImm + PC;
process(ALUOp)
begin
    case(ALUOp) is
    when "10"=> AluCtrl<=func;
    when "00"=>AluCtrl<="000";
    when "01"=>AluCtrl<="001";
    when "11"=>AluCtrl<="101";
    end case;
 end process;
 
 process(AluCtrl)
 begin
 case AluCtrl is
     when "000"=> ALURes<=ReadData1+op2;
     when  "001"=> ALURes<=ReadData1-op2;
     when "010"=>if sa = '1' then ALURes <= ReadData1(15 downto 1) & '0';
                        else ALURes <= ReadData1; 
                        end if;
    when "011" => if sa = '1' then ALURes <= '0' & ReadData1(14 downto 0);
                        else ALURes <= ReadData1; 
                        end if;
    when "100" => ALURes <= ReadData1 and op2;
    when "101" => ALURes <= ReadData1 or op2;
    when "110" => ALURes <= ReadData1 xor op2;
    when "111" => ALURes <= mult(15 downto 0);
    when others => ALURes <= ReadData1;
 end case;
end process;
 
process(ReadData1, op2) 
begin 
    if ReadData1 = op2 then zero <= '1';
    else zero <= '0';
    end if;
 end process;
 
end Behavioral;
