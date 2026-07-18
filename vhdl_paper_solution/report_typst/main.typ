#set document(
  title: "Digital Systems and VHDL 3,4",
  author: ("Mohammad Mahdi Mohammadi"),
  date: datetime.today(),
)
#import "@preview/cetz:0.3.4": canvas, draw
#set page(
  paper: "a4",
  margin: (left: 2cm, right: 2cm, top: 2cm, bottom: 2cm),
  header: context {
    if counter(page).get().first() < 5 {
      []
    } else {
      [#text(size: 10pt)[#h(1fr) #counter(heading).display()]]
    }
  },
  footer: context [
    #align(center)[#counter(page).display()]
  ],
  numbering: "1",
)


//#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")

// Title Page
#set text(
  font: ("Arial"),
  size: 11pt,
)

#set raw(theme: auto)

#show raw.where(block: true): code => {
  show raw.line: line => {
    text(fill: rgb("#666666"))[#line.number]
    h(1em)
    line.body
  }

  block(
    fill: rgb("#eaf4ff"),
    inset: 10pt,
    radius: 6pt,
    width: 100%,
    text(fill: rgb("#111111"), code),
  )
}

#import "@preview/codelst:2.0.2": sourcecode

#set math.equation(numbering: "(1)")

#import "@preview/fletcher:0.5.8": diagram, node, edge

//vhdl syntax highlighting. 
#set raw(
  syntaxes: ("vhdl.sublime-syntax",),
  theme: "vhdl-blue.tmTheme",
)

// this is the preamble of the document 





#align(center)[
  #v(1cm)
  #image("hs_bremerhaven_logo2.png", width: 65%)
  
  #v(1cm)
  #text(size: 17pt, weight: "bold")[Bremerhaven University of Applied Sciences]
  
  #text(size: 12pt)[Master of Science in Embedded System Design WS25]
  
  #v(1.8cm)
  #line(length: 100%, stroke: 0.3pt)
  #show title: set text(size: 25pt, weight: "bold")
  #title()
  //#text(size: 24pt, weight: "bold")[ESD Project: Measurement Network Gateway]
  #line(length: 100%, stroke: 0.3pt)
  
  #v(1cm)
  //#text(size: 14pt)[Under Supervision of] \
  //#text(size: 14pt)[Prof. Dr.-Ing. Kai Mueller] \
  //#text(size: 14pt)[Prof. Dr.-Ing. Karsten Peter]
  
  #v(1cm)
  //#text(size: 14pt)[Submitted By]
  
  #table(
    columns: 3,
    stroke: none,
    align: left,
    [1], [Mohammad Mahdi Mohammadi], [(42719)],
    //[2], [Saeed Omidvari], [(41490)],
    //[3], [Alin Raj Rajagopalan], [(41520)],
    //[4], [Mohammad Reza Rahimi], [(42756)],
    //[5], [Mert Ali Türk], [(42746)],
    //[6], [Haizan Helet Cruz], [(42708)],
    //[7], [Akshay Vastrad], [(42723)],
    //[8], [Ameer Mohammad], [(42843)],
  )

  #v(7cm)
  #text(size: 12pt, weight: "bold")[ Date:  (Latest Draft): #datetime.today().display()]
  
  #text(size: 12pt, weight: "bold")[Document Type: (Notes)]
]

#pagebreak()

// Table of Contents
#outline(title: "Table of Contents", depth: 3)

#pagebreak()
= Psuedo Random Binary Sequence 
== Structural Implementation of PRBS
this circuit is the PRBS (pseudo random binary sequence generator 14_2), if u = '0', then it will generate the prbs sequence 1, 8, 4, 2, 9, 12, 6, 11, 5, 10, 13, 14, 15, 7, 3. \
if u = '1', then it will shift the number '1' inside the shift register and this vhdl code shows the structural implementation. 

#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st1 IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s14_st1 IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
    SIGNAL a : STD_LOGIC;
BEGIN
    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= q(1);
            q(1) <= q(2);
            q(2) <= q(3);
            q(3) <= a;
        END IF;
    END PROCESS;

    a <= u OR (q(1) XOR q(0));
    x <= q(0);

END ARCHITECTURE behavioral;
  ```
)
== Behavioral Implementation of PRBS
And the following code shows the behavioral implementation of the PRBS. 

#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st1_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s14_st1_bhv IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";

BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
        VARIABLE a : STD_LOGIC;
    BEGIN
        IF rising_edge(clk) THEN
            IF u = '1' THEN
                q <= '1' & q(3 DOWNTO 1);
            ELSE
                IF q(1) = q(0) THEN
                    q <= '0' & q(3 DOWNTO 1);
                ELSE
                    q <= '1' & q(3 DOWNTO 1);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    x <= q(0);
END ARCHITECTURE behavioral;
  ```
)

