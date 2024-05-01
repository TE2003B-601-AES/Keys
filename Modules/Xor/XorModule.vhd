----------------------------------------------------------------------------------
-- Company:				ITESM - IRS 2024
-- Authors: - Jonathan Arles Guevara Molina
--          - Mario Godínez Chavero
--          - Grant Nathaniel Keegan
-- Create Date: 		22/04/2024
-- Design Name: 		Xor
-- Module Name:		Xor Module
-- Target Devices: 	DE10-Lite
-- Description: 		Xor Module
--
-- Version 1.0 - File Creation
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity XorModule is
	Port (
		suBytedWord : in STD_LOGIC_VECTOR(31 downto 0);
		cypher_key : in STD_LOGIC_VECTOR(127 downto 0);
		new_cypher_key : out STD_LOGIC_VECTOR(127 downto 0)
		
	);
end XorModule;

architecture Behavioral of XorModule is

	--signal column0, column1, column2, column3 : std_logic_vector(31 downto 0);
	shared variable rCon_index : integer := 0; --Indice
	shared variable column0 : std_logic_vector(31 downto 0);
	shared variable column1 : std_logic_vector(31 downto 0);
	shared variable column2 : std_logic_vector(31 downto 0);
	shared variable column3 : std_logic_vector(31 downto 0);
	shared variable temp : std_logic_vector(31 downto 0);
	
	type rCon_array is array (0 to 9) of std_logic_vector(31 downto 0);
	constant rCon : rCon_array := (
		  x"01000000", x"02000000", x"04000000", x"08000000", x"10000000", x"20000000", x"40000000", x"60000000", x"1B000000", x"36000000"
	);

	
	
begin 
	process(cypher_key, suBytedWord)
	begin 
		column0 := cypher_key(127 downto 96);
		column1 := cypher_key(95 downto 64);
		column2 := cypher_key(63 downto 32);
		column3 := cypher_key(31 downto 0);
		
		temp := column0 xor suBytedWord xor rCon(0); -- Primera columna
		column0 := temp;
		temp := column1 xor temp; -- Segunda columna
		column1 := temp;
		temp := column2 xor temp; -- Tercera columna
		column2 := temp;
		temp := column3 xor temp; -- Cuarta columna
		column3 := temp;
		
		new_cypher_key(127 downto 96) <= column0;
		new_cypher_key(95 downto 64) <= column1;
		new_cypher_key(63 downto 32) <= column2;
		new_cypher_key(31 downto 0) <= column3;
		
		rCon_index := rCon_index + 1; -- Incrementar el índice para la próxima iteración
	end process;
end Behavioral;
