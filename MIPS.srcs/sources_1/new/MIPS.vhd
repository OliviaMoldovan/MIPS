----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 10:44:36 AM
-- Design Name: 
-- Module Name: MIPS - Behavioral
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

entity MIPS is
Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end MIPS;

architecture Behavioral of MIPS is

signal en: std_logic;
signal rst: std_logic;
signal cnt : STD_LOGIC_VECTOR (7 downto 0);
signal digits:STD_LOGIC_VECTOR(15 downto 0);
signal Instruction:STD_LOGIC_VECTOR(15 downto 0);
signal PCinc:STD_LOGIC_VECTOR(15 downto 0);
signal alu:std_logic_vector(15 downto 0);
signal WriteData: std_logic_vector(15 downto 0);
signal RegWrite:std_logic;
signal RegDst:  std_logic;
signal ExtOp: std_logic;
signal ReadData1: std_logic_vector(15 downto 0);
signal ReadData2:  std_logic_vector(15 downto 0);
signal sum:  std_logic_vector(15 downto 0);
signal Ext_Imm:  std_logic_vector(15 downto 0);
signal AluRes:std_logic_vector(15 downto 0);
signal AluRes1:std_logic_vector(15 downto 0);
signal Zero: std_logic:='0';
signal func:  std_logic_vector(2 downto 0);
signal Ext_func: std_logic_vector(15 downto 0);
signal Ext_sa: std_logic_vector(15 downto 0);
signal branch_adr: std_logic_vector(15 downto 0);
signal JumpAdress:std_logic_vector(15 downto 0);
signal MemData: std_logic_vector(15 downto 0);
signal ALUResOUT: std_logic_vector(15 downto 0);
signal ALUResIn:std_logic_vector(15 downto 0);
signal Jump:std_logic:='0';
signal ALUSrc:std_logic:='0';
signal MemWrite:std_logic:='0';
signal MemtoReg:std_logic:='0';
signal Branch:std_logic:='0';
signal Branchne:std_logic:='0';
signal ALUOp:std_logic_vector(1 downto 0):="00";
signal PCSrc:std_logic;	
signal sa:  std_logic;
signal digit:std_logic_vector(15 downto 0);
signal IF_ID:STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ID_EX:STD_LOGIC_VECTOR(83 DOWNTO 0);
signal EX_MEM:STD_LOGIC_VECTOR(56 DOWNTO 0);
signal MEM_WB:STD_LOGIC_VECTOR(36 DOWNTO 0);
signal muxRegDst: std_logic_vector(2 downto 0);
signal rt: std_logic_vector(2 downto 0);
signal rd: std_logic_vector(2 downto 0);
signal WriteAddress: std_logic_vector(15 downto 0);
signal iesireMuxRegDst: std_logic_vector(2 downto 0);






component MPG
 Port ( btn : in STD_LOGIC;
          clk : in STD_LOGIC;
           en : out STD_LOGIC);
end component;

component SSD 
 Port( digit: in STD_LOGIC_VECTOR (15 downto 0);
    clk: in STD_LOGIC;
    cat:out STD_LOGIC_VECTOR (6 downto 0);
    an: out STD_LOGIC_VECTOR (3 downto 0));
end component;

