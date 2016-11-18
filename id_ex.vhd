----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:48:00 11/14/2016 
-- Design Name: 
-- Module Name:    id_ex - Behavioral 
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

entity id_ex is
    Port ( id_op : in  operation;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  is_paused : in STD_LOGIC;
           ex_op : out  operation;
           id_num1 : in  INT16;
           id_num2 : in  INT16;
           id_num3 : in  INT16;
           ex_num1 : out  INT16;
           ex_num2 : out  INT16;
           ex_num3 : out  INT16;
           id_target_reg : in STD_LOGIC_VECTOR(4 DOWNTO 0);
           ex_target_reg : out STD_LOGIC_VECTOR(4 DOWNTO 0));
end id_ex;

architecture Behavioral of id_ex is

begin


end Behavioral;

