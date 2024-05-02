----------------------------------------------------------------------------------
-- Company:				ITESM - IRS 2024
-- 
-- Create Date: 		22/04/2024
-- Design Name: 		Keys TestBench
-- Module Name:		Top Module TestBench
-- Target Devices: 	DE10-Lite
-- Description: 		TestBench de Keys del AES
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

-- Entity declaration for testbench
entity Top_tb is
end Top_tb;

-- Architecture definition for testbench
architecture tb_architecture of Top_tb is

     -- Component declaration for DUT (Device Under Test)
    component Top
        Port (
				  Start 		: in std_logic;
				  Clk 		: in std_logic;
				  Rst 		: in std_logic;
				  -- Input vector
				  --CypherKeyIn		: in std_logic_vector(127 downto 0) := "2b28ab097eaef7cf15d2154f16a6883c";
				  KeySel 	: in std_logic_vector(3 downto 0);
				  -- Output ports
				  finish	   : out std_logic;
				  -- Output vector
				  KeyOut 	: out std_logic_vector(127 downto 0)
        );
    end component;

    -- Signals declaration
   signal Start    		: std_logic						    	:= '0';
   signal Clk      		: std_logic                      := '0';
   signal Rst      		: std_logic                      := '0';
	signal KeySel	   	: std_logic_vector(3 downto 0)   := (others => '0');
	-- Outputs
	signal KeyOut			: std_logic_vector(127 downto 0);
	signal finish		   : std_logic;

   -- Clk Period
   constant Clk_period : time := 10 ns;	

	-- Instantiate the DUT
begin
        dut: Top port map (
                Start 	=> Start,
                Clk 		=> Clk,
                Rst 		=> Rst,
                KeySel 	=> KeySel,
					 KeyOut 	=> KeyOut,
					 finish 	=> finish
            );
	 
   -- Clock process definitions
   Clk_process: process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
	end process;


  -- Stimulus (Test cases) (Note: no sensitivity list)
  stim_process: process
  begin
    -- hold reset state for 100ns, always include the followint statement
	 wait for Clk_period;
	 
	 -- Test Case 1: First Round
	 Start   <= '1';
	 wait for 200 ns;
	 
	 -- Test Case 2: First Round
	 Start   <= '0';
	 wait for 20 ns;
	 
	 -- Test case 3
	 Start   <= '1';
	 wait for 20 ns;
	 
	 -- Test case 4
	 KeySel <= X"3";
	 wait for 20 ns;
	 
	 KeySel <= X"7";
	 wait for 20 ns;
	 wait;
	 
  end process;
    
end architecture tb_architecture;
