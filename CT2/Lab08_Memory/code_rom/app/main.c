/* ------------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zurich University of             -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                 -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- Application for testing external memory
 * --
 * -- $Id: main.c 5605 2023-01-05 15:52:42Z frtt $
 * ------------------------------------------------------------------
 */

/* standard includes */
#include <stdint.h>


/// STUDENTS: To be programmed
#include <reg_ctboard.h>
#include <reg_stm32f4xx.h>
#include "hal_ct_buttons.h"

#define START_MEMORY 0x64000400
#define START_ERROR_MAP 0x64000200
/// END: To be programmed

int main(void)
{
    /// STUDENTS: To be programmed
		uint8_t *mem_ptr = (uint8_t *) START_MEMORY;
		uint16_t *error_map_ptr = (uint16_t *) START_ERROR_MAP;
	
		uint8_t error_count = 0;
		
		for(int i = 0;i<=0xFF;i++){
			uint8_t read_value = *(mem_ptr + i); // read data from base-address + offset
			if(i==read_value)continue; // guard
			
			CT_LED->BYTE.LED23_16 = i; // expected value
			CT_LED->BYTE.LED7_0 = read_value; // actual value
			
      error_count++;
      
			//CT_SEG7->BIN.HWORD = *(error_map_ptr + i);
      while (!hal_ct_button_is_pressed(HAL_CT_BUTTON_T0));

		}
		
    /// END: To be programmed
}