= 2-bit up/down counter
== Structural Implementation of 2-bit up counter
this circuit is a 2-bit up counter that counts up and down. it counts the rising edge of the input signal s.
The following code shows the structural implementation of the 2-bit up counter. 
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st2 IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s14_st2 IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    SIGNAL a, b, c, d, e, f : STD_LOGIC;

BEGIN
    -- combinational logic 
    a <= q(3) AND (NOT q(2));
    b <= a XOR q(0);
    c <= (NOT a) AND q(1);
    d <= q(1) AND (NOT q(0));
    e <= a AND (NOT q(1)) AND q(0);
    f <= c OR d OR e;

    -- outputs 
    x(0) <= q(0);
    x(1) <= q(1);

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= b;
            q(1) <= f;
            q(2) <= q(3);
            q(3) <= s;
        END IF;
    END PROCESS;
END ARCHITECTURE behavioral;
  ```
)

== Behavioral Implementation of 2-bit up/down counter
And the following code shows the behavioral implementation of the 2-bit up counter of the rising edge of signal s. 
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st2_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s14_st2_bhv IS
    SIGNAL q : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL s_prev : STD_LOGIC := '0';
    SIGNAL count : unsigned(1 DOWNTO 0) := "00";

BEGIN

    -- flipflops 
    ff : PROCESS (clk, s)
    BEGIN
        IF rising_edge(clk) THEN
            IF (s = '1') AND (s_prev = '0') THEN
                count <= count + 1;
            END IF;
            s_prev <= s;
        END IF;
    END PROCESS;

    x <= STD_LOGIC_VECTOR(count);
END ARCHITECTURE behavioral;
  ```
)

#pagebreak()
= 2-bit up/down counter 
== Structural Implementation of 2-bit up/down counter
this circuit is a 2-bit up-down counter that counts up and down. The output x represents the current count value of the counter. and this circuit is implemented in vhdl in structural style.

#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_2 IS
    PORT (
        clk : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s15_2 IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL a, b, c, d : STD_LOGIC;

BEGIN

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= NOT q(0);
            q(1) <= d;
            -- q(1) <= ((NOT q(2) AND q(1))) OR ((NOT q(2)) AND q(0)) OR (q(1) AND q(0));
            q(2) <= q(1);
        END IF;
    END PROCESS;

    -- combinational logic 
    a <= ((NOT q(2) AND q(1)));
    b <= ((NOT q(2)) AND q(0));
    c <= (q(1) AND q(0));
    d <= a OR b OR c;

    -- output logic 
    x <= q(1 DOWNTO 0);

END ARCHITECTURE behavioral;
  ```
)

== Behavioral Implementation of 2-bit up/down counter
And the following code shows the behavioral implementation of the 2-bit up-down counter.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_2_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s15_2_bhv IS
    SIGNAL count : unsigned(1 DOWNTO 0) := "00";
    SIGNAL cnt_up : STD_LOGIC := '1';

BEGIN

    -- flipflops 
    up_down_count : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF cnt_up = '1' THEN
                IF count = "11" THEN
                    count <= count + 1;
                    cnt_up <= '0';
                ELSE
                    count <= count + 1;
                END IF;
            ELSE
                IF count = "00" THEN
                    count <= count - 1;
                    cnt_up <= '1';
                ELSE
                    count <= count - 1;
                END IF;
            END IF;
        END IF;
    END PROCESS up_down_count;
    -- output logic 
    x <= STD_LOGIC_VECTOR(count);

END ARCHITECTURE behavioral;
  ```
)

= 2-bit counter 
== Structural Implementation of 2-bit counter
this circuit is a 2-bit counter that counts up when u = '1' and pause the counting when u = '0'. The output x represents the current count value of the counter. and this circuit is implemented in vhdl in structural style.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1 IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_1 IS
    SIGNAL q : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL a, b, c, d, e, f, g : STD_LOGIC;

BEGIN

    -- combinational logic 
    a <= u OR q(1);
    b <= q(1) OR q(0);
    c <= (NOT u) OR (NOT q(0)) OR (NOT q(1));
    d <= a AND b AND c;

    e <= (NOT u) AND q(0);
    f <= (NOT q(0)) AND u;
    g <= e OR f;

    -- output logic 
    x <= q(1 DOWNTO 0);

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= g;
            q(1) <= d;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;
  ```
)

== Behavioral Implementation of 2-bit counter
And the following code shows the behavioral implementation of the 2-bit counter.
#sourcecode(
```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_1_bhv IS
    SIGNAL q : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL cnt : unsigned(1 DOWNTO 0) := "00";

