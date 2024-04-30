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
use IEEE.NUMERIC_STD.ALL;  -- Librería para operaciones numéricas

entity XorModule is
    Port (
        First_Column : buffer STD_LOGIC_VECTOR(7 downto 0); -- Salida de datos de 8 bits
        clk : in STD_LOGIC;                          -- Entrada de reloj (no utilizado aun)
        suBytedWord : in STD_LOGIC_VECTOR(31 downto 0);   -- Entrada de datos de 8 bits en hexadecimal
        first_cipher_key : in std_logic_vector(127 downto 0);  -- Primera cipher key como matriz 4x4 (16 bytes)
        cypher_key : in std_logic_vector(7 downto 0);-- Clave de cifrado de 8 bits en hexadecimal
        rcon_index : in INTEGER range 1 to 10;       -- Índice de la tabla Rcon a utilizar (1 a 10)
        state_out : out STD_LOGIC_VECTOR(127 downto 0); -- Salida de la matriz de estado (4x4) en hexadecimal
        rcon_column : out STD_LOGIC_VECTOR(31 downto 0); -- Salida de la columna actual de Rcon en hexadecimal
        xor_count : out INTEGER                       -- Salida del contador de XOR realizados
    );
end XorModule;

architecture Behavioral of XorModule is

    -- Declaración de tipos de datos
    type cipher_key_matrix is array(0 to 3, 0 to 3) of std_logic_vector(7 downto 0);  -- Matriz de clave de cifrado
    type Rcon_array is array (0 to 39) of std_logic_vector(7 downto 0);  -- Matriz Rcon para AES
    type state_matrix is array(0 to 3, 0 to 3) of std_logic_vector(7 downto 0);  -- Matriz de estado para AES

    -- Constante Rcon para AES
    constant Rcon : Rcon_array := (
        x"01", x"02", x"04", x"08", x"10", x"20", x"40", x"60", x"1B", x"36",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00"
    );

    -- Señales y variables
    signal new_keys : cipher_key_matrix;  -- Matriz para almacenar las nuevas llaves
    variable rcon_counter : integer := 1;  -- Contador de Rcon
    variable current_rcon_column : std_logic_vector(31 downto 0) := Rcon(0);  -- Columna actual de Rcon
    variable state : state_matrix;  -- Matriz de estado para AES

    -- Función para operación XOR entre vectores
    function xor_operation_hex(a, b : STD_LOGIC_VECTOR(7 downto 0)) return STD_LOGIC_VECTOR is
        variable result : std_logic_vector(7 downto 0);
    begin
        result := std_logic_vector(unsigned(a) xor unsigned(b));
        return result;
    end xor_operation_hex;

    -- Procedimiento para realizar el XOR entre first_cipher_key y las columnas de la matriz de estado
    procedure xor_with_state_column(column_index : integer) is
    begin
        for i in 0 to 3 loop
            state(i, column_index) := xor_operation_hex(first_cipher_key((column_index * 32) + (8 * i) + 31 downto (column_index * 32) + (8 * i)), state(i, column_index - 1));
        end loop;
    end procedure;
     
begin
    -- Proceso principal
    process(clk)
    begin
        if rising_edge(clk) then
            -- Operaciones XOR iniciales
            First_Column <= xor_operation_hex(suBytedWord, cypher_key);
            state(0, 0) := xor_operation_hex(First_Column, current_rcon_column);
            state(1, 0) := xor_operation_hex(suBytedWord(7 downto 0), cypher_key(7 downto 0));
            state(2, 0) := xor_operation_hex(suBytedWord(15 downto 8), cypher_key(15 downto 8));
            state(3, 0) := xor_operation_hex(suBytedWord(23 downto 16), cypher_key(23 downto 16));

            -- Llamada al procedimiento para realizar el XOR con las siguientes columnas de first_cipher_key y la matriz de estado
            for col in 1 to 3 loop
                xor_with_state_column(col);
            end loop;

            -- Concatenar la matriz de estado en la salida state_out
            state_out <= state(0, 0) & state(1, 0) & state(2, 0) & state(3, 0) &
                         state(0, 1) & state(1, 1) & state(2, 1) & state(3, 1) &
                         state(0, 2) & state(1, 2) & state(2, 2) & state(3, 2) &
                         state(0, 3) & state(1, 3) & state(2, 3) & state(3, 3);
            
            -- Actualizar salidas xor_count y rcon_column
            xor_count <= rcon_counter;
            rcon_column <= current_rcon_column;
            
            -- Actualizar Rcon y first_cipher_key si el contador es menor que 10
            if rcon_counter < 10 then
                rcon_counter := rcon_counter + 1;
                current_rcon_column := Rcon(rcon_counter * 4 to (rcon_counter + 1) * 4 - 1);

                -- Copiar los valores de new_keys a first_cipher_key
                for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        first_cipher_key(i * 4 + j) <= new_keys(i, j);
                    end loop;
                end loop;
            end if;
        end if;
    end process;

end Behavioral;
