----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:30:43 11/14/2016 
-- Design Name: 
-- Module Name:    if - Behavioral 
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

entity if_id is
    Port ( is_paused : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           id_pc : out  INT16;
			  id_instruction : out INT16;
			  -- addr and instruction is port of reading instruction from sram
			  addr : out INT16;
			  instruction: in INT16;
			  --jump_target is the target address of JUMP instruction,
			  jump_en : in STD_LOGIC;
           jump_target : in  INT16);

end if_id;

architecture Behavioral of if_id is
signal pc : INT16 := ZERO;	-- pc in if	
begin
	process(clk, rst)
	-- assign id_pc and calc new PC, considering is_paused and jump_target
	variable new_pc : INT16;
	begin
		if(rst = '0')then
			pc <= ZERO;
			id_pc <= ZERO;
		elsif(clk'event and clk = '1' and is_paused = '0')then
			if(jump_en = '0')then	--	negative number represents none
				new_pc := pc + "0000000000000001";
			else 
				new_pc := jump_target;
			end if;
			id_pc <= pc;
			pc <= new_pc;
			id_instruction <= instruction;
		end if;
	end process;
	
	-- combinational logic of if
	addr <= pc;
	--id_instruction <= instruction;
	
end Behavioral;

