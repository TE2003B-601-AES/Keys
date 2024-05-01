----------------------------------------------------------------------------------
-- Company:				ITESM - IRS 2024
-- Authors: - Jonathan Arles Guevara Molina
--          - Mario Godínez Chavero
--          - Grant Nathaniel Keegan
-- Create Date: 		22/04/2024
-- Design Name: 		Xor
-- Module Name:		Xor Module test bench
-- Target Devices: 	DE10-Lite
-- Description: 		Xor Module test bench
--
-- Version 1.0 - File Creation
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity XorModule_tb is
end XorModule_tb;

architecture XorModule_tb_Arch of XorModule_tb is

component XorModule
 Port(suBytedWord    : in STD_LOGIC_VECTOR(31 downto 0);
		cypher_key     : in STD_LOGIC_VECTOR(127 downto 0);
		new_cypher_key : out STD_LOGIC_VECTOR(127 downto 0));
end component;
	--Inputs
	signal suBytedWord    : STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
	signal cypher_key     : STD_LOGIC_VECTOR(127 downto 0) := (others => '0'); 
	--Outputs
	signal new_cypher_key : STD_LOGIC_VECTOR(127 downto 0);
	
--Instantiate the component that will be simulated
begin
	DUT: XorModule port map(
		suBytedWord   => suBytedWord,
		cypher_key     => cypher_key,
		new_cypher_key => new_cypher_key);
		
--Test cases
	stim_process : process
		begin
			--wait for 100 ns;
			
			--Test Case 1:
			suBytedWord <= (x"8a84eb01");
			cypher_key <= (x"2b7e151628aed2a6abf7158809cf4f3c");
			wait for 200 ns;
			
			
		--  x"2b", x"28", x"ab", x"09", 
       -- x"7e", x"ae", x"f7", x"cf",
       -- x"15", x"d2", x"15", x"4f", 
       -- x"16", x"a6", x"88", x"3c"

			
			
			wait;
			
		end process;
end XorModule_tb_Arch;
		
		
