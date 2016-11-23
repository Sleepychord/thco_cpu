----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:32:03 11/14/2016 
-- Design Name: 
-- Module Name:    pause - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pause is
    Port ( pause_req_id : in  STD_LOGIC;
			  pause_req_mem : in STD_LOGIC;
           pause_res_if_id : out  STD_LOGIC;
			  pause_res_ex_mem : out STD_LOGIC;
			  pause_res_mem_wb : out STD_LOGIC;
           pause_res_id_ex : out  STD_LOGIC_VECTOR(1 downto 0));
end pause;

architecture Behavioral of pause is

begin
	-- only id can request for pause temporarily
	pause_res_if_id <= pause_req_id OR pause_req_mem;
	pause_res_id_ex <= "10" when pause_req_mem else
							 "01" when pause_req_id else
							 "00";
	pause_res_ex_mem <= pause_req_mem;
	pause_res_mem_wb <= pause_req_mem;
end Behavioral;

