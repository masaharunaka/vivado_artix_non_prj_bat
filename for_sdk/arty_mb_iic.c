/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 *
 *
 * This file is a generated sample test application.
 *
 * This application is intended to test and/or illustrate some
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * SDK application project when you run the "Generate Libraries" menu item.
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include "xil_printf.h"
#include "xparameters.h"
#include "xil_cache.h"
#include "xintc.h"
#include "xgpio.h"
#include "xiic.h"

//#define DEBUG

XIic xiic; /* The driver instance for IIC Device */

int WriteData(u16 ByteCount, u8 *WriteBuffer);
int ReadData(u16 ByteCount, u8 *ReadBuffer , u8 *command);

int device_address;

int main ()
{

    setvbuf(stdin, NULL, _IONBF, 0);
    unsigned char comm_buf[32];
    unsigned char *ptr;
    unsigned char Input;
    int input_size;

    int *pi;
	int hex_buf[32];
	
	// Messeage
	xil_printf("========== Input format ==========\n\r");
    xil_printf("Device address 0x[0][1] : 7bits address\n\r");
    xil_printf("Read or Write  0x[2][3] : Write is 0x00 Read is 0x01 \n\r");
    xil_printf("Read or Write  0x[4][5] : size of command + Read or write bytes \n\r");
    xil_printf("Read or Write  0x[6][7] : command for IIC transaction \n\r");
    xil_printf("Read or Write  0x[7][8]~ : write data max 8bytes \n\r");
    xil_printf("Press Q is Quit input command\n\r");
    xil_printf("==================================\n\r"); 

    //Main Loop
    while(1){
        
    	//Get command
        input_size=0;
        ptr = comm_buf;
    

        xil_printf("Input[HEX]=>"); 
 
        while(1)
        {
          Input = getchar();
          if (Input == 0x71 || input_size >= 32 ){   // quit get char when Q
            xil_printf("\n\r", Input);
        	break;
          }
          if ((Input >= 0x30 && Input <= 0x3F) || (Input >= 0x41 && Input <= 0x46  )){
            xil_printf("%c", Input);
            *ptr = Input;
            ptr++;
            input_size++;
          }
        }
    
        ///////////////////
        // Display input //
        ///////////////////
    
        ptr = comm_buf; // set pointer to start address of comm_buf

        // display
        #ifdef DEBUG
          xil_printf("Input(ascii) is ");
          for(int i = 0; i < input_size; i++) {
            xil_printf("%c", *(ptr+i));
          }
          xil_printf("\n\r");
        #endif
    
        //////////////////
        // ascii to hex //
        //////////////////
    
        pi = hex_buf; // set pointer to start address of hex_buf
    
        for(int i = 0; i < 32; i++) {
        	if (*(ptr+i) >= 0x30 && *(ptr+i) <= 0x3F  ){
        		*(pi+i) = *(ptr+i) - 0x30;
            }
        	else if (*(ptr+i) >= 0x41 && *(ptr+i) <= 0x46  ){
        		*(pi+i) = *(ptr+i) - 0x41 + 10 ;
            }
        	else{
        		//ERROR flag = 1 and goto error
        	}
        }

        // display   
        #ifdef DEBUG
          xil_printf("Input(hex) is ");
          for(int i = 0; i < input_size; i++) {
            xil_printf("%x", hex_buf[i]);
          }
          xil_printf("\n\r");
        #endif
    
        // set command
        int rd_flag;
        int size;
        u8 SendBuffer[8];
    	u8 ReadBuffer[8];
    
        device_address = *(pi+0)*0x10 + *(pi+1); // set pointer to start address of hex_buf
        rd_flag        = *(pi+2)*0x10 + *(pi+3); // set pointer to start address of hex_buf
        size           = *(pi+4)*0x10 + *(pi+5); // size
    
        for(int i = 0; i < 8; i++) {
        	SendBuffer[i] = *(pi+6+2*i)*0x10 + *(pi+7+2*i);
        }
    
        #ifdef DEBUG
          xil_printf("device_address is 0x%x\n\r", device_address);
          xil_printf("rd_flag is 0x%x\n\r", rd_flag);
          xil_printf("size is 0x%x\n\r", size);
          for(int i = 0; i < 8; i++) {
            xil_printf("SendBufferf[%d] is %x\n\r", i ,SendBuffer[i]);
          }
        #endif
    
    	int Status;
    	XIic_Config *ConfigPtr;	/* Pointer to configuration data */
    
    	/*
    	 * Initialize the IIC driver so that it is ready to use.
    	 */
    	ConfigPtr = XIic_LookupConfig(XPAR_IIC_0_DEVICE_ID);
    	if (ConfigPtr == NULL) {
    		return XST_FAILURE;
    	}
    
    	Status = XIic_CfgInitialize(&xiic, ConfigPtr, ConfigPtr->BaseAddress);
    
        #ifdef DEBUG
    	  xil_printf("Initialize Status is %d \n\r",Status);
        #endif
    
    
        // Write transaction
    	if(rd_flag == 0){
    	  Status = WriteData(size, SendBuffer);
          #ifdef DEBUG
            xil_printf("Write Status is %d \n\r",Status);
          #endif
		  xil_printf("Command is %02x ", SendBuffer[0]);		  
		  xil_printf("Write Data is 0x");
		  for(int i = 1; i < size; i++) {
              xil_printf("%02x", SendBuffer[i]);	  
		  }
    	  xil_printf("\n\r");
        }
        // Read transaction
    	else if(rd_flag == 1){
    	  Status = ReadData(size, ReadBuffer, SendBuffer);
		    xil_printf("Command is %02x ", SendBuffer[0]);
    	    xil_printf("Read Data is 0x");
    	    for(int i = 0; i < size - 1; i++) {
              xil_printf("%02x", ReadBuffer[i]);
    	    }
    	    xil_printf("\n\r");
        }
    }
        return 0;
}


int WriteData(u16 ByteCount, u8 *WriteBuffer)
{
	int Status;

	// Start the IIC device and driver
	Status = XIic_Start(&xiic);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	// XIic_DynSend using STOP condition
	Status = XIic_DynSend(xiic.BaseAddress, device_address, WriteBuffer, ByteCount, XIIC_STOP);
	//Status = XIic_Send(xiic.BaseAddress, LCD_DEVICE_ADDRESS, WriteBuffer, ByteCount, XIIC_REPEATED_START);
	if (Status != XST_SUCCESS) {
        #ifdef DEBUG
		  xil_printf("Write Send cnt=%d\n\r",Status);
		  //return XST_FAILURE;
        #endif
	}

	// Stop the IIC device and driver
	Status = XIic_Stop(&xiic);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;

}

int ReadData(u16 ByteCount, u8 *ReadBuffer , u8 *WriteBuffer)
{
	int Status;

	// Start the IIC device and driver
	Status = XIic_Start(&xiic);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	// XIic_DynSend using STOP condition
	Status = XIic_Send(xiic.BaseAddress, device_address, WriteBuffer , 1 , XIIC_STOP); // or XIIC_REPEATED_START

	// XIic_DynRecv using STOP condition
	Status = XIic_Recv(xiic.BaseAddress, device_address, ReadBuffer, ByteCount, XIIC_STOP);
    #ifdef DEBUG
	  xil_printf("Receive cnt =%d\n\r",Status);
    #endif

	// Stop the IIC device and driver
	Status = XIic_Stop(&xiic);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}
