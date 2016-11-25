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
use IEEE.NUMERIC_STD.ALL;

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
           rst : in  STD_LOGIC;
			  ex_target_reg : in STD_LOGIC_VECTOR(4 DOWNTO 0);
			  ex_target_data : in INT16;
			  mem_target_reg : in STD_LOGIC_VECTOR(4 DOWNTO 0);
			  mem_target_data : in INT16
			  );
end reg;

architecture Behavioral of reg is
type matrix_type is array (31 downto 0) of INT16;
signal regs : matrix_type;
begin
--GeneralReg:00000-00111
--SP:01000
--IH:01001
--RA:01010
--T:01011	
	
-- READ is combinal logic, don't forget to check whether read_addr == write_addr
-- write is sequetial logic
	read_data1 <= ex_target_data when (ex_target_data(4) = '0')and(ex_target_reg = read_addr1)else
			mem_target_data when (mem_target_data(4) = '0')and(mem_target_reg = read_addr1)else
			write_data when (write_en = '1')and(read_addr1 = write_addr) else
			regs(to_integer(unsigned(read_addr1)));
	read_data2 <= ex_target_data when (ex_target_data(4) = '0')and(ex_target_reg = read_addr2)else
			mem_target_data when (mem_target_data(4) = '0')and(mem_target_reg = read_addr2)else
			write_data when (write_en = '1')and(read_addr2 = write_addr) else
			regs(to_integer(unsigned(read_addr2)));
			
	process(clk, rst)
	begin
		if(rst = '0')then
			for i in 31 downto 0 loop
				regs(i) <= ZERO;
			end loop;
		elsif( clk'event and clk = '1' and write_en = '1')then
			regs(to_integer(unsigned(write_addr))) <= write_data;
		end if;
	end process;
end Behavioral;

