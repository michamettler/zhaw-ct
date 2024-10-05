/* -----------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zurich University of             -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                 -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- main.c
 * --
 * -- main for Computer Engineering "Bit Manipulations"
 * --
 * -- $Id: main.c 744 2014-09-24 07:48:46Z ruan $
 * ------------------------------------------------------------------
 */
//#include <reg_ctboard.h>
#include "utils_ctboard.h"

#define ADDR_DIP_SWITCH_31_0 0x60000200
#define ADDR_DIP_SWITCH_7_0  0x60000200
#define ADDR_LED_31_24       0x60000103
#define ADDR_LED_23_16       0x60000102
#define ADDR_LED_15_8        0x60000101
#define ADDR_LED_7_0         0x60000100
#define ADDR_BUTTONS         0x60000210

// define your own macros for bitmasks below (#define)
/// STUDENTS: To be programmed

#define MASK_BRIGHT	0b11000000
#define MASK_DARK		0b11001111



/// END: To be programmed

int main(void)
{

    // add variables below
    /// STUDENTS: To be programmed

		uint8_t led_value = 0, led_value_original = 0, cntr_T0 = 0, last_buttons = 0, push_events = 0, value_buttons = 0;

    /// END: To be programmed

    while (1) {
        // ---------- Task 3.1 ----------
        led_value_original = read_byte(ADDR_DIP_SWITCH_7_0);
				led_value = led_value_original;

        /// STUDENTS: To be programmed

				
				led_value |= MASK_BRIGHT;
				led_value &= MASK_DARK;


        /// END: To be programmed

        write_byte(ADDR_LED_7_0, led_value);

        // ---------- Task 3.2 and 3.3 ----------
        /// STUDENTS: To be programmed

				// read & mask
				uint8_t buttons = read_byte(ADDR_BUTTONS);
				buttons &= 0b00001111;
			
				// detect edges
				uint8_t edges = ~last_buttons & buttons;
				if ((edges & 0b00000001) == 1) {
					push_events++;
				}
				
				// detect if action is already executed
				int executed = 0;
			
				// detect how long t0 is pressed
				uint8_t lastBit = buttons & 0b00000001;
				if (lastBit == 0b00000001) {
					cntr_T0++;
				}
				
				// T0
				uint8_t value_T0 = edges & 0b00000001;
				if (value_T0 == 0b00000001) {
					cntr_T0++;
					value_buttons = value_buttons >> 1;
					executed = 1;
				}
				
				// T1
				uint8_t value_T1 = edges & 0b00000010;
				if (executed != 1 && value_T1 == 0b00000010) {
					value_buttons = value_buttons << 1;
					executed = 1;
				}
				
				// T2
				uint8_t value_T2 = edges & 0b00000100;
				if (executed != 1 && value_T2 == 0b00000100) {
					value_buttons = ~value_buttons;
					executed = 1;
				}
				
				// T3
				uint8_t value_T3 = edges & 0b00001000;
				if (executed != 1 && value_T3 == 0b00001000) {
					value_buttons = led_value_original;
				}
			
				// write values
				write_byte(ADDR_LED_15_8, cntr_T0);
				write_byte(ADDR_LED_31_24, push_events);
				write_byte(ADDR_LED_23_16, value_buttons);
				
				// set last buttons
				last_buttons = buttons;
        /// END: To be programmed
    }
}
