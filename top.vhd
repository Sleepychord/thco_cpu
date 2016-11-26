----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:20:37 11/14/2016 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
    Port ( clk_raw : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           output : out  INT16;--LED LIGHT
           ram1addr : out  STD_LOGIC_VECTOR(17 DOWNTO 0);
           ram1data : inout  INT16;
           ram1en : out  STD_LOGIC;
           ram1oe : out  STD_LOGIC;
           ram1we : out  STD_LOGIC;
           ram2addr : out  STD_LOGIC_VECTOR(17 DOWNTO 0);
           ram2data : inout  INT16;
           ram2en : out  STD_LOGIC;
           ram2oe : out  STD_LOGIC;
           ram2we : out  STD_LOGIC;
           seri_rdn : out  STD_LOGIC;
           seri_wrn : out  STD_LOGIC;
           seri_dataready : in  STD_LOGIC;
           seri_tbre : in  STD_LOGIC;
           seri_tsre : in  STD_LOGIC
           --digits : out  STD_LOGIC_VECTOR(6 DOWNTO 0)-- DIGITAL LIGHTS
			  );
end top;

architecture Behavioral of top is
	component pause
    Port ( pause_req_id : in  STD_LOGIC;
			  pause_req_mem : in STD_LOGIC;
           pause_res_if_id : out  STD_LOGIC;
			  pause_res_ex_mem : out STD_LOGIC;
			  pause_res_mem_wb : out STD_LOGIC;
           pause_res_id_ex : out  STD_LOGIC_VECTOR(1 downto 0));
	end component;
   COMPONENT if_id
    Port ( is_paused : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           id_pc : out  INT16;
			  id_instruction : out INT16;
			  -- addr and instruction is port of reading instruction from sram
			  addr : out INT16;
			  instruction: in INT16;
			  --jump_target is the target address of JUMP instruction, 
			  jump_en : in STD_LOGIC;
           jump_target : in  INT16);
	END COMPONENT;
	COMPONENT id
    Port ( id_pc : in  INT16;
           id_instruction : in  INT16;
           read_addr1 : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           read_data1 : in  INT16;
			  read_addr2 : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           read_data2 : in  INT16;
           id_op: inout operation; -- OUT
           num1 : out  INT16;
           num2 : out  INT16;
			  num3 : out  INT16;
			  -- target_reg, if target is memory, store it in num1
           target_reg : inout STD_LOGIC_VECTOR(4 DOWNTO 0);--OUT
			  -- foward sideway
			  ex_target_reg : in STD_LOGIC_VECTOR(4 DOWNTO 0);
           jump_target : out INT16;
			  jump_en : out STD_LOGIC;
			  -- whether operation in exe phase is load
			  is_ex_load : in STD_LOGIC;
			  -- dicided by exe 's load_reg and op's reg
			  pause_req: out STD_LOGIC
			  );
	END COMPONENT;
	component id_ex
    Port ( id_op : in  operation;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  is_paused : in STD_LOGIC_VECTOR(1 downto 0);
           ex_op : out  operation;
           id_num1 : in  INT16;
           id_num2 : in  INT16;
           id_num3 : in  INT16;
           ex_num1 : out  INT16;
           ex_num2 : out  INT16;
           ex_num3 : out  INT16;
           id_target_reg : in STD_LOGIC_VECTOR(4 DOWNTO 0);
           ex_target_reg : out STD_LOGIC_VECTOR(4 DOWNTO 0));
	END COMPONENT;
	component ex
    Port ( num1 : in  INT16;
           num2 : in  INT16;
			  num3 : in  INT16;
           op : in  operation;
           target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  is_load : out STD_LOGIC;
			  ex_op : out operation;
			  -- ex_target_reg and data is to ex_mem and id
			  ex_target_reg : out STD_LOGIC_VECTOR(4 DOWNTO 0);
           data : out INT16;
           target_mem : out  INT16);
	end component;
	component ex_mem
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ex_op : operation;
           ex_target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           ex_data : in  INT16;
           ex_target_mem : in  INT16;
           mem_op : out operation;
           mem_target_reg : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           mem_data : out  INT16;
           mem_target_mem : out  INT16;
			  is_paused : in STD_LOGIC);
	end component;
	component mem
    Port ( data : in  INT16;
           target_mem : in  INT16;
           target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           op : in  operation;
           mem_op : out  operation;
			  -- interact with sram
			  sram_toggle : out STD_LOGIC_VECTOR(1 DOWNTO 0);
			  sram_addr : out INT16;
			  sram_data_in : in INT16;
			  sram_data_out : out INT16;
			  -- pass to mem/wb and forward to id
			  mem_data : out  INT16;
           mem_target_reg : out  STD_LOGIC_VECTOR(4 DOWNTO 0));
	end component;
	component mem_wb
    Port ( op : in  operation;
           mem_data : in  INT16;
           mem_target_reg : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  rst : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           wb_en : out  STD_LOGIC;
           wb_data : out  INT16;
           wb_target_reg : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
			  is_paused : in STD_LOGIC);
	end component;
	component reg
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
			  mem_target_data : in INT16);
	end component;
	component sram
    Port ( rst : in  STD_LOGIC;
           sclk : in  STD_LOGIC;
			  -- only-read ports is used to get instruction
           addr_readonly : in  INT16;
           data_readonly : out  INT16;
			  -- read-write ports is used to load or store
			  read_write_toggle: in STD_LOGIC_VECTOR(1 DOWNTO 0);
           addr_readwrite : in  INT16;
           data_readwrite_in : in  INT16;
			  data_readwrite_out : out INT16;
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
			  seri_tsre	: in std_logic;
			  pause_req : inout std_logic;
			  clk : in std_logic
			  );
	end component;
