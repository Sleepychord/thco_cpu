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
           addr_onlyread : in  INT16;
           data_onlyread : out  INT16;
			  -- read-write ports is used to load or store
           addr_readwrite : in  INT16;
           data_readwrite : inout  INT16;
           ram1en : out  STD_LOGIC;
           ram1we : out  STD_LOGIC;
           ram1oe : out  STD_LOGIC;
           ram1addr : out  STD_LOGIC_VECTOR(17 DOWNTO 0);
           ram1data : inout  INT16;
           ram2en : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           ram2oe : out  STD_LOGIC;
           ram2addr : out  STD_LOGIC_VECTOR(17 DOWNTO 0);
           ram2data : inout  INT16;
			  -- Serials, maybe need to be modified
			  seri_rdn: out STD_LOGIC := '1';
		     seri_wrn: out STD_LOGIC := '1';
			  seri_data_ready	: in std_logic;
			  seri_tbre	: in std_logic;
			  seri_tsre	: in std_logic
			  );
end sram;

architecture Behavioral of sram is

begin
	-- should handle serials, ram1, ram2 request
	-- the situation that visiting two different addr in the same ram might happen,
	-- maybe we can handle by using super clock to slice the time for this situation

end Behavioral;