component RF 
Port (      clk : in STD_LOGIC;
         RA1 : in STD_LOGIC_VECTOR (2 downto 0);
         RA2 : in STD_LOGIC_VECTOR (2 downto 0);
         WA : in STD_LOGIC_VECTOR (2 downto 0);
         WD : in STD_LOGIC_VECTOR (15 downto 0);
         we:in STD_LOGIC;
         RegWr : in STD_LOGIC;
         RD1 : out STD_LOGIC_VECTOR (15 downto 0);
         RD2 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component RAM 
Port (  WA : in STD_LOGIC_VECTOR (3 downto 0);
      WD : in STD_LOGIC_VECTOR (15 downto 0);
      MemWrite : in STD_LOGIC;
      clk : in STD_LOGIC;
      RD : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component IFetch 
Port (    enable : in std_logic;
			reset : in std_logic;
			clk: in std_logic;
			BranchAddress : in std_logic_vector(15 downto 0);
			JumpAddress : in std_logic_vector(15 downto 0);
			JCS : in std_logic;
			PCSrc : in std_logic;
			Instruction : out std_logic_vector(15 downto 0);
			PC : out std_logic_vector(15 downto 0):=X"0000");

end component;

component IDecode 
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
end component;

component UC 
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
end component ;

component ExecutionUnit 
Port (   PC : in STD_LOGIC_VECTOR(15 downto 0);
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
end component;

component MEM
 Port ( clk : in STD_LOGIC;
          en : in STD_LOGIC;
          DataIn : in STD_LOGIC_VECTOR(15 downto 0);
          RD2 : in STD_LOGIC_VECTOR(15 downto 0);
          MemWrite : in STD_LOGIC;            
          MemData : out STD_LOGIC_VECTOR(15 downto 0);
          ALURes : out STD_LOGIC_VECTOR(15 downto 0));
end component;

begin
--c1 : MPG port map (btn(0),clk,en);
--c2 : MPG port map (btn(1),clk,rst);

--c3: SSD port map (digits,clk,cat,an); 

--c4: IFetch port map( clk, en, rst, branch_adr, JumpAdress, Jump, PCSrc, Instruction,PCInc);
--c5: IDecode port map(clk, Instruction, WriteData,RegWrite, RegDst, ExtOp,en, ReadData1,ReadData2,Ext_Imm, func, sa);
--c6: UC port map(instruction(15 downto 13), RegDst, RegWrite, ALUSrc, Extop, ALUOp, MemWrite, MemtoReg, Branch,Branchne,Jump); 

sum<=ReadData1+ReadData2;
Ext_func<= "0000000000000"&func;
Ext_sa<= "000000000000000"&sa;

with sw(7 downto 5)select
     digits <= Instruction when "000",
               PCinc when "001",
               ReadData1 when "010",
               ReadData2 when "011",
               Ext_Imm when "100",
               ALURes when "101",
               MemData when "110",
               WriteData when "111",
               (others => 'X') when others;
               
--led(10 downto 0) <= ALUOp & RegDst & ExtOp & ALUSrc & Branch &Jump & MemtoReg & RegWrite;


--c7: ExecutionUnit port map( alu, ReadData1, ReadData2, Ext_imm, func, sa, AluSrc, AluOp,AluRes, branch_adr, Zero);
--c8: MEM port map( clk, en, AluResIn, ReadData2, MemWrite, MemData, AluResOut);

--with MemtoReg select 
 --   WriteData <=MemData when '1',
 --            ALURes1 when '0',
  --            (others => 'X') when others;

--PCSrc <= Zero and Branch;
--JumpAdress <= PCinc (15 downto 13) & Instruction (12 downto 0);

 process(RegDst,ExtOp,ALUSrc,Branch,Jump,MemWrite,MemtoReg,RegWrite,sw,ALUOp)
begin
	if sw(0)='0' then		
		led(7)<=RegDst;
		led(6)<=ExtOp;
		led(5)<=ALUSrc;
		led(4)<=Branch;
		led(3)<=Jump;
		led(2)<=MemWrite;
		led(1)<=MemtoReg;
		led(0)<=RegWrite;
		
	else
            led(1 downto 0)<=ALUOp(1 downto 0);
            led(8 downto 2)<="0000000";		
	end if;
end process;

process(RegDst)
begin
    case RegDst is
    when '0' => muxRegDst <=ID_EX(66 downto 64);
    when '1' => muxRegDst <=ID_EX(80 downto 78);
    when others => muxRegDst <="000";
    end case;
end process;

process(clk, IF_ID, ID_EX, EX_MEM, MEM_WB)
   begin
        if rising_edge(clk) then
            -- IF_ID
            IF_ID(31 downto 16) <= PCinc;
            IF_ID(15 downto 0) <= Instruction;
            -- ID_EX  
            ID_EX(83 downto 81)<=IF_ID(6 downto 4); 
            ID_EX(80 downto 78) <=IF_ID(9 downto 7);      
            ID_EX(77) <= sa;
            ID_EX(76) <= MemToReg;
            ID_EX(75) <= RegWrite;
            ID_EX(74) <= MemWrite;
            ID_EX(73) <= RegDst;
            ID_EX(72) <= Branch;
            ID_EX(71) <= Branchne;
            ID_EX(70) <= Jump;
            ID_EX(69) <= ALUSrc;
            ID_EX(68 downto 67) <= ALUOp;
            ID_EX(66 downto 64) <= func;
            ID_EX(63 downto 48) <= PCinc;
            ID_EX(47 downto 32) <= ReadData1;
            ID_EX(31 downto 16) <= ReadData2;
            ID_EX(15 downto 0) <= Ext_Imm;
            -- EX_MEM
            EX_MEM(56 downto 41) <= branch_adr;
            EX_MEM(40 downto 38)<= muxRegDst;
            EX_MEM(37 downto 22)<= ID_EX(31 downto 16); --RadData2
            EX_MEM(21) <= ID_EX(75); --RegWrite
            EX_MEM(20) <= ID_EX(72); --Branch
            EX_MEM(19) <= ID_EX(71); --Branchne
            EX_MEM(18) <= ID_EX(74); --MemWrite
            EX_MEM(17) <= ID_EX(76); --MemtoReg
            EX_MEM(16) <= Zero;    
            EX_MEM(15 downto 0) <= ALURes;
            -- MEM_WB
            MEM_WB(36 downto 34)<= EX_MEM(40 downto 38);--muxregdst
            MEM_WB(33) <= EX_MEM(22); --RegWrite
            MEM_WB(32) <= EX_MEM(17); --MemtoReg
            MEM_WB(31 downto 16) <= MemData;
            MEM_WB(15 downto 0) <= EX_MEM(15 downto 0); --ALURes
        end if;
   end process;
   
 process(MemtoReg,ALURes,MemData)
   begin
       case (MemtoReg) is
           when '1' => WriteData <=EX_MEM(31 downto 16);
           when '0' => WriteData <=EX_MEM(15 downto 0);
       end case;
   end process;
   
  PCSrc <= (EX_MEM(56) and EX_MEM(52)) or (EX_MEM(56) and EX_MEM(53));
  JumpAdress <= IF_ID(31 downto 29) & IF_ID(12 downto 0);

C1 : MPG port map (btn(0),clk,en);
C2 : MPG port map (btn(1),clk,rst);
C3: SSD port map (digits,clk,cat,an); 
C4: IFetch port map( clk, en, rst, EX_MEM(56 downto 41), JumpAdress, Jump, PCSrc, Instruction,PCInc);
C5: IDecode port map(clk, IF_ID(15 downto 0), WriteData,RegWrite, RegDst, ExtOp,en,EX_MEM(15 downto 0), ReadData1,ReadData2,Ext_Imm, func, sa,IF_ID(9 downto 7),IF_ID(6 downto 4));
C6: UC port map(Instruction(15 downto 13), RegDst, RegWrite, ALUSrc, ExtOp, ALUOp, MemWrite, MemtoReg, Branch,Branchne,Jump); 
C7: ExecutionUnit port map( IF_ID(31 downto 16), ID_EX(47 downto 32), ID_EX(31 downto 16), ID_EX(15 downto 0), ID_EX(66 downto 64),ID_EX(77),ID_EX(80 downto 78),ID_EX(83 downto 81) ,EX_MEM(40 downto 38),ID_EX(69), ID_EX(68 downto 67),AluRes, branch_adr, Zero);
C8: MEM port map( clk, en, EX_MEM(15 downto 0), EX_MEM(37 downto 22), EX_MEM(18), MemData, AluResOut);


end Behavioral;