BEGIN

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF u = '0' THEN
                cnt <= cnt;
            ELSE
                cnt <= cnt + 1;
            END IF;
        END IF;
    END PROCESS;

    -- output 
    x <= STD_LOGIC_VECTOR(cnt);

END ARCHITECTURE behavioral;
```
)

= Bidirectional Shift Register
== Structural Implementation of Bidirectional Shift Register
this circuit is a bidirectional shift register with 4 bits. The input s controls the direction of the shift. When s = '0', the register shifts to the right, and when s = '1', it shifts to the left. The outputs x and y represent the second and first bits of the register, respectively.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_3a IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        x, y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_3a IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
    SIGNAL a, b, c, d : STD_LOGIC := '0';

    SIGNAL y_in : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
BEGIN

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(3) <= a;
            q(2) <= b;
            q(1) <= c;
            q(0) <= d;
        END IF;
    END PROCESS;

    -- combinational logic 
    a <= ((NOT s) AND q(0)) OR (s AND q(2));
    b <= ((NOT s) AND q(3)) OR (s AND q(1));
    c <= ((NOT s) AND q(2)) OR (s AND q(0));
    d <= ((NOT s) AND q(1)) OR (s AND q(3));

    --outputs 
    x <= q(1);
    y <= q(0);

    y_in <= q(1) & q(0);

END ARCHITECTURE behavioral;
  ```
)

== Behavioral Implementation of Bidirectional Shift Register
And the following code shows the behavioral implementation of the bidirectional shift register.

#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_2_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        x : OUT STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_2_bhv IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"1";
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF s = '0' THEN
                q <= q(0) & q(3 DOWNTO 1);
            ELSE
                q <= q(2 DOWNTO 0) & q(3);
            END IF;
        END IF;
    END PROCESS;

    -- output 
    x <= q(1);
    y <= q(0);

END ARCHITECTURE behavioral;
  ```
)

= Sequence Detector
== Structural Implementation of Sequence Detector
this circuit is a 5-bit shift register with a feedback loop that generates a specific output based on the input signal 'u' and the current state of the register. The output 'y' is determined by the logic conditions defined in the architecture.
the output becomes when the register sequence reaches "00101"
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s21_3a IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s21_3a IS
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
    SIGNAL a, b, c, d, e, f, g : STD_LOGIC := '0';
BEGIN

    -- combinational circuits 
    a <= u AND g;
    b <= q(4) AND g;
    c <= q(3) AND g;
    d <= q(2) AND g;
    e <= q(1) AND g;
    f <= q(4) AND (NOT q(3)) AND q(2) AND (NOT q(1)) AND (NOT q(0));
    g <= NOT f;

    -- output logic 
    y <= f;

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(4) <= a;
            q(3) <= b;
            q(2) <= c;
            q(1) <= d;
            q(0) <= e;
        END IF;
    END PROCESS;
END ARCHITECTURE behavioral;
  ```
)

== Behavioral Implementation of Sequence Detector
And the following code shows the behavioral implementation of the sequence detector.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s21_b IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s21_b IS
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            -- making the shift register 
            q <= u & q(4 DOWNTO 1);
            IF q = "10100" THEN
                y <= '1';
            ELSE
                y <= '0';
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;
  ```
)

= 4-bit Shift Register 
== Structural Implementation of 4-bit Shift Register
this circuit is a 4-bit shift register that will become "0000", when the data inside the register becomes "1110", then the output will become "0000". 
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s22_3a IS
    PORT (
        clk : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s22_3a IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"6";
    SIGNAL a, b, c, d, e : STD_LOGIC;
BEGIN

    --flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= a;
            q(1) <= b;
            q(2) <= c;
            q(3) <= d;
        END IF;
    END PROCESS ff;

    --combinational process
    a <= (NOT q(3)) AND e;
    b <= q(0) AND e;
    c <= q(1) AND e;
    d <= q(2) AND e;
    e <= NOT (q(3) AND q(3)) AND q(2) AND q(1) AND (NOT q(0));

    --the output 
    y <= q;

END ARCHITECTURE behavioral;
  ```
)

