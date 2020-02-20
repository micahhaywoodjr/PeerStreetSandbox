/* Copyright 2011 Shimon Rothschild
This software may be used and modified without restriction with the stipulation that if significant portions
remain unmodified then this copyright notice shall be retained.
*/
trigger Lead_afterUpdate on Lead (after update) {
	if (Trigger.isUpdate) {
		blogic_ZillowService.HomeValue(trigger.old, trigger.new);
	}
}