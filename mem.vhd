----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:25:47 11/14/2016 
-- Design Name: 
-- Module Name:    mem - Behavioral 
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

entity mem is
    Port ( sclk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data : in  INT16;
           target_mem : in  INT16;
           target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           op : in  operation;
           mem_op : out  operation;
			  -- interact with sram
			  sram_addr : out INT16;
			  sram_data : inout INT16;
			  -- pass to mem/wb and forward to id
			  mem_data : out  INT16;
           mem_target_reg : out  STD_LOGIC_VECTOR(4 DOWNTO 0));
end mem;

architecture Behavioral of mem is

begin


end Behavioral;

