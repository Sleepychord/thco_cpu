----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:50:10 11/14/2016 
-- Design Name: 
-- Module Name:    ex_mem - Behavioral 
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

entity ex_mem is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ex_op : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           ex_aux : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           ex_target_reg : in  INT16;
           ex_data : in  INT16;
           ex_target_mem : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           mem_op : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           mem_aux : out  STD_LOGIC_VECTOR(7 DOWNTO 0);
           mem_target_reg : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           mem_data : out  INT16;
           mem_target_mem : out  INT16);
end ex_mem;

architecture Behavioral of ex_mem is

begin

	-- just link when positive edge comes
end Behavioral;

