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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex is
    Port ( num1 : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           num2 : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           num3 : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           op : in  operation;
           target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  is_load : out STD_LOGIC;
			  ex_operation : out operation;
			  -- ex_target_reg and data is to ex_mem and id
			  ex_target_reg : out STD_LOGIC_VECTOR(4 DOWNTO 0);
           data : out INT16;
           target_mem : out  INT16);
end ex;

architecture Behavioral of ex is

begin
	ex_target_reg <= target_reg;

end Behavioral;

