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
  ,inout        iic_scl_io
  ,inout        iic_sda_io
  ,output [1:0] iic_pup
);

  wire [3:0] led_4bits;
  wire [3:0] push_buttons_4bits;
  wire       reset;
  wire [7:0] sig_out;
  wire [7:0] sig_in ;
  wire       sys_clock;
  wire       usb_uart_rxd;
  wire       usb_uart_txd;
  wire       iic_scl_io;
  wire       iic_sda_io;
  wire [1:0] iic_pup;

  arty_mb_wrapper arty_mb_wrapper_i
    (.led_4bits          (led_4bits         ),
     .push_buttons_4bits (push_buttons_4bits),
     .reset              (reset             ),
     .sig_out            (sig_out[7:4]      ),
     .sys_clock          (sys_clock         ),
     .usb_uart_rxd       (usb_uart_rxd      ),
     .usb_uart_txd       (usb_uart_txd      ),
     .IIC_scl_io         (iic_scl_io        ),
     .IIC_sda_io         (iic_sda_io        )
	 );
		
//---------------
//-- user code --
//---------------
assign sig_out[0] = ~(sig_in[1] & sig_in[0]) ;
assign sig_out[1] = ~(sig_in[3] & sig_in[2]) ;
assign sig_out[2] = ~(sig_in[4] & sig_in[5]) ;
assign sig_out[3] = ~(sig_in[6] & sig_in[7]) ;
assign sig_in[7:0]  = sig_in[7:0]   ;
assign iic_pup[1:0] = {2{1'b1}}   ;
//---------------
endmodule
