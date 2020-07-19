//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
//Date        : Thu Jun 13 21:25:19 2019
//Host        : DESKTOP-40DR8BJ running 64-bit major release  (build 9200)
//Command     : generate_target arty_mb_wrapper.bd
//Design      : arty_mb_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module arty_mb_wrapper
   (IIC_scl_io,
    IIC_sda_io,
    led_4bits,
    push_buttons_4bits,
    reset,
    sig_out,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  inout IIC_scl_io;
  inout IIC_sda_io;
  output [3:0]led_4bits;
  input [3:0]push_buttons_4bits;
  input reset;
  output [3:0]sig_out;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire IIC_scl_i;
  wire IIC_scl_io;
  wire IIC_scl_o;
  wire IIC_scl_t;
  wire IIC_sda_i;
  wire IIC_sda_io;
  wire IIC_sda_o;
  wire IIC_sda_t;
  wire [3:0]led_4bits;
  wire [3:0]push_buttons_4bits;
  wire reset;
  wire [3:0]sig_out;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  IOBUF IIC_scl_iobuf
       (.I(IIC_scl_o),
        .IO(IIC_scl_io),
        .O(IIC_scl_i),
        .T(IIC_scl_t));
  IOBUF IIC_sda_iobuf
       (.I(IIC_sda_o),
        .IO(IIC_sda_io),
        .O(IIC_sda_i),
        .T(IIC_sda_t));
  arty_mb arty_mb_i
       (.IIC_scl_i(IIC_scl_i),
        .IIC_scl_o(IIC_scl_o),
        .IIC_scl_t(IIC_scl_t),
        .IIC_sda_i(IIC_sda_i),
        .IIC_sda_o(IIC_sda_o),
        .IIC_sda_t(IIC_sda_t),
        .led_4bits(led_4bits),
        .push_buttons_4bits(push_buttons_4bits),
        .reset(reset),
        .sig_out(sig_out),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
