/*
 * test application
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdlib.h>
#include <stdio.h>
#include "xil_printf.h"
#include "xparameters.h"
#include "xil_cache.h"
#include "xintc.h"
#include "xgpio.h"
#include "xiic.h"
XGpio Gpio; /* The Instance of the GPIO Driver */

// include lib src
#include "sleep.h"
#include "platform.h"

#define GPIOPS_BASE   (0x40000000)
#define LED_ADDR      (0x40010000)
#define IO_DELAY_01   (0x40020000)

int main()
{
  // variable
  u32 reg_u32_buf;

  // main process
  init_platform();

  print("IO Delay Test Start\n\r");

  while (1) {

    // init delay value
    XGpio_WriteReg(0x40020000, 0x00, 0x00000000);// initialize delay count
    XGpio_WriteReg(0x40020000, 0x00, 0x20202020);// load enable
    XGpio_WriteReg(0x40020000, 0x00, 0xDFDFDFDF);// load disable

    // loop delay 1
    for (u8 i = 0; i <= 31; i++){
        reg_u32_buf = 0x000000FF & i ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);
        // Set 1b at bit5
        reg_u32_buf |= 0x00000020 ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);
        // Set 0b at bit5
        reg_u32_buf &= 0xFFFFFFDF ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);

        usleep_MB(100000);//100ms
    };

    // loop delay 2
    for (u8 i = 0; i <= 31; i++){
        reg_u32_buf = 0x0000FF00 & (i << 8) ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);
        // Set 1b at bit13
        reg_u32_buf |= 0x00002000 ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);
        // Set 0b at bit13
        reg_u32_buf &= 0xFFFFDFFF ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);

        usleep_MB(100000);//100ms
    };

    // loop delay 3
    for (u8 i = 0; i <= 31; i++){
        reg_u32_buf = 0x00FF0000 & (i << 16) ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);
        // Set 1b at bit21
        reg_u32_buf |= 0x00200000 ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);
        // Set 0b at bit21
        reg_u32_buf &= 0xFFDFFFFF ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);

        usleep_MB(100000);//100ms
    };

    // loop delay 4
    for (u8 i = 0; i <= 31; i++){
        reg_u32_buf = 0xFF000000 & (i << 24) ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);
        // Set 1b at bit29
        reg_u32_buf |= 0x20000000 ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);
        // Set 0b at bit29
        reg_u32_buf &= 0xDFFFFFFF ;
        XGpio_WriteReg(0x40020000, 0x00, reg_u32_buf);

        usleep_MB(100000);//100ms
    };
  }
}
