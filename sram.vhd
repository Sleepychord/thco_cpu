----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:40:42 11/14/2016 
-- Design Name: 
-- Module Name:    sram - Behavioral 
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.HEADER.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sram is
    Port ( rst : in  STD_LOGIC;
           sclk : in  STD_LOGIC;
			  -- only-read ports is used to get instruction
           addr_readonly : in  INT16;
           data_readonly : out  INT16;
			  -- read-write ports is used to load or store
			  read_write_toggle: in STD_LOGIC_VECTOR(1 DOWNTO 0);
			  -- 00 load 01 store
           addr_readwrite : in  INT16;
           data_readwrite_in : in  INT16;
			  data_readwrite_out : out INT16;
           ram1en : out  STD_LOGIC;
           ram1we : out  STD_LOGIC;
           ram1oe : out  STD_LOGIC;
           ram1addr : out  STD_LOGIC_VECTOR(17 DOWNTO 0);
           ram1data : inout  INT16;
			  -- Serials, maybe need to be modified
			  seri_rdn: out STD_LOGIC := '1';
		     seri_wrn: out STD_LOGIC := '1';
			  seri_data_ready	: in std_logic;
			  seri_tbre	: in std_logic;
			  seri_tsre	: in std_logic;
			  pause_req : inout std_logic;
			  clk : in std_logic;
			  cam_addr : out std_logic_vector(9 downto 0);
			  cam_data : in std_logic
			  );
end sram;

architecture Behavioral of sram is
signal token : std_logic := '1';
begin
	-- should handle serials, ram1, ram2 request
	-- the situation that visiting two different addr in the same ram might happen,
	-- maybe we can handle by using super clock to slice the time for this situation
	-- and pause when loading or storing

	-- don't use both positive and negative edge!
	process (rst, clk)
	begin
		if (rst = '0') then
			token <= '1';
		elsif(clk'event and clk = '1')then 
			if(pause_req = '1')then
				token <= '0'; -- can't 
			else token <= '1';
			end if;
		end if;
	end process;
	
--	process (rst, clk)
--	begin
--		if(clk'event and clk = '0' and pause_req = '0')then
--			data_readonly <= ram1data;
--		end if;
--	end process;
	
	process (sclk, rst)
	variable state: integer := 0;
	variable tmp : INT16;
	begin
		if(rst = '0')then
			state := 0;
			ram1en <= '0';
			seri_rdn <= '1';
			seri_wrn <= '1';
			ram1data <= "ZZZZZZZZZZZZZZZZ";
			ram1oe <= '0';
			pause_req <= '0';
			ram1we <= '1';			
		elsif(sclk'event and sclk = '0')then -- neg edge
			case state is
				when 0 =>
					-- put instruction addr
					ram1addr(15 downto 0) <= addr_readonly(15 downto 0);
               ram1addr(17 downto 16) <= "00";
					if(token = '1')then -- only when there 's no pause_req in this cpu period, r/w 
						state := 1;
					end if;
				when 1 => 
					-- read instruction
               data_readonly <= ram1data;
					if(read_write_toggle = "10")then
						state := 0;
					elsif(read_write_toggle = "00")then
					-- read memory or serials
						if(addr_readwrite = "1011111100000000")then 
							-- BF00 
							pause_req <= '1';		-- pause
							ram1en <= '1';
							ram1oe <= '1';
							ram1we <= '1';
							seri_rdn <= '0';
							state := 5;
						elsif(addr_readwrite = "1011111100000001")then 
							-- BF01
							tmp := ZERO;
							if(seri_data_ready = '1')then
								tmp := tmp + "0000000000000010";
							end if;
							if(seri_tbre = '1' and seri_tsre = '1')then
								tmp := tmp + "0000000000000001";
							end if;
							data_readwrite_out <= tmp;
							state := 0;
						elsif(addr_readwrite(15 downto 10) = "111111")then
							-- camera
							cam_addr <= addr_readwrite(9 downto 0);
							pause_req <= '1';
							state := 8;
                  else
							pause_req <= '1';		-- pause
							ram1addr(15 downto 0) <= addr_readwrite(15 downto 0);
							ram1addr(17 downto 16) <= "00";
							state := 2;
						end if;
					elsif(read_write_toggle = "01")then
						pause_req <= '1';		-- pause
						if(addr_readwrite(15 downto 0) = "1011111100000000")then 
							-- BF00 seri
							ram1en <= '1';
							ram1oe <= '1';
							ram1we <= '1';
							--ram1addr(15 downto 0) <= addr_readwrite(15 downto 0);
							--ram1addr(17 downto 16) <= "00";
							ram1data <= data_readwrite_in;
							seri_wrn <= '0';
							state := 6;
                  else
							ram1oe <= '1';
							ram1addr(15 downto 0) <= addr_readwrite(15 downto 0);
							ram1addr(17 downto 16) <= "00";
							ram1data <= data_readwrite_in;
							state := 3;
						end if;
					end if;
				when 2 => 
					-- read memory
					data_readwrite_out <= ram1data;
					pause_req <= '0';
					state := 0;--end read memory
				when 3 =>
					-- write memory
					ram1we <= '0'; 
					state := 4;
				when 4 =>
					ram1we <= '1';
					ram1oe <= '0';
					ram1data <= "ZZZZZZZZZZZZZZZZ";
					pause_req <= '0';
					state := 0;-- end write memory
				when 5 =>
					data_readwrite_out <= ram1data;
					ram1en <= '0';
					ram1oe <= '0';
					ram1we <= '1';
					seri_rdn <= '1';					
					pause_req <= '0';
					state := 0;
				when 6 =>
					seri_wrn <= '1';
					state := 7;
				when 7 =>
					ram1en <= '0';
					ram1oe <= '0';
					ram1data <= "ZZZZZZZZZZZZZZZZ";
					pause_req <= '0';
					state := 0;
				when 8 =>
					data_readwrite_out <= "000000000000000" & cam_data;
					pause_req <= '0';
					state := 0;
				when others =>
					state := 0;
			end case;
		end if;
		-- when ending load/store, make sure it is suitable to read memory
	end process;
end Behavioral;