signal sclk : STD_LOGIC;
signal clk : STD_LOGIC := '0';
signal pause_req_id, pause_req_mem,
           pause_res_if_id,
			  pause_res_ex_mem,
			  pause_res_mem_wb : STD_LOGIC;
signal pause_res_id_ex : STD_LOGIC_VECTOR(1 downto 0);
signal id_pc, pc , id_instruction, instruction : INT16;
signal jump_en : STD_LOGIC;
signal jump_target : INT16;
signal read_addr1, read_addr2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal read_data1, read_data2 : INT16;
signal id_op, ex1_op, ex2_op, mem_op, wb_op: operation;
signal id_num1, id_num2, id_num3 : INT16;
signal ex_num1, ex_num2, ex_num3 : INT16;
signal id_target_reg, ex1_target_reg, ex2_target_reg : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal mem1_target_reg, mem2_target_reg, wb_target_reg : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal is_ex_load : STD_LOGIC;
signal ex_data, mem1_data, mem2_data, wb_data : INT16;
signal ex_target_mem, mem_target_mem : INT16;
signal sram_addr, sram_data_in, sram_data_out : INT16;
signal sram_toggle: STD_LOGIC_VECTOR(1 DOWNTO 0);
signal wb_en : STD_LOGIC;
signal started : STD_LOGIC := '0';
begin
	sclk <= clk_raw;
	process (rst, clk_raw)
	begin
		-- divide frequency
		if (rst = '0') then
			clk <= '0';
		elsif(clk_raw'event and clk_raw = '1' and started = '1')then
			clk <= not clk;
		end if;
	end process; 
	
	
	process(rst, sclk)
	variable tmp : integer := 0;
	begin
		if(rst = '0')then
			tmp := 0;
			started <= '0';
		elsif(sclk'event and sclk = '0')then
			if(tmp = 0)then
				tmp := 1;
			elsif(tmp = 1)then 
				tmp := 2;
				started <= '1';
			end if;
		end if;
	end process;

	u0:pause port map(pause_req_id,pause_req_mem, pause_res_if_id,pause_res_ex_mem,pause_res_mem_wb, pause_res_id_ex);
	u1:if_id port map(pause_res_if_id, clk, rst, id_pc, id_instruction, pc, instruction, jump_en, jump_target);
	u2:id port map(id_pc, id_instruction, read_addr1, read_data1, read_addr2, read_data2, id_op, id_num1, id_num2, id_num3, id_target_reg, ex2_target_reg, jump_target, jump_en, is_ex_load, pause_req_id);
	u3:id_ex port map(id_op, clk, rst, pause_res_id_ex, ex1_op, id_num1, id_num2, id_num3, ex_num1, ex_num2, ex_num3, id_target_reg, ex1_target_reg);
	u4:ex port map(ex_num1, ex_num2, ex_num3, ex1_op, ex1_target_reg, is_ex_load, ex2_op, ex2_target_reg, ex_data, ex_target_mem);
	u5:ex_mem port map(clk, rst, ex2_op, ex2_target_reg, ex_data, ex_target_mem, mem_op, mem1_target_reg, mem1_data, mem_target_mem, pause_res_ex_mem);
	u6:mem port map(mem1_data, mem_target_mem, mem1_target_reg, mem_op, wb_op, sram_toggle, sram_addr, sram_data_in, sram_data_out, mem2_data, mem2_target_reg);
	u7:mem_wb port map(wb_op, mem2_data, mem2_target_reg, rst, clk, wb_en, wb_data, wb_target_reg, pause_res_mem_wb);
	u8:reg port map(read_addr1, read_addr2, read_data1, read_data2, wb_en, wb_target_reg, wb_data, clk, rst, ex2_target_reg, ex_data, mem2_target_reg, mem2_data);
	
	
	u9:sram port map(rst, sclk, pc, instruction, sram_toggle, sram_addr, sram_data_out, sram_data_in, ram1en,
		ram1we, ram1oe, ram1addr, ram1data, ram2en, ram2we, ram2oe, ram2addr, ram2data, seri_rdn,
		seri_wrn, seri_dataready, seri_tbre, seri_tsre, pause_req_mem, clk);
	output<=mem1_data;
end Behavioral;
