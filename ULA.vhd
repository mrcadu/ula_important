library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--------------------------- ENTITY

entity ULA is
    Port ( entrada1 : in  STD_LOGIC_VECTOR (3 downto 0);
           entrada2 : in  STD_LOGIC_VECTOR (3 downto 0);
			  selecao : in  STD_LOGIC_VECTOR (3 downto 0);
			  saidaFinal : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  flags:out STD_LOGIC_VECTOR (3 downto 0));
           
end ULA;

--------------------------- ENTITY

--------------------------- ARCHITECTURE

architecture Behavioral of ULA is	

---------------------COMPONENTES

----COMPLEMENTO2

component complemento2 
    Port ( num1 : in  STD_LOGIC_VECTOR(3 downto 0);
           saida : buffer  STD_LOGIC_VECTOR(3 downto 0)
			  );
end component complemento2;
----

----FULLADDER4BITS

component fullAdder4bits

    Port ( num1: in  STD_LOGIC_VECTOR (3 downto 0);
           num2 : in  STD_LOGIC_VECTOR (3 downto 0);
           Cin : in  STD_LOGIC;
           Sum : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  flags: out STD_LOGIC_VECTOR(3 downto 0));
			  
end component fullAdder4bits;
----

---- SUBTRATOR
component Subtrator
	PORT (
				minuendo: in STD_LOGIC_VECTOR( 3 downto 0);
				subtraendo: in STD_LOGIC_VECTOR( 3 downto 0);
				saida: buffer STD_LOGIC_VECTOR (3 downto 0);
				flags: out STD_LOGIC_VECTOR (3 downto 0));
				
end component Subtrator;
----

---- AND
component AandB
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  flags : out STD_LOGIC_VECTOR (3 downto 0));
end component AandB;
----

---- NAND
component AnandB
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  flags : out STD_LOGIC_VECTOR (3 downto 0));
end component AnandB;
----

---- OR
component AorB
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  flags : out STD_LOGIC_VECTOR (3 downto 0));
end component AorB;
----

---- NOR
component AnorB
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  flags : out STD_LOGIC_VECTOR (3 downto 0));
end component AnorB;
----

---- XOR
component AxorB
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  flags : out STD_LOGIC_VECTOR (3 downto 0));
end component AxorB;
----

---- XNOR
component AxnorB
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  flags : out STD_LOGIC_VECTOR (3 downto 0));
end component AxnorB;
----


---------------------COMPONENTES

-----------SINAIS

signal saida_AND: STD_LOGIC_VECTOR (3 downto 0);
signal saida_NAND: STD_LOGIC_VECTOR (3 downto 0);
signal saida_OR: STD_LOGIC_VECTOR (3 downto 0);
signal saida_NOR: STD_LOGIC_VECTOR (3 downto 0);
signal saida_XOR: STD_LOGIC_VECTOR (3 downto 0);
signal saida_XNOR: STD_LOGIC_VECTOR (3 downto 0);
signal saida_COMPLEMENTO2: STD_LOGIC_VECTOR (3 downto 0);
signal saida_SUBTRATOR: STD_LOGIC_VECTOR (3 downto 0);
signal saida_FULLADDER : STD_LOGIC_VECTOR (3 downto 0);
signal flags_AND: STD_LOGIC_VECTOR (3 downto 0);
signal flags_NAND: STD_LOGIC_VECTOR (3 downto 0);
signal flags_OR: STD_LOGIC_VECTOR (3 downto 0);
signal flags_NOR: STD_LOGIC_VECTOR (3 downto 0);
signal flags_XOR: STD_LOGIC_VECTOR (3 downto 0);
signal flags_XNOR: STD_LOGIC_VECTOR (3 downto 0);
signal flags_COMPLEMENTO2: STD_LOGIC_VECTOR (3 downto 0);
signal flags_SUBTRATOR: STD_LOGIC_VECTOR (3 downto 0);
signal flags_FULLADDER : STD_LOGIC_VECTOR (3 downto 0);

-----------SINAIS

begin

	 
	 FUNCTION_AND : AandB PORT MAP (entrada1, entrada2, saida_AND,flags_AND);
	 FUNCTION_NAND : AnandB PORT MAP (entrada1, entrada2, saida_NAND,flags_NAND);
    FUNCTION_OR : AorB PORT MAP (entrada1, entrada2, saida_OR,flags_OR);
	 FUNCTION_NOR : AnorB PORT MAP (entrada1, entrada2, saida_NOR,flags_NOR);
	 FUNCTION_XOR : AxorB PORT MAP (entrada1, entrada2, saida_XOR,flags_XOR);
    FUNCTION_XNOR : AxnorB PORT MAP (entrada1, entrada2, saida_XNOR,flags_XNOR);    
	 FUNCTION_COMPLEMENTO2 : complemento2 PORT MAP (entrada1, saida_COMPLEMENTO2);
    FUNCTION_FULLADDER : fullAdder4bits PORT MAP (entrada1, entrada2, '0' ,saida_FULLADDER,flags_FULLADDER);
    FUNCTION_SUBTRATOR : Subtrator PORT MAP (entrada1, entrada2,saida_SUBTRATOR,flags_SUBTRATOR);
	 
WITH selecao SELECT saidaFinal<=  
								saida_OR WHEN "0001",
								saida_SUBTRATOR WHEN "0010",
								saida_FULLADDER WHEN "0011",
								saida_COMPLEMENTO2 WHEN "0100",
								saida_XOR WHEN "0101",
								saida_NAND WHEN "0110",
								saida_NOR WHEN "0111",
								saida_XNOR WHEN "1000",
								saida_AND WHEN "1001",
								"0000" WHEN OTHERS; --
WITH selecao SELECT flags<=  
								flags_OR WHEN "0001",
								flags_SUBTRATOR WHEN "0010",
								flags_FULLADDER WHEN "0011",
								flags_COMPLEMENTO2 WHEN "0100",
								flags_XOR WHEN "0101",
								flags_NAND WHEN "0110",
								flags_NOR WHEN "0111",
								flags_XNOR WHEN "1000",
								flags_AND WHEN "1001",
								"0000" WHEN OTHERS; --

end Behavioral;
