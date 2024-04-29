
---------------------------------------------------
-- Company: ITESM - Campus Qro.
-- Autor: Eduardo Viveros
-- Date: 21/04/2024
-- DESING: TestBench Subytees_keys
---------------------------------------------------

-- Library and packages usage definition
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Entity of the device that will be simulated
entity SubBytes_keys_tb is
end SubBytes_keys_tb;


architecture SubBytes_keys_tb of SubBytes_keys_tb is 


   -- Component that will be simulated is declared as a component
	Component SubBytes_keys
		Port(
		     --Entrada
			  rotatedWord	: in  std_logic_vector(31 downto 0); --Input de 32 bits que viene de rotWord.
           --Salida
           suBytedWord	: out std_logic_vector(31 downto 0)
			 ); --Output de 32 bits. 
	end Component;
	

	-- Embebed signals that will be used to establish connection with the component to be simulated
	
	-- Inputs (Always Initialize Inputs) 
	signal rotatedWord   :   std_logic_vector(31 downto 0) := (others => '0'); 
   -- Outputs	
	signal suBytedWord	:   std_logic_vector(31 downto 0); 
	-- Intern signals for each byte 
	signal byte0, byte1, byte2, byte3: std_logic_vector(7 downto 0);

--	-- Constant that will be use in the cases     
--   constant SBox : SBox_array := (

--      0      1      2      3      4      5      6      7      8      9      10     11     12     13     14     15

--	 0  x"63", x"7C", x"77", x"7B", x"F2", x"6B", x"6F", x"C5", x"30", x"01", x"67", x"2B", x"FE", x"D7", x"AB", x"76",
--  1  x"CA", x"82", x"C9", x"7D", x"FA", x"59", x"47", x"F0", x"AD", x"D4", x"A2", x"AF", x"9C", x"A4", x"72", x"C0",
--	 2	 x"B7", x"FD", x"93", x"26", x"36", x"3F", x"F7", x"CC", x"34", x"A5", x"E5", x"F1", x"71", x"D8", x"31", x"15",
--	 3	 x"04", x"C7", x"23", x"C3", x"18", x"96", x"05", x"9A", x"07", x"12", x"80", x"E2", x"EB", x"27", x"B2", x"75",
--	 4	 x"09", x"83", x"2C", x"1A", x"1B", x"6E", x"5A", x"A0", x"52", x"3B", x"D6", x"B3", x"29", x"E3", x"2F", x"84",
--	 5	 x"53", x"D1", x"00", x"ED", x"20", x"FC", x"B1", x"5B", x"6A", x"CB", x"BE", x"39", x"4A", x"4C", x"58", x"CF",
--	 6	 x"D0", x"EF", x"AA", x"FB", x"43", x"4D", x"33", x"85", x"45", x"F9", x"02", x"7F", x"50", x"3C", x"9F", x"A8",
--	 7	 x"51", x"A3", x"40", x"8F", x"92", x"9D", x"38", x"F5", x"BC", x"B6", x"DA", x"21", x"10", x"FF", x"F3", x"D2",
--	 8	 x"CD", x"0C", x"13", x"EC", x"5F", x"97", x"44", x"17", x"C4", x"A7", x"7E", x"3D", x"64", x"5D", x"19", x"73",
--	 9	 x"60", x"81", x"4F", x"DC", x"22", x"2A", x"90", x"88", x"46", x"EE", x"B8", x"14", x"DE", x"5E", x"0B", x"DB",
--	10	 x"E0", x"32", x"3A", x"0A", x"49", x"06", x"24", x"5C", x"C2", x"D3", x"AC", x"62", x"91", x"95", x"E4", x"79",
--	11	 x"E7", x"C8", x"37", x"6D", x"8D", x"D5", x"4E", x"A9", x"6C", x"56", x"F4", x"EA", x"65", x"7A", x"AE", x"08",
--	12	 x"BA", x"78", x"25", x"2E", x"1C", x"A6", x"B4", x"C6", x"E8", x"DD", x"74", x"1F", x"4B", x"BD", x"8B", x"8A",
--	13	 x"70", x"3E", x"B5", x"66", x"48", x"03", x"F6", x"0E", x"61", x"35", x"57", x"B9", x"86", x"C1", x"1D", x"9E",
--	14	 x"E1", x"F8", x"98", x"11", x"69", x"D9", x"8E", x"94", x"9B", x"1E", x"87", x"E9", x"CE", x"55", x"28", x"DF",
--	15	 x"8C", x"A1", x"89", x"0D", x"BF", x"E6", x"42", x"68", x"41", x"99", x"2D", x"0F", x"B0", x"54", x"BB", x"16"

--	);	
	
begin

   --Instantiate the component that will be simulated
	DUT : SubBytes_keys port map(
	
	      rotatedWord => rotatedWord,
	      suBytedWord => suBytedWord
	);
	
   -- Stimulus (Test cases) (Note: no sensibility list)
	process
	begin
	
	   rotatedWord <= x"12345678"; -- example input
		wait for 10 ns;
	   assert suBytedWord = x"8A84EB01" report "Test case 1 failed!" severity error;
		
		rotatedWord <= x"C918B1BC"; -- example input
		wait for 10 ns;
	   assert suBytedWord = x"8A84EB01" report "Test case 2 failed!" severity error;
		
		rotatedWord <= x"87654321"; -- example input
		wait for 10 ns;
	   assert suBytedWord = x"8A84EB01" report "Test case 3 failed!" severity error;
		
		rotatedWord <= x"20308090"; -- example input
		wait for 10 ns;
	   assert suBytedWord = x"635C377B" report "Test case 4 failed!" severity error;

--		
--		rotatedWord <= "87654321"; -- Test case 2: entrada con patrón ascendente
--	   wait for 10 ns;
--	   assert suBytedWord = "635C377B" report "Test case 2 failed!" severity error;
		
		wait; 
	end process;

	
end SubBytes_keys_tb;
		
		

	   
	
	
	