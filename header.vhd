--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package header is

		subtype int16 is STD_LOGIC_VECTOR(15 DOWNTO 0);
		function sign_extend8(signal num_raw : in STD_LOGIC_VECTOR(7 DOWNTO 0)) return INT16;
		constant zero : int16 := "0000000000000000";
		type operation is (ADDIU, ADDIU3, ADDSP3, ADDSP, ADDU, AND_OP, B, BEQZ, BNEZ, 
			BTEQZ, CMP, JALR, JR, JRRA, LI, LW, LW_SP, MFIH, MFPC, MOVE, MTIH, MTSP, NEG, NOP,
			OR_OP, SLL_OP, SRA_OP, SUBU_OP, SW, SW_SP);
		function get_op(signal op: in STD_LOGIC_VECTOR(4 DOWNTO 0); signal aux: in STD_LOGIC_VECTOR(4 DOWNTO 0)) return operation;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end header;

package body header is
		function sign_extend8(signal num_raw : in STD_LOGIC_VECTOR(7 DOWNTO 0)) return INT16 is
		begin
			if(num_raw(7) = '0')then
				return "00000000" & num_raw;
			else
				return "11111111" & num_raw;
			end if;
		end function;
		function get_op(signal op: in STD_LOGIC_VECTOR(4 DOWNTO 0); signal aux: in STD_LOGIC_VECTOR(4 DOWNTO 0)) return operation is
		begin
			case op is
				when "01001" => return ADDIU;
				when others => return NOP;
			end case;
		end function;

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end header;
