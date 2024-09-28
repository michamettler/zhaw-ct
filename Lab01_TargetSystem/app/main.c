#include "utils_ctboard.h"
#define ADDRESS_SRC 0x60000200
#define ADDRESS_DEST 0x60000100

#define ADDRESS_SRC_ROT 0x60000211
#define ADDRESS_DST_DIS 0x60000110

#define ADDRESS_DST_DBG_ROT 0x60000100
#define ADDRESS_DST_DBG_DIS 0x60000101

int main() {

	while(1) {
		// 4.2
		// int data = read_word(ADDRESS_SRC);
		// write_word(ADDRESS_DEST, data);
		
		// 5.2
		int data_rot = read_byte(ADDRESS_SRC_ROT);
		write_byte(ADDRESS_DST_DBG_ROT, data_rot); //debug rotating
		
		int switch_value = data_rot & 0x0F;
		const uint8_t array[] = 
		{
				0xC0,  // 0
        0xF9,  // 1
        0xA4,  // 2
        0xB0,  // 3
        0x99,  // 4
        0x92,  // 5
        0x82,  // 6
        0xF8,  // 7
        0x80,  // 8
        0x90,  // 9
        0x88,  // A
        0x83,  // b (lowercase to distinguish from 8)
        0xC6,  // C
        0xA1,  // d (lowercase to distinguish from 0)
        0x86,  // E
        0x8E   // F
		};
		write_byte(ADDRESS_DST_DIS, array[switch_value]);
		write_byte(ADDRESS_DST_DBG_DIS, array[switch_value]); //debug display
	}
}