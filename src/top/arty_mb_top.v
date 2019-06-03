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
  ,output [7:0] sig_out
  ,input  [7:0] sig_in
  ,input        sys_clock
  ,input        usb_uart_rxd
  ,output       usb_uart_txd
);

  wire [3:0] led_4bits;
  wire [3:0] push_buttons_4bits;
  wire       reset;
  wire [7:0] sig_out;
  wire [7:0] sig_in ;
  wire       sys_clock;
  wire       usb_uart_rxd;
  wire       usb_uart_txd;

  arty_mb_wrapper arty_mb_wrapper_i
    (.led_4bits          (led_4bits         ),
     .push_buttons_4bits (push_buttons_4bits),
     .reset              (reset             ),
     .sig_out            (sig_out[7:4]      ),
     .sys_clock          (sys_clock         ),
     .usb_uart_rxd       (usb_uart_rxd      ),
     .usb_uart_txd       (usb_uart_txd      )
	 );
		
//---------------
//-- user code --
//---------------
assign sig_out[0] = ~(sig_in[1] & sig_in[0]) ;
assign sig_out[1] = ~(sig_in[3] & sig_in[2]) ;
assign sig_out[3:2] = {2{1'b0}}   ;
assign sig_in[7:0]  = sig_in[7:0]   ;

//---------------
endmodule