== Behavioral Implementation of 4-bit Shift Register
And the following code shows the behavioral implementation of the 4-bit shift register.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s22_b IS
    PORT (
        clk : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s22_b IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1101";
    SIGNAL yin : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            -- the data shift inside the register 
            q <= q(0) & q(3 DOWNTO 1);
            IF q = "1110" THEN
                yin <= (OTHERS => '0');
            ELSE
                yin <= q;
            END IF;
        END IF;
    END PROCESS;

    y <= yin;

END ARCHITECTURE behavioral;
  ```
)

= 3-bit Complementer
== Structural Implementation of 3-bit Complementer
this circuit is used to calculate the complement of a 3-bit number. The circuit has a control input u, which determines whether the output y is equal to the input x (when u=1) or the complement of the input x (when u=0). The circuit uses flip-flops to store the state of the output y, and combinational logic to calculate the next state based on the current state and the input x.

#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_3a IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s23_3a IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL a, b, c : STD_LOGIC;

BEGIN

    --flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(2) <= a;
            q(1) <= b;
            q(0) <= c;
        END IF;
    END PROCESS ff;

    --combinational logic 
    a <= (u AND x(2)) OR ((NOT u) AND ((q(2) AND (NOT q(1)) AND (NOT q(0))) OR ((NOT q(2) AND q(0))) OR ((NOT q(2)) AND q(1))));
    b <= (u AND x(1)) OR ((NOT u) AND (q(1) XOR q(0)));
    c <= (u AND x(0)) OR ((NOT u) AND q(0));

    --output combination logic 
    y <= q;

END ARCHITECTURE behavioral;
  ```
)

