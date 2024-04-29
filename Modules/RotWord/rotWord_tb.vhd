----------------------------------------------------------------------------------
-- Company:        ITESM - Campus Qro.
-- Engineer:       Kevin Alejandro Ramírez Luna 
-- 
-- Create Date:    07:05:34 04/18/2024 
-- Design Name: 
-- Module Name:    RotWord 
-- Project Name: 	 AES
-- Target Devices: 
-- Tool versions: 
-- Description:    Test bench of the module rotWord for the first step of the key schedule
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- In the entity the In´s and Out´s are no declared for the tb 
entity rotWord_tb is
end rotWord_tb;

-- Beginning of architecture
architecture rotWord_ARCH_tb of rotWord_tb is

    -- Component declaration for rotWord
    component rotWord
        port(
            column      : in std_logic_vector(31 downto 0);
            rotatedWord : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals to connect to the rotWord module
    signal column : std_logic_vector(31 downto 0) := (others => '0');
    signal rotatedWord : std_logic_vector(31 downto 0);

begin
    -- Instantiate the rotWord module
    Irot: rotWord port map (
        column => column,
        rotatedWord => rotatedWord
    );

    -- Test cases
    process
    begin
        -- Test case 1: Rotate a column with a specific pattern
        column <= x"12345678"; -- Example input
        wait for 10 ns;
        assert rotatedWord = x"56781234" report "Test case 1 failed" severity error;

        -- Add more test cases as needed

        -- Finish simulation
        wait;
    end process;
end architecture rotWord_ARCH_TB;
