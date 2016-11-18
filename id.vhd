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
           read_addr1 : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           read_data1 : in  INT16;
			  read_addr2 : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           read_data2 : in  INT16;
           op : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           aux_op : out  STD_LOGIC_VECTOR(7 DOWNTO 0);
           num1 : out  STD_LOGIC_VECTOR(2 DOWNTO 0);
           num2 : out  STD_LOGIC_VECTOR(2 DOWNTO 0);
           num3 : out  STD_LOGIC_VECTOR(2 DOWNTO 0);
			  -- target_reg, if target is memory, store it in num1
           target_reg : out STD_LOGIC_VECTOR(4 DOWNTO 0);
			  -- foward sideway
			  ex_target_reg : in STD_LOGIC_VECTOR(4 DOWNTO 0);
			  ex_target_data : in INT16;
			  mem_target_reg : in STD_LOGIC_VECTOR(4 DOWNTO 0);
			  mem_target_data : in INT16;
           jump_target : out INT16;
			  -- whether operation in exe phase is load
			  is_ex_load : in STD_LOGIC;
			  -- dicided by exe 's load_reg and op's reg
			  pause_req: out STD_LOGIC
			  );
end id;

architecture Behavioral of id is

begin
	op <= id_instruction(15 downto 11);
	aux_op <= 
	pause_req <= is_ex_load and (ex_target_reg = target_reg);
	
end Behavioral;