== Behavioral Implementation of 3-bit Complementer
And the following code shows the behavioral implementation of the 3-bit complementer.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_3b IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s23_3b IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL x_in : INTEGER := 0;
BEGIN

    x_in <= to_integer(signed(x));

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF u = '1' THEN
                q <= STD_LOGIC_VECTOR(to_signed(x_in, q'length));
            ELSE
                --complement logic
                q <= STD_LOGIC_VECTOR(to_signed(-x_in, q'length));
            END IF;
        END IF;
    END PROCESS;

    --combinational process 
    y <= q;

END ARCHITECTURE behavioral;
  ```
)

= 5-bit Variable Shift Register
== Structural Implementation of 5-bit Variable Shift Register
the circuit is a 5-bit variable shift register. 
when sel = 0, the register shifts right and the input d_in is shifted into the least significant bit.
when sel = 1, the register shift right the d_in twice into the least significant bit. 
the output is the current state of the register. 
this is the structural implementation of the circuit.

#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s24 IS
    PORT (
        clk : IN STD_LOGIC;
        d_in : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s24 IS
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
    SIGNAL a, b, c, d, e, f, g, h, i, j, k, l : STD_LOGIC;
BEGIN

    -- combinational circuits
    a <= a AND (NOT sel);
    b <= d_in AND sel;
    c <= a OR b;

    d <= q(1) AND (NOT sel);
    e <= q(0) AND sel;
    f <= d OR e;

    g <= q(2) AND (NOT sel);
    h <= q(1) AND sel;
    i <= g OR h;

    j <= q(3) AND (NOT sel);
    k <= q(2) AND sel;
    l <= j OR k;

    -- outputs 
    y <= q;

    -- flipflops
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= d_in;
            q(1) <= c;
            q(2) <= f;
            q(3) <= i;
            q(4) <= l;
        END IF;
    END PROCESS ff;

END behavioral;
  ```
)
== Behavioral Implementation of 5-bit Variable Shift Register
And the following code shows the behavioral implementation of the 5-bit variable shift register.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s24_3b IS
    PORT (
        clk : IN STD_LOGIC;
        d_in : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s24_3b IS
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN

    -- s_reg process 
    s_reg_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF sel = '1' THEN
                q <= q(3 DOWNTO 0) & d_in;
            ELSE
                IF d_in = '0' THEN
                    q <= q(2 DOWNTO 0) & "00";
                ELSE
                    q <= q(2 DOWNTO 0) & "11";
                END IF;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;
  ```
)

= Pattern Detector
== Structural Implementation of Pattern Detector
this circuit is a pattern detector, and detects how many times the pattern "010" appears in the input stream.

#sourcecode(
  ```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY s25_3st IS
	PORT (
		clk : IN STD_LOGIC;
		d_in : IN STD_LOGIC;
		y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE structural OF s25_3st IS
	SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	SIGNAL a, b, c, d, e, f, g, h : STD_LOGIC;
BEGIN

	-- sequential circuits 
	ff : PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			q(4) <= d_in;
			q(3) <= q(4);
			q(2) <= q(3);
			q(1) <= e;
			q(0) <= h;
		END IF;
	END PROCESS ff;

	-- combinational circuits
	a <= (NOT q(4)) AND q(3) AND (NOT q(2));
	b <= (NOT a) AND q(1);
	c <= q(1) AND (NOT q(0));
	d <= a AND (NOT q(1)) AND q(0);
	e <= b OR c OR d;

	f <= (NOT a) AND q(0);
	g <= a AND (NOT q(0));
	h <= f OR g;

	-- outputs 
	y <= q(1 DOWNTO 0);
END ARCHITECTURE structural;
  ``` 
)

== Behavioral Implementation of Pattern Detector
And the following code shows the behavioral implementation of the pattern detector.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s253b IS
    PORT (
        clk : IN STD_LOGIC;
        d_in : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s253b IS

    SIGNAL count : unsigned(1 DOWNTO 0) := "00";
    SIGNAL readbuf : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

BEGIN

    seq_det_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN

            -- Check the sequence including the current input bit
            IF readbuf = "010" THEN
                count <= count + 1;
            END IF;

            -- Shift the current input into the buffer
            readbuf <= readbuf(1 DOWNTO 0) & d_in;

        END IF;
    END PROCESS seq_det_p;

    y <= STD_LOGIC_VECTOR(count);

END ARCHITECTURE behavioral;
  ```
)

#pagebreak()
= UART Transmitter
The following code shows the implementation of a UART tranmsmitter in VHDL. (16_1)

#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        txdata : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
        TxD : OUT STD_LOGIC;
        done : OUT STD_LOGIC
    );
END ENTITY s16_1;

ARCHITECTURE behavioral OF s16_1 IS
    TYPE state_type IS (idle, state0, state_trans, state_parity, state_stopbit);
    SIGNAL state, next_state : state_type;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 6;
    SIGNAL cnt, cnt_i : counter_type;

BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                cnt <= 0;
            ELSE
                state <= next_state;
                cnt <= cnt_i;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process 
    comb_p : PROCESS (state, start, cnt)
    BEGIN
        -- default cases 
        done <= '0';
        next_state <= state;
        TxD <= '0';

        CASE state IS
            WHEN idle =>
                TxD <= '1';
                done <= '1';
                IF start = '1' THEN
                    next_state <= state0;
                END IF;
            WHEN state0 =>
                cnt_i <= 6;
                next_state <= state_trans;
            WHEN state_trans =>
                TxD <= txdata(cnt);
                IF cnt = 0 THEN
                    next_state <= state_parity;
                ELSE
                    cnt_i <= cnt - 1;
                END IF;
            WHEN state_parity =>
                TxD <= txdata(0) XOR txdata(1) XOR txdata(1) XOR txdata(2) XOR txdata(3) XOR txdata(4) XOR txdata(5) XOR txdata(6);
                next_state <= state_stopbit;
            WHEN state_stopbit =>
                TxD <= '1';
                next_state <= idle;
        END CASE;
    END PROCESS;

END ARCHITECTURE behavioral;
  ```
)

= Inverter Pulse Generator 
The following code shows the implementation of an inverter pulse generator in VHDL. (14_1)

#sourcecode(
  ```vhdl 
----------------------------------------------------------------------------------
-- Engineer: Mohammad Mahdi Mohammadi 
-- 
-- Create Date: 07/16/2026 11:28:10 AM
-- Design Name: 
-- Module Name: s14 - Behavioral
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY s14 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        ss : IN STD_LOGIC;
        s1, s2, s3 : OUT STD_LOGIC
    );
END s14;

ARCHITECTURE Behavioral OF s14 IS
    TYPE state_type IS (idle, st0, st1, st2, st3, st4, st5, off0, off1, off2, off3, off4, off5);
    SIGNAL state, next_state : state_type;

BEGIN

    -- sequential process
    -- for calculation of the next state.  
    seq_p : PROCESS (clk, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
            ELSE
                state <= next_state;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- combinational circuit 
    comb_p : PROCESS (state, ss)
    BEGIN
        -- default cases 
        next_state <= state;

        CASE state IS
            WHEN idle =>
                IF ss = '1' THEN
                    next_state <= st0;
                END IF;
            WHEN st0 =>
                s1 <= '1';
                s2 <= '0';
                s3 <= '0';
                IF ss = '1' THEN
                    next_state <= st1;
                ELSE
                    next_state <= off0;
                END IF;
            WHEN st1 =>
                s1 <= '1';
                s2 <= '1';
                s3 <= '0';
                IF ss = '1' THEN
                    next_state <= st2;
                ELSE
                    next_state <= off1;
                END IF;
            WHEN st2 =>
                s1 <= '0';
                s2 <= '1';
                s3 <= '0';
                IF ss = '1' THEN
                    next_state <= st3;
                ELSE
                    next_state <= off2;
                END IF;
            WHEN st3 =>
                s1 <= '0';
                s2 <= '1';
                s3 <= '1';
                IF ss = '1' THEN
                    next_state <= st4;
                ELSE
                    next_state <= off3;
                END IF;
            WHEN st4 =>
                s1 <= '0';
                s2 <= '0';
                s3 <= '1';
                IF ss = '1' THEN
                    next_state <= st5;
                ELSE
                    next_state <= off4;
                END IF;
            WHEN st5 =>
                s1 <= '1';
                s2 <= '0';
                s3 <= '1';
                IF ss = '1' THEN
                    next_state <= st0;
                ELSE
                    next_state <= off5;
                END IF;
            WHEN off0 =>
                IF ss = '1' THEN
                    next_state <= st1;
                END IF;
            WHEN off1 =>
                IF ss = '1' THEN
                    next_state <= st2;
                END IF;
            WHEN off2 =>
                IF ss = '1' THEN
                    next_state <= st3;
                END IF;
            WHEN off3 =>
                IF ss = '1' THEN
                    next_state <= st4;
                END IF;
            WHEN off4 =>
                IF ss = '1' THEN
                    next_state <= st5;
                END IF;
            WHEN off5 =>
                IF ss = '1' THEN
                    next_state <= st0;
                END IF;
        END CASE;
    END PROCESS comb_p;

END Behavioral;
  ```
)

= PWM Generator
The following code shows the implementation of a PWM generator in VHDL.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_2 IS
    GENERIC (
        NBITS : INTEGER := 12
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        pval : IN STD_LOGIC_VECTOR(NBITS - 1 DOWNTO 0);
        pwmout : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s15_2 IS
    SIGNAL counter : unsigned(NBITS - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN

    -- free running counter 
    cnt_p : PROCESS (clk, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                counter <= (OTHERS => '0');
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS cnt_p;

    -- PWM process 
    pwm_p : PROCESS (clk, enable, pval, counter, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                pwmout <= '0';
            ELSIF enable = '0' THEN
                pwmout <= '0';
            ELSIF counter > unsigned(pval) THEN
                pwmout <= '0';
            ELSE
                pwmout <= '1';
            END IF;
        END IF;
    END PROCESS pwm_p;

END ARCHITECTURE behavioral;
  ```
)

= Variable Frequency Generator
The following code shows the implementation of a variable frequency generator in VHDL.
#sourcecode(
  ```vhdl 
ENTITY s16 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        incr : IN STD_LOGIC;
        stop : IN STD_LOGIC;
        clk_out : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s16 IS
    TYPE state_type IS (idle, state_1_L, state_1_H, state_10_L, state_10_H);
    SIGNAL state, next_state : state_type;
    SIGNAL timer : INTEGER := 0;

    CONSTANT c1Mhz_coeff : INTEGER := 49;
    CONSTANT c10Mhz_coeff : INTEGER := 4;
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
        VARIABLE cnt : INTEGER := 0;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                cnt := 0;
            ELSE
                IF cnt = timer THEN
                    state <= next_state;
                    cnt := 0;
                ELSE
                    cnt := cnt + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process 
    comb_p : PROCESS (state, start, stop, incr)
    BEGIN
        -- default cases 
        next_state <= state;
        timer <= 0;
        clk_out <= '0';

        CASE state IS
            WHEN idle =>
                IF start = '1' THEN
                    next_state <= state_1_L;
                END IF;
            WHEN state_1_L =>
                timer <= c1Mhz_coeff;
                IF stop = '1' THEN
                    next_state <= idle;
                ELSIF incr = '1' THEN
                    next_state <= state_10_L;
                ELSE
                    next_state <= state_1_H;
                END IF;
            WHEN state_1_H =>
                clk_out <= '1';
                timer <= c1Mhz_coeff;
                IF stop = '1' THEN
                    next_state <= idle;
                ELSIF incr = '1' THEN
                    next_state <= state_10_L;
                ELSE
                    next_state <= state_1_L;
                END IF;
            WHEN state_10_L =>
                timer <= c10Mhz_coeff;
                IF stop = '1' THEN
                    next_state <= idle;
                ELSE
                    next_state <= state_10_H;
                END IF;
            WHEN state_10_H =>
                clk_out <= '1';
                timer <= c10Mhz_coeff;
                IF stop = '1' THEN
                    next_state <= idle;
                ELSE
                    next_state <= state_10_L;
                END IF;
        END CASE;
    END PROCESS;

END ARCHITECTURE behavioral;
  ```
)

= Minimum and Maximum Finder of stream of numbers
The following code shows the implementation of a minimum and maximum finder of stream of numbers in VHDL.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s21 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        x_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        xmin : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        xmax : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        done : OUT STD_LOGIC
    );
