----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:32:17 11/14/2016 
-- Design Name: 
-- Module Name:    reg - Behavioral 
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

entity reg is
    Port ( read_addr1 : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           read_addr2 : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           read_data1 : out  INT16;
           read_data2 : out  INT16;
           write_en : in  STD_LOGIC;
           write_addr : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           write_data : in  INT16;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end reg;

architecture Behavioral of reg is

begin

-- READ is combinal logic, don't forget to check whether read_addr == write_addr
-- write is sequetial logic
end Behavioral;

