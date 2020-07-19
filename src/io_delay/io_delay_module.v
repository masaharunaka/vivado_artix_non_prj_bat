// io_delay_module.v
// author:manaka
// date:20/07/19
// Description:First

// History
// 
module io_delay_module
(
   input        rst
  ,input        clk
  ,input        rst_reg
  ,output       rdy     
  ,input        di_01
  ,output       do_01
  ,input        ldcnt_01
  ,input  [4:0] dicnt_01
  ,output [4:0] docnt_01  
  ,input        di_02
  ,output       do_02
  ,input        ldcnt_02
  ,input  [4:0] dicnt_02
  ,output [4:0] docnt_02  
  ,input        di_03
  ,output       do_03
  ,input        ldcnt_03
  ,input  [4:0] dicnt_03
  ,output [4:0] docnt_03  
  ,input        di_04
  ,output       do_04
  ,input        ldcnt_04
  ,input  [4:0] dicnt_04
  ,output [4:0] docnt_04  
);


// IDELAYCTRL: IDELAY/ODELAY Tap Delay Value Control 7 Series
// Xilinx HDL Libraries Guide, version 13.1
(* IODELAY_GROUP = "test_io_delay" *) // Specifies group name for associated IODELAYs and IDELAYCTRL
IDELAYCTRL IDELAYCTRL_inst (
    .RDY                    (rdy        ), // 1-bit Ready output
    .REFCLK                 (clk        ), // 1-bit Reference clock input
    .RST                    (rst        ) // 1-bit Reset input
);
// End of IDELAYCTRL_inst instantiation


