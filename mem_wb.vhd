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
    Port ( op : in  operation;
           mem_data : in  INT16;
           mem_target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  rst : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           wb_en : out  STD_LOGIC;
           wb_data : out  INT16;
           wb_target_reg : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  is_paused : in STD_LOGIC
			  );
end mem_wb;

architecture Behavioral of mem_wb is
begin
	process (clk, rst)
	begin
		if (rst = '0') then
			wb_en <= '0';
			wb_data <= "0000000000000000";
			wb_target_reg <= "00000";
		elsif ( clk'event and clk = '1' and is_paused = '0' ) then
			wb_data <= mem_data;
			wb_target_reg <= mem_target_reg;
			if ((op = B or op = BEQZ or op = BNEZ or op = BTEQZ or 
				op = BEQZ or op = JR or op = JRRA or op = NOP or op = SW or op = SW_SP))
				then wb_en <= '0';
				else wb_en <= '1';
			end if;
		end if;
	end process;
end Behavioral;

