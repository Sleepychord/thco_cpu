----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:28 11/14/2016 
-- Design Name: 
-- Module Name:    id - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use work.HEADER.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity id is
    Port ( id_pc : in  INT16;
           id_instruction : in  INT16;
           read_addr1 : inout  STD_LOGIC_VECTOR(4 DOWNTO 0);
           read_data1 : in  INT16;
			  read_addr2 : inout  STD_LOGIC_VECTOR(4 DOWNTO 0);
           read_data2 : in  INT16;
           id_op: inout operation; -- OUT
           num1 : out  INT16;
           num2 : out  INT16;
			  num3 : out  INT16;
			  -- target_reg, if target is memory, store it in num1
           target_reg : inout STD_LOGIC_VECTOR(4 DOWNTO 0);--OUT
			  -- foward sideway
			  ex_target_reg : in STD_LOGIC_VECTOR(4 DOWNTO 0);

           jump_target : out INT16;
			  jump_en : out STD_LOGIC;
			  -- whether operation in exe phase is load
			  is_ex_load : in STD_LOGIC;
			  -- dicided by exe 's load_reg and op's reg
			  pause_req: out STD_LOGIC
			  );
end id;

architecture Behavioral of id is
signal op : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal aux_op : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal is_data1_zero: STD_LOGIC;
begin
	op <= id_instruction(15 downto 11);
	aux_op <= id_instruction(15 downto 8) when (op = "01100") else id_instruction(7 downto 0);
	id_op <= get_op(op, aux_op);
	pause_req <= is_ex_load when(ex_target_reg = read_addr1 or ex_target_reg = read_addr2) else '0';
	
	-- NUM1
	with id_op select
	read_addr1 <= "00" & id_instruction(10 downto 8) when ADDIU | ADDIU3 | ADDU | AND_OP | BEQZ | BNEZ
							| CMP | JALR | JR | LW | MTIH | MTSP | OR_OP | SUBU | SW,
					  "00" & id_instruction(7 downto 5) when MOVE | NEG | SLL_OP | SRA_OP,
					  "01000" when ADDSP3 | ADDSP | LW_SP | SW_SP,
					  "01011" when BTEQZ,
					  "01010" when JRRA,
					  "01001" when MFIH,
					  "10000" when others;
	with id_op select
	num1 <= read_data1 when  ADDIU | ADDIU3 | ADDSP3 | ADDSP | ADDU | AND_OP | CMP | LW | LW_SP
							| MFIH | MOVE | MTIH | MTSP | NEG | OR_OP | SLL_OP | SRA_OP | SUBU |SW | SW_SP,
					  id_pc + "0000000000000001" when JALR | MFPC,
					  "00000000" & id_instruction(7 downto 0) when LI,
					  ZERO when others;
	-- NUM2				  
	with id_op select
	read_addr2 <= "00" & id_instruction(7 downto 5) when ADDU | AND_OP | CMP | OR_OP | SUBU | SW,
					  "00" & id_instruction(10 downto 8) when SW_SP,
					  "10000" when others;
				  
	with id_op select
	num2 <= sign_extend8(id_instruction(7 downto 0)) when ADDIU | ADDSP3 | ADDSP | LW_SP, 
			  sign_extend4(id_instruction(3 downto 0)) when ADDIU3,
			  sign_extend5(id_instruction(4 downto 0)) when LW,
			  "0000000000000" + id_instruction(4 downto 2) when SLL_OP | SRA_OP,
			  read_data2 when ADDU | AND_OP | CMP | OR_OP | SUBU | SW | SW_SP,
			  ZERO when others;	
	-- NUM3
	num3 <= sign_extend5(id_instruction(4 downto 0)) when id_op = SW else 
			  sign_extend8(id_instruction(7 downto 0)) when id_op = SW_SP else ZERO;
	-- TARGET
	with id_op select
	target_reg <= "00" & id_instruction(10 downto 8) when ADDIU | ADDSP3 | AND_OP | LI | LW_SP
							| MFIH | MFPC | MOVE | NEG | OR_OP | SLL_OP | SRA_OP,
					  "00" & id_instruction(7 downto 5) when ADDIU3 | LW,
					  "00" & id_instruction(4 downto 2) when ADDU | SUBU,
					  "01000" when ADDSP | MTSP,
					  "01011" when CMP,
					  "01010" when JALR,
					  "01001" when MTIH,
					  "10000" when others;
	-- JUMP
	is_data1_zero <= '1' when (read_data1 = ZERO) else '0';
	with id_op select 
	jump_en <= '1' when B | JALR | JR | JRRA,
				  is_data1_zero when BEQZ | BTEQZ,
				  not is_data1_zero when BNEZ,
				  '0' when others;
	with id_op select
	jump_target <= id_pc + "0000000000000001" + sign_extend11(id_instruction(10 downto 0)) when B,
						id_pc + "0000000000000001" + sign_extend8(id_instruction(7 downto 0)) when BEQZ | BNEZ | BTEQZ,
						read_data1 when JALR | JR | JRRA,
						ZERO when others;
end Behavioral;