// IDELAYE2: Input Fixed or Variable Delay Element
// 7 Series
// Xilinx HDL Libraries Guide, version 2012.2
// IDELAYE2 output1
(* IODELAY_GROUP = "test_io_delay" *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
IDELAYE2 #(
    .CINVCTRL_SEL           ("FALSE"    ), // Enable dynamic clock inversion (FALSE, TRUE)
    .DELAY_SRC              ("DATAIN"  ), // Delay input (IDATAIN, DATAIN)
    .HIGH_PERFORMANCE_MODE  ("FALSE"    ), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
    .IDELAY_TYPE            ("VAR_LOAD" ), // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
    .IDELAY_VALUE           (0          ), // Input delay tap setting (0-31)
    .PIPE_SEL               ("FALSE"    ), // Select pipelined mode, FALSE, TRUE
    .REFCLK_FREQUENCY       (200.0      ), // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
    .SIGNAL_PATTERN         ("DATA"     ) // DATA, CLOCK input signal
)
IDELAYE2_i01 (
    .CNTVALUEOUT            (docnt_01   ), // 5-bit output: Counter value output
    .DATAOUT                (do_01      ), // 1-bit output: Delayed data output
    .C                      (clk        ), // 1-bit input: Clock input
    .CE                     (1'b0       ), // 1-bit input: Active high enable increment/decrement input
    .CINVCTRL               (1'b0       ), // 1-bit input: Dynamic clock inversion input
    .CNTVALUEIN             (dicnt_01   ), // 5-bit input: Counter value input
    .DATAIN                 (di_01      ), // 1-bit input: Internal delay data input
    .IDATAIN                (1'b0       ), // 1-bit input: Data input from the I/O
    .INC                    (1'b0       ), // 1-bit input: Increment / Decrement tap delay input
    .LD                     (ldcnt_01   ), // 1-bit input: Load IDELAY_VALUE input
    .LDPIPEEN               (1'b0       ), // 1-bit input: Enable PIPELINE register to load data input
    .REGRST                 (rst_reg    )  // 1-bit input: Active-high reset tap-delay input
);

// IDELAYE2 output2
(* IODELAY_GROUP = "test_io_delay" *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
IDELAYE2 #(
    .CINVCTRL_SEL           ("FALSE"    ), // Enable dynamic clock inversion (FALSE, TRUE)
    .DELAY_SRC              ("DATAIN"  ), // Delay input (IDATAIN, DATAIN)
    .HIGH_PERFORMANCE_MODE  ("FALSE"    ), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
    .IDELAY_TYPE            ("VAR_LOAD" ), // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
    .IDELAY_VALUE           (0          ), // Input delay tap setting (0-31)
    .PIPE_SEL               ("FALSE"    ), // Select pipelined mode, FALSE, TRUE
    .REFCLK_FREQUENCY       (200.0      ), // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
    .SIGNAL_PATTERN         ("DATA"     ) // DATA, CLOCK input signal
)
IDELAYE2_i02 (
    .CNTVALUEOUT            (docnt_02   ), // 5-bit output: Counter value output
    .DATAOUT                (do_02      ), // 1-bit output: Delayed data output
    .C                      (clk        ), // 1-bit input: Clock input
    .CE                     (1'b0       ), // 1-bit input: Active high enable increment/decrement input
    .CINVCTRL               (1'b0       ), // 1-bit input: Dynamic clock inversion input
    .CNTVALUEIN             (dicnt_02   ), // 5-bit input: Counter value input
    .DATAIN                 (di_02      ), // 1-bit input: Internal delay data input
    .IDATAIN                (1'b0       ), // 1-bit input: Data input from the I/O
    .INC                    (1'b0       ), // 1-bit input: Increment / Decrement tap delay input
    .LD                     (ldcnt_02   ), // 1-bit input: Load IDELAY_VALUE input
    .LDPIPEEN               (1'b0       ), // 1-bit input: Enable PIPELINE register to load data input
    .REGRST                 (rst_reg    )  // 1-bit input: Active-high reset tap-delay input
);

// IDELAYE2 output3
(* IODELAY_GROUP = "test_io_delay" *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
IDELAYE2 #(
    .CINVCTRL_SEL           ("FALSE"    ), // Enable dynamic clock inversion (FALSE, TRUE)
    .DELAY_SRC              ("DATAIN"  ), // Delay input (IDATAIN, DATAIN)
    .HIGH_PERFORMANCE_MODE  ("FALSE"    ), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
    .IDELAY_TYPE            ("VAR_LOAD" ), // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
    .IDELAY_VALUE           (0          ), // Input delay tap setting (0-31)
    .PIPE_SEL               ("FALSE"    ), // Select pipelined mode, FALSE, TRUE
    .REFCLK_FREQUENCY       (200.0      ), // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
    .SIGNAL_PATTERN         ("DATA"     ) // DATA, CLOCK input signal
)
IDELAYE2_i03 (
    .CNTVALUEOUT            (docnt_03   ), // 5-bit output: Counter value output
    .DATAOUT                (do_03      ), // 1-bit output: Delayed data output
    .C                      (clk        ), // 1-bit input: Clock input
    .CE                     (1'b0       ), // 1-bit input: Active high enable increment/decrement input
    .CINVCTRL               (1'b0       ), // 1-bit input: Dynamic clock inversion input
    .CNTVALUEIN             (dicnt_03   ), // 5-bit input: Counter value input
    .DATAIN                 (di_03      ), // 1-bit input: Internal delay data input
    .IDATAIN                (1'b0       ), // 1-bit input: Data input from the I/O
    .INC                    (1'b0       ), // 1-bit input: Increment / Decrement tap delay input
    .LD                     (ldcnt_03   ), // 1-bit input: Load IDELAY_VALUE input
    .LDPIPEEN               (1'b0       ), // 1-bit input: Enable PIPELINE register to load data input
    .REGRST                 (rst_reg    )  // 1-bit input: Active-high reset tap-delay input
);

// IDELAYE2 output4
(* IODELAY_GROUP = "test_io_delay" *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
IDELAYE2 #(
    .CINVCTRL_SEL           ("FALSE"    ), // Enable dynamic clock inversion (FALSE, TRUE)
    .DELAY_SRC              ("DATAIN"  ), // Delay input (IDATAIN, DATAIN)
    .HIGH_PERFORMANCE_MODE  ("FALSE"    ), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
    .IDELAY_TYPE            ("VAR_LOAD" ), // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
    .IDELAY_VALUE           (0          ), // Input delay tap setting (0-31)
    .PIPE_SEL               ("FALSE"    ), // Select pipelined mode, FALSE, TRUE
    .REFCLK_FREQUENCY       (200.0      ), // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
    .SIGNAL_PATTERN         ("DATA"     ) // DATA, CLOCK input signal
)
IDELAYE2_i04 (
    .CNTVALUEOUT            (docnt_04   ), // 5-bit output: Counter value output
    .DATAOUT                (do_04      ), // 1-bit output: Delayed data output
    .C                      (clk        ), // 1-bit input: Clock input
    .CE                     (1'b0       ), // 1-bit input: Active high enable increment/decrement input
    .CINVCTRL               (1'b0       ), // 1-bit input: Dynamic clock inversion input
    .CNTVALUEIN             (dicnt_04   ), // 5-bit input: Counter value input
    .DATAIN                 (di_04      ), // 1-bit input: Internal delay data input
    .IDATAIN                (1'b0       ), // 1-bit input: Data input from the I/O
    .INC                    (1'b0       ), // 1-bit input: Increment / Decrement tap delay input
    .LD                     (ldcnt_04   ), // 1-bit input: Load IDELAY_VALUE input
    .LDPIPEEN               (1'b0       ), // 1-bit input: Enable PIPELINE register to load data input
    .REGRST                 (rst_reg    )  // 1-bit input: Active-high reset tap-delay input
);

endmodule