END ENTITY s21;

ARCHITECTURE Behavioral OF s21 IS
    TYPE state_type IS (idle, running);
    SIGNAL state : state_type := idle;
    SUBTYPE int12_t IS INTEGER RANGE -2048 TO 2047;
    SIGNAL xmin_i, xmax_i : int12_t;

BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                xmin_i <= 0;
                xmax_i <= 0;
            ELSE
                -- default cases 
                done <= '0';
                CASE state IS
                    WHEN idle =>
                        done <= '1';
                        IF start = '1' THEN
                            state <= running;
                            xmin_i <= to_integer(signed(x_in));
                            xmax_i <= to_integer(signed(x_in));
                        END IF;
                    WHEN running =>
                        IF to_integer(signed(x_in)) < xmin_i THEN
                            xmin_i <= to_integer(signed(x_in));
                        ELSE
                            xmin_i <= xmin_i;
                        END IF;

                        IF to_integer(signed(x_in)) > xmax_i THEN
                            xmax_i <= to_integer(signed(x_in));
                        ELSE
                            xmax_i <= xmax_i;
                        END IF;

                        IF start = '0' THEN
                            state <= idle;
                        END IF;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- outputs 
    xmin <= STD_LOGIC_VECTOR(to_signed(xmin_i, xmin'length));
    xmax <= STD_LOGIC_VECTOR(to_signed(xmax_i, xmax'length));

END ARCHITECTURE behavioral;
  ```
)

= CRC Generator
The following code shows the implementation of a CRC generator in VHDL.
#sourcecode(
  ```vhdl 
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2026 02:49:07 PM
-- Design Name: 
-- Module Name: s22 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY s22 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        crc : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        done : OUT STD_LOGIC
    );
END s22;

ARCHITECTURE Behavioral OF s22 IS
    TYPE state_type IS (idle, busy);
    SIGNAL state : state_type;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 8;
    SIGNAL cnt : counter_type := 0;

    -- for the flipflops 
    SIGNAL crc_i : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk, state, cnt)
        VARIABLE feedback : STD_LOGIC;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                crc_i <= x"0";
                cnt <= 0;
            ELSE
                -- default cases 
                done <= '0';

                CASE state IS
                    WHEN idle =>
                        done <= '1';
                        IF start = '1' THEN
                            cnt <= 7;
                            state <= busy;
                            crc_i <= x"0";
                        END IF;
                    WHEN busy =>
                        feedback := din(cnt) XOR crc_i(3);
                        crc_i(0) <= feedback;
                        crc_i(1) <= crc_i(0) XOR feedback;
                        crc_i(2) <= crc_i(1);
                        crc_i(3) <= crc_i(2);

                        IF cnt = 0 THEN
                            state <= idle;
                        ELSE
                            cnt <= cnt - 1;
                        END IF;
                END CASE;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- output 
    crc <= crc_i;

END Behavioral;
  ```
)

= UART Transmission Protocol
The following code shows the implementation of a UART transmission protocol in VHDL.
#sourcecode(
  ```vhdl 
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mohammad Mahdi Mohammadi
-- 
-- Create Date: 07/17/2026 12:01:47 AM
-- Design Name: 
-- Module Name: s23 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: UART serial tranmission protocol 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY s23 IS
    PORT (
        clk : IN STD_LOGIC;
        start : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        y_out : OUT STD_LOGIC
    );
END s23;

ARCHITECTURE Behavioral OF s23 IS
    TYPE state_type IS (idle, state_0, state_trans, state_parity, state_stop);
    SIGNAL state, next_state : state_type;

    SUBTYPE counter_type IS INTEGER RANGE 0 TO 7;
    SIGNAL cnt, cnt_i : counter_type;
    SIGNAL write_buf : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL read_buf : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

    SIGNAL y_out_i : STD_LOGIC := '0';

    CONSTANT MAXBITS : INTEGER := 8;
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                cnt <= 0;
            ELSE
                IF next_state = state_0 THEN
                    write_buf <= data_in;
                END IF;

                IF state = state_trans THEN
                    read_buf <= y_out_i & read_buf(7 DOWNTO 1);
                END IF;

                state <= next_state;
                cnt <= cnt_i;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- combinational process 
    comb_p : PROCESS (state, start, cnt)
    BEGIN
        -- default cases 
        next_state <= state;
        cnt_i <= cnt;
        y_out_i <= '1';

        CASE state IS
            WHEN idle =>
                y_out_i <= '1';
                IF start = '1' THEN
                    next_state <= state_0;
                END IF;
            WHEN state_0 =>
                cnt_i <= 0;
                y_out_i <= '0';
                next_state <= state_trans;
            WHEN state_trans =>
                y_out_i <= write_buf(cnt);
                --read_buf <= y_out_i & read_buf(7 downto 1); 
                IF cnt = MAXBITS - 1 THEN
                    next_state <= state_parity;
                ELSE
                    next_state <= state_trans;
                    cnt_i <= cnt + 1;
                END IF;
            WHEN state_parity =>
                y_out_i <= '1' XOR write_buf(MAXBITS - 1) XOR write_buf(MAXBITS - 2) XOR write_buf(MAXBITS - 3) XOR write_buf(MAXBITS - 4) XOR write_buf(MAXBITS - 5) XOR write_buf(MAXBITS - 6) XOR write_buf(MAXBITS - 7) XOR write_buf(MAXBITS - 8);
                next_state <= state_stop;
            WHEN state_stop =>
                -- stop bit   
                y_out_i <= '1';
                IF start = '0' THEN
                    next_state <= idle;
                ELSE
                    next_state <= state_trans;
                END IF;
        END CASE;
    END PROCESS comb_p;

    y_out <= y_out_i;
END Behavioral;
  ```
)

= Chirp Signal Generator
The following code shows the implementation of a chirp signal generator in VHDL.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s24 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        y_out : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s24 IS
    TYPE state_type IS (idle, state_l, state_h);
    SIGNAL state, next_state : state_type;

    SUBTYPE clk_cycle_type IS INTEGER RANGE 0 TO 16;
    TYPE no_of_clk_array IS ARRAY(0 TO 6) OF clk_cycle_type;
    SIGNAL no_clk_cycles : no_of_clk_array := (7, 6, 5, 4, 3, 1, 0);

    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 15;
    SIGNAL timer : counter_type := 0;
    SIGNAL cnt, cnt_i : int16_t := 0;
BEGIN

    -- sequential process 
    -- timed state machine 
    seq_p : PROCESS (clk, reset)
        VARIABLE count : counter_type := 0;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                count := 0;
                cnt <= 0;
            ELSE
                IF count = timer THEN
                    state <= next_state;
                    cnt <= cnt_i;
                    count := 0;
                ELSE
                    count := count + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process 
    comb_p : PROCESS (state, cnt_i, start, cnt)
    BEGIN
        -- default cases 
        next_state <= state;
        cnt_i <= cnt;
        timer <= 0;

        CASE state IS
            WHEN idle =>
                y_out <= '0';
                cnt_i <= 0;
                IF start = '1' THEN
                    next_state <= state_l;
                END IF;
            WHEN state_l =>
                y_out <= '0';
                timer <= no_clk_cycles(cnt);
                next_state <= state_h;
            WHEN state_h =>
                y_out <= '1';
                timer <= no_clk_cycles(cnt_i);
                cnt_i <= cnt + 1;

                IF start = '0' THEN
                    next_state <= idle;
                    cnt_i <= 0;
                ELSE
                    IF cnt = 6 THEN
                        cnt_i <= 0;
                    END IF;
                    next_state <= state_l;
                END IF;
        END CASE;
    END PROCESS;

END ARCHITECTURE behavioral;
  ```
)

= Sign Change Counter
The following code shows the implementation of a sign change counter in VHDL.
#sourcecode(
  ```vhdl 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25 IS
    GENERIC (
        DATA_NBITS : INTEGER := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        meas_on : IN STD_LOGIC;
        d_in : IN STD_LOGIC_VECTOR(DATA_NBITS - 1 DOWNTO 0);
        sign_cnt : OUT STD_LOGIC_VECTOR(DATA_NBITS - 1 DOWNTO 0)
    );
END s25;

ARCHITECTURE behavioral OF s25 IS
    TYPE state_type IS (idle, init, sample);
    SIGNAL state, next_state : state_type;

    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;

    SIGNAL sign_cnt_i : int16_t := 0;
    SIGNAL sign_cnt_ii : int16_t := 0;
    SIGNAL prev_val, prev_val_i, current_val, current_val_i : signed(DATA_NBITS - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                sign_cnt_i <= 0;
                prev_val <= (OTHERS => '0');
                current_val <= (OTHERS => '0');
            ELSE
                state <= next_state;
                sign_cnt_i <= sign_cnt_ii;
                prev_val <= prev_val_i;
                current_val <= current_val_i;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process 
    comb_p : PROCESS (state, meas_on, prev_val, current_val)
    BEGIN
        -- default cases 
        next_state <= state;
        sign_cnt_ii <= sign_cnt_i;
        prev_val_i <= prev_val;
        current_val_i <= current_val;

        CASE state IS
            WHEN idle =>
                IF meas_on = '1' THEN
                    next_state <= init;
                END IF;
            WHEN init =>
                prev_val_i <= signed(d_in);
                next_state <= sample;
            WHEN sample =>
                IF prev_val_i(DATA_NBITS - 1) /= d_in(DATA_NBITS - 1) THEN
                    sign_cnt_ii <= sign_cnt_ii + 1;
                END IF;
                IF meas_on = '0' THEN
                    next_state <= idle;
                ELSE
                    next_state <= sample;
                END IF;
                prev_val_i <= signed(d_in);
        END CASE;
    END PROCESS;

    -- outputs 
    sign_cnt <= STD_LOGIC_VECTOR(to_signed(sign_cnt_ii, sign_cnt'length));

END ARCHITECTURE behavioral;
  ```
)
