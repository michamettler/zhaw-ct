/* ------------------------------------------------------------------
 * --  _____       ______  _____                                    -
 * -- |_   _|     |  ____|/ ____|                                   -
 * --   | |  _ __ | |__  | (___    Institute of Embedded Systems    -
 * --   | | | '_ \|  __|  \___ \   Zurich University of             -
 * --  _| |_| | | | |____ ____) |  Applied Sciences                 -
 * -- |_____|_| |_|______|_____/   8401 Winterthur, Switzerland     -
 * ------------------------------------------------------------------
 * --
 * -- Description:  Implementation of module statistics
 * --               Collect and provide statistical data on throws
 * --               of the dice
 * --
 * -- $Id: statistics.c 2977 2016-02-15 16:05:50Z ruan $
 * ------------------------------------------------------------------
 */

/* user includes */
#include "statistics.h"

/* variables visible within the whole module*/

// index 0:         total number of throws
// index 1 to 6:    number of throws for each digit
static uint8_t nr_of_throws[NR_OF_DICE_VALUES + 1];

/* function definitions */

/// STUDENTS: To be programmed

void stat_add_throw(uint8_t throw_value) {
  if (throw_value < 1 || throw_value > NR_OF_DICE_VALUES)
    return; // throw_value has to be in the range of 1 up to NR_OF_DICE_VALUES

  nr_of_throws[0]++; // Increments the total number of throws
  nr_of_throws[throw_value]++; // as well as the number for the throws
}

uint8_t stat_read(uint8_t dice_number) {
  if (dice_number > NR_OF_DICE_VALUES)
    return ERROR_VALUE;

  return nr_of_throws[dice_number]; // For 'dice_number' equal zero the total number of throws will be returned.
}

/// END: To be programmed
