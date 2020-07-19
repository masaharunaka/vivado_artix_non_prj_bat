// arty_mb_top.v
// author:manaka
// date:19/06/03
// Description:First

// History
// 

module arty_mb_top
(
   output [3:0] led_4bits
  ,input  [3:0] push_buttons_4bits
  ,input        reset
  ,output [7:0] hp_out
  ,output [7:0] sig_out
  ,input  [7:0] sig_in
  ,input        sys_clock
  ,input        usb_uart_rxd
  ,output       usb_uart_txd
  ,inout        iic_scl_io
  ,inout        iic_sda_io
  ,output [1:0] iic_pup
);

  wire  [3:0] led_4bits_io       ;
  wire  [3:0] push_buttons_4bits ;
  wire        reset              ;
  wire        clk_io_ref         ;//200MHz
  wire  [7:0] sig_o              ;
  wire  [7:0] sig_i              ;
  wire        sys_clock          ;
  wire [31:0] sig_gpio02_1_o     ;
  wire [31:0] sig_gpio02_2_o     ;
  wire [31:0] sig_gpio02_1_i     ;
  wire [31:0] sig_gpio02_2_i     ;
  wire        usb_uart_rxd       ;
  wire        usb_uart_txd       ;
  wire        iic_scl_io         ;
  wire        iic_sda_io         ;
  wire  [1:0] iic_pup            ;

  wire  [4:0] sig_cnt            ;
  wire        sig_test_trg       ;

//------------------------------
//-- micro blaze block design --
//------------------------------

  arty_mb_wrapper arty_mb_wrapper_i
    (.led_4bits          (led_4bits_io      ),
     .push_buttons_4bits (push_buttons_4bits),
     .reset              (reset             ),
     .sig_out            (sig_o[7:4]        ),
     .sys_clock          (sys_clock         ),
     .clk_out2           (clk_io_ref        ),
     .gpio02_1_o         (sig_gpio02_1_o    ),
     .gpio02_2_o         (sig_gpio02_2_o    ),
     .gpio02_1_i         (sig_gpio02_1_i    ),
     .gpio02_2_i         (sig_gpio02_2_i    ),
     .usb_uart_rxd       (usb_uart_rxd      ),
     .usb_uart_txd       (usb_uart_txd      ),
     .IIC_scl_io         (iic_scl_io        ),
     .IIC_sda_io         (iic_sda_io        )
	 );


assign sig_gpio02_2_i        = sig_gpio02_2_o       ;
assign led_4bits[3:0]        = led_4bits_io[3:0]    ;
//------------------------------
//-- io_delay module  --
//------------------------------

  io_delay_module io_delay_module_i
    (.rst                   (reset                 ),
     .clk                   (clk_io_ref            ),
     .rst_reg               (reset                 ),
     .rdy                   (                      ),
     .di_01                 (sig_test_trg          ),
     .do_01                 (hp_out[1]             ),
     .ldcnt_01              (sig_gpio02_1_o[5]     ),
     .dicnt_01              (sig_gpio02_1_o[4:0]   ),
     .docnt_01              (sig_gpio02_1_i[4:0]   ),
     .di_02                 (sig_test_trg          ),
     .do_02                 (hp_out[2]             ),
     .ldcnt_02              (sig_gpio02_1_o[13]    ),
     .dicnt_02              (sig_gpio02_1_o[12:8]  ),
     .docnt_02              (sig_gpio02_1_i[12:8]  ),
     .di_03                 (sig_test_trg          ),
     .do_03                 (hp_out[3]             ),
     .ldcnt_03              (sig_gpio02_1_o[21]    ),
     .dicnt_03              (sig_gpio02_1_o[20:16] ),
     .docnt_03              (sig_gpio02_1_i[20:16] ),
     .di_04                 (sig_test_trg          ),
     .do_04                 (hp_out[4]             ),
     .ldcnt_04              (sig_gpio02_1_o[29]    ),
     .dicnt_04              (sig_gpio02_1_o[28:24] ),
     .docnt_04              (sig_gpio02_1_i[28:24] ) 
    );

assign sig_gpio02_1_i[ 7: 6] = sig_gpio02_1_o[ 7: 6];
assign sig_gpio02_1_i[15:14] = sig_gpio02_1_o[15:14];
assign sig_gpio02_1_i[23:22] = sig_gpio02_1_o[23:22];
assign sig_gpio02_1_i[31:30] = sig_gpio02_1_o[31:30];
    
assign  hp_out[0]    = sig_test_trg     ;
assign  hp_out[7:5]  = 3'b000           ;
//---------------------------------------
//-- Counter module for uo delay test  --
//---------------------------------------

defparam counter_inst.COUNT_WIDTH = 5;
COUNTER counter_inst(
         .rst        (reset      )     
        ,.clk        (clk_io_ref )     
        ,.clr        (1'b0       )     
        ,.en         (1'b1       )     
        ,.cnt_out    (sig_cnt    )     
    );

//assign sig_test_trg = &sig_cnt;// reduction 
assign sig_test_trg = sig_cnt[4];

//---------------
//-- user code --
//---------------
assign sig_o[0]     = ~(sig_i[1] & sig_i[0]) ;
assign sig_o[1]     = ~(sig_i[3] & sig_i[2]) ;
assign sig_o[2]     = ~(sig_i[4] & sig_i[5]) ;
assign sig_o[3]     = ~(sig_i[6] & sig_i[7]) ;
assign sig_i[7:0]   = sig_in[7:0]            ;
assign sig_out[7:0] = sig_o[7:0]             ;
assign iic_pup[1:0] = {2{1'b1}}              ;
//---------------
endmodule
