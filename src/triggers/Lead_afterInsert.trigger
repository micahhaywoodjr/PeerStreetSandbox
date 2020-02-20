/* Copyright 2011 Shimon Rothschild
This software may be used and modified without restriction with the stipulation that if significant portions
remain unmodified then this copyright notice shall be retained.
*/
trigger Lead_afterInsert on Lead (after insert) {
	if (Trigger.isInsert) {
		blogic_ZillowService.HomeValue(null, trigger.new);
	}
}