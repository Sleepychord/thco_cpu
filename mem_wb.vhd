----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:35:38 11/14/2016 
-- Design Name: 
-- Module Name:    mem_wb - Behavioral 
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

entity mem_wb is
    Port ( mem_op : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           mem_aux : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           mem_data : in  INT16;
           mem_target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           wb_en : out  STD_LOGIC;
           wb_data : out  INT16;
           wb_target_reg : out  STD_LOGIC_VECTOR(4 DOWNTO 0));
end mem_wb;

architecture Behavioral of mem_wb is

begin


end Behavioral;

