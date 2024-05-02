----------------------------------------------------------------------------------
-- Company:				ITESM - IRS 2024
-- Engineers:	Israel Sandoval Sánchez
-- Create Date: 		22/04/2024
-- Design Name: 		Keys
-- Module Name:		Top Module
-- Project Name: 		Keys AES
-- Target Devices: 	DE10-Lite
-- Description: 		Keys del AES
--
-- Version 0.0 - File Creation
-- Additional Comments: 
--
----------------------------------------------------------------------------------

-- Commonly used libraries
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;

-- Entity declaration
entity Top is
    Port (
        -- Input ports
        Start 		: in std_logic;
        Clk 		: in std_logic;
		  Rst 		: in std_logic;
		  -- Input vector
		  KeySel 	: in std_logic_vector(3 downto 0);
        -- Output ports
        finish	   : out std_logic;
		  -- Output vector
		  KeyOut 	: out std_logic_vector(127 downto 0)
    );
end Top;

-- Architecture definition
architecture Behavioral of Top is

    -- Internal signals
    signal kk					: std_logic_vector(127 downto 0) := (others => '0');
	 signal CypherKeyIn		: std_logic_vector(127 downto 0) := X"2b7e151628aed2a6abf7158809cf4f3c";
    signal KEY_AUX 			: std_logic_vector(127 downto 0) := (others => '0');

    -- AES S-Box
	 type SBox_array is array (0 to 255) of std_logic_vector(7 downto 0);
	 constant SBox : SBox_array := (

	 --  0		1		  2		3		 4		  5		6		7		  8		9		A		  B		C		D		 E			F
		x"63", x"7C", x"77", x"7B", x"F2", x"6B", x"6F", x"C5", x"30", x"01", x"67", x"2B", x"FE", x"D7", x"AB", x"76",  -- 0
		x"CA", x"82", x"C9", x"7D", x"FA", x"59", x"47", x"F0", x"AD", x"D4", x"A2", x"AF", x"9C", x"A4", x"72", x"C0",  -- 1
		x"B7", x"FD", x"93", x"26", x"36", x"3F", x"F7", x"CC", x"34", x"A5", x"E5", x"F1", x"71", x"D8", x"31", x"15",  -- 2
		x"04", x"C7", x"23", x"C3", x"18", x"96", x"05", x"9A", x"07", x"12", x"80", x"E2", x"EB", x"27", x"B2", x"75",  -- 3
		x"09", x"83", x"2C", x"1A", x"1B", x"6E", x"5A", x"A0", x"52", x"3B", x"D6", x"B3", x"29", x"E3", x"2F", x"84",  -- 4
		x"53", x"D1", x"00", x"ED", x"20", x"FC", x"B1", x"5B", x"6A", x"CB", x"BE", x"39", x"4A", x"4C", x"58", x"CF",  -- 5 
		x"D0", x"EF", x"AA", x"FB", x"43", x"4D", x"33", x"85", x"45", x"F9", x"02", x"7F", x"50", x"3C", x"9F", x"A8",  -- 6
		x"51", x"A3", x"40", x"8F", x"92", x"9D", x"38", x"F5", x"BC", x"B6", x"DA", x"21", x"10", x"FF", x"F3", x"D2",  -- 7
		x"CD", x"0C", x"13", x"EC", x"5F", x"97", x"44", x"17", x"C4", x"A7", x"7E", x"3D", x"64", x"5D", x"19", x"73",  -- 8
		x"60", x"81", x"4F", x"DC", x"22", x"2A", x"90", x"88", x"46", x"EE", x"B8", x"14", x"DE", x"5E", x"0B", x"DB",  -- 9
		x"E0", x"32", x"3A", x"0A", x"49", x"06", x"24", x"5C", x"C2", x"D3", x"AC", x"62", x"91", x"95", x"E4", x"79",  -- A
		x"E7", x"C8", x"37", x"6D", x"8D", x"D5", x"4E", x"A9", x"6C", x"56", x"F4", x"EA", x"65", x"7A", x"AE", x"08",  -- B
		x"BA", x"78", x"25", x"2E", x"1C", x"A6", x"B4", x"C6", x"E8", x"DD", x"74", x"1F", x"4B", x"BD", x"8B", x"8A",  -- C
		x"70", x"3E", x"B5", x"66", x"48", x"03", x"F6", x"0E", x"61", x"35", x"57", x"B9", x"86", x"C1", x"1D", x"9E",  -- D
		x"E1", x"F8", x"98", x"11", x"69", x"D9", x"8E", x"94", x"9B", x"1E", x"87", x"E9", x"CE", x"55", x"28", x"DF",  -- E
		x"8C", x"A1", x"89", x"0D", x"BF", x"E6", x"42", x"68", x"41", x"99", x"2D", x"0F", x"B0", x"54", x"BB", x"16"   -- F
	);
	
	--signal column0, column1, column2, column3 : std_logic_vector(31 downto 0);
	signal rCon_index       : integer := 0; --Indice
	shared variable column0 : std_logic_vector(31 downto 0);
	shared variable column1 : std_logic_vector(31 downto 0);
	shared variable column2 : std_logic_vector(31 downto 0);
	shared variable column3 : std_logic_vector(31 downto 0);
	shared variable temp    : std_logic_vector(31 downto 0);
	
	type rCon_array is array (0 to 9) of std_logic_vector(31 downto 0);
	constant rCon : rCon_array := (
		  x"01000000", x"02000000", x"04000000", x"08000000", x"10000000", x"20000000", x"40000000", x"80000000", x"1B000000", x"36000000"
	);
	
	-- RAM variables:
	 type   RAM_memory is array (0 to 9) of std_logic_vector(127 downto 0);
    signal memory : RAM_memory;

