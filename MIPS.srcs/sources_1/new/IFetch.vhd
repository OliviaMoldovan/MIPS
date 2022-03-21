----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 09:21:20 PM
-- Design Name: 
-- Module Name: IFetch - Behavioral
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

entity IFetch is
Port (enable : in std_logic;
			reset : in std_logic;
			clk: in std_logic;
			BranchAddress : in std_logic_vector(15 downto 0);
			JumpAddress : in std_logic_vector(15 downto 0);
			JCS : in std_logic;
			PCSrc : in std_logic;
			Instruction : out std_logic_vector(15 downto 0);
			PC : out std_logic_vector(15 downto 0):=X"0000");

end IFetch;

Architecture Behavioral of IFetch is

--------------Memorie ROM--------------
type tROM is array (0 to 255) of STD_LOGIC_VECTOR (15 downto 0);
signal ROM: tROM := (


		B"000_000_000_001_0_000",  --X"0100"	--add $1,$0,$0
	    B"001_000_010_0000111", --X"7012"   --addi $2,$0,7
        B"000_000_010_010_0_001",	 --X"1210"	--add $3,$0,$0	
		B"000_000_100_000_0_001",	 --X"1020"	--add $4,$0,$0	
		B"000_000_101_000_0_001",	 --X"1820"	--add $5,$0,$0
		B"000_000_011_000_0_001",	 --X"1810"	--add $6,$0,$0
		B"001_000_111_0000001", --X"1832"   --addi $7,$0,1
		B"010_001_010_0000101", --X"5054"   --beq $1,$2,5
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
		B"011_101_110_0001000", --X"8077"   --lw $6,16($5)
	    B"000_011_111_111_0_101",	 --X"5EE0"	--and $7,$3,$7
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
		B"101_111_000_0000001", --X"10CB" --bne $7,$0,1
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
		B"000_110_011_011_0_001", --X"1B91" --add $3,$6,$3
		B"000_110_100_100_0_001", --X"14A1" --add $4,$6,$4
   		B"111_0000000000100", --X"400D" --j 8
   		B"000_000_000_000_0_001",	 --X"0000"	--noop	
   		B"100_000_011_0100000", --X"0A18"   --sw $3,32($0)
   		B"100_000_100_0000100", --X"4028"   --sw $4,8($0)
    	B"010_011_100_0000011", --X"30D8"   --beq $3,$4,3
   	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
    	B"000_011_100_011_0_010", --X"23E0"   --sub $3,$3,$4
        B"000_000_000_000_0_001",	 --X"0000"	--noop	
	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
    	B"000_100_011_100_0_010", --X"2C11"   --sub $4,$4,$3
   		B"111_0000000010001", --X"110D" --j 17
   	    B"000_000_000_000_0_001",	 --X"0000"	--noop	
    	B"100_000_011_0100000", --X"0A18"   --sw $3,32($0)
			others => X"0000");

signal PCnt : std_logic_vector(15 downto 0) := (others => '0');
signal PCAux, NextAdr, AuxSgn: std_logic_vector(15 downto 0);

begin

process(JCS,AuxSgn,JumpAddress)
begin
	case(JCS) is
		when '0' => NextAdr <= AuxSgn;
		when '1' => NextAdr <= JumpAddress;
		when others => NextAdr <= X"0000";
	end case;
end process;	

process(PCSrc,PCAux,BranchAddress)
begin
	case (PCSrc) is 
		when '0' => AuxSgn <= PCAux;
		when '1' => AuxSgn<=BranchAddress;
		when others => AuxSgn<=X"0000";
	end case;
end process;	

process(clk,enable,reset)
begin
	if Reset='1' then
		PCnt<=X"0000";
	else if rising_edge(clk) and enable='1' then
		PCnt<=NextAdr;
		end if;
		end if;
end process;

Instruction<=ROM(conv_integer(PCnt(7 downto 0)));

PCAux<=PCnt + '1';

PC <= PCAux;

end Behavioral;
