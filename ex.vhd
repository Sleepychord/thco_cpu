----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:21:06 11/14/2016 
-- Design Name: 
-- Module Name:    ex - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex is
    Port ( num1 : in  INT16;
           num2 : in  INT16;
			  num3 : in  INT16;
           op : in  operation;
           target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  is_load : out STD_LOGIC;
			  ex_op : out operation;
			  -- ex_target_reg and data is to ex_mem and id
			  ex_target_reg : out STD_LOGIC_VECTOR(4 DOWNTO 0);
           data : out INT16;
           target_mem : out  INT16);
end ex;

architecture Behavioral of ex is
signal is_equal: INT16;
signal sll_num: integer := 0;
begin
	ex_target_reg <= target_reg;
	ex_op <= op;
	is_load <= '1' when (op = LW)or(op = LW_SP) else '0';
	with op select
		target_mem <= num1 + num2 when LW | LW_SP,
						  num1 + num3 when SW | SW_SP,
						  ZERO when others;
	is_equal <= ZERO when num1 = num2 else "0000000000000001";
	sll_num <= 8 when (num2 = ZERO) else to_integer(unsigned(num2));
	with op select
		data <= num1 + num2 when ADDIU | ADDIU3 | ADDSP3 | ADDSP | ADDU,
				  num1 and num2 when AND_OP,
				  is_equal when CMP,
				  num1 when JALR | LI | MFIH | MFPC | MOVE | MTSP,
				  ZERO - num1 when NEG,
				  num1 or num2 when OR_OP,
				  -- it is strange the two operator is different
				  std_logic_vector(unsigned(num1) sll sll_num) when SLL_OP,
				  to_stdlogicvector(to_bitvector(num1) sra sll_num) when SRA_OP,
				  num1 - num2 when SUBU,
				  num2 when SW | SW_SP,
				  ZERO when others;
end Behavioral;