begin

  process(Clk, KEY_AUX, CypherKeyIn)
  begin
    if (rising_edge (Clk)) then
	   -- Check if Synchronous Reset is taking place
	   if (Rst = '1') then
		  KEY_AUX <= (others => '0');
		else		  
			if (Start = '1' AND rCon_index < 10) then
				KEY_AUX <= CypherKeyIn(127 downto 32) & CypherKeyIn(23 downto 0) & CypherKeyIn(31 downto 24);
				
				KEY_AUX(7 downto 0)    <= SBox(to_integer(unsigned(CypherKeyIn(31 downto 24))));
				KEY_AUX(15 downto 8)   <= SBox(to_integer(unsigned(CypherKeyIn(7 downto 0))));
				KEY_AUX(23 downto 16)  <= SBox(to_integer(unsigned(CypherKeyIn(15 downto 8))));
				KEY_AUX(31 downto 24)  <= SBox(to_integer(unsigned(CypherKeyIn(23 downto 16))));
				
				--temp := CypherKeyIn(127 downto 96) xor KEY_AUX(31 downto 0) xor rCon(rCon_index); -- Primera columna
				temp := CypherKeyIn(127 downto 96) xor (SBox(to_integer(unsigned(CypherKeyIn(23 downto 16)))) & SBox(to_integer(unsigned(CypherKeyIn(15 downto 8)))) & SBox(to_integer(unsigned(CypherKeyIn(7 downto 0)))) & SBox(to_integer(unsigned(CypherKeyIn(31 downto 24))))) xor rCon(rCon_index); -- Primera columna
				column0 := temp;
				temp := CypherKeyIn(95 downto 64) xor temp; -- Segunda columna
				column1 := temp;
				temp := CypherKeyIn(63 downto 32) xor temp; -- Tercera columna
				column2 := temp;
				temp := CypherKeyIn(31 downto 0) xor temp; -- Cuarta columna
				column3 := temp;
				
				kk(127 downto 96) <= column0;
				kk(95 downto 64) <= column1;
				kk(63 downto 32) <= column2;
				kk(31 downto 0) <= column3;
				 
				KeyOut  <= CypherKeyIn;
				 
				CypherKeyIn(127 downto 96) <= column0;
				CypherKeyIn(95 downto 64) <= column1;
				CypherKeyIn(63 downto 32) <= column2;
				CypherKeyIn(31 downto 0) <= column3;		
				finish <= '0';
				
            -- RAM 
				memory(rCon_index) <= CypherKeyIn; --Writting in memory
				rCon_index  <= rCon_index + 1;
				
			else
				KEY_AUX <= (others => '0');
				finish <= '1';
				KeyOut <= memory(conv_integer(KeySel));
		   end if;
		end if;
    end if;
	
  end process;
  
end Behavioral;