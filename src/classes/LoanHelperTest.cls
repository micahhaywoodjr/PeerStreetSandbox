@isTest
private class LoanHelperTest
{
    @isTest static void testEnglish_number()
    {
  string str;
  str=LoanHelper.english_number(99);
        System.assertEquals(str, 'Ninety Nine');
      
  str=LoanHelper.english_number(101);
        System.assertEquals(str, 'One Hundred One');
        
    str=LoanHelper.english_number(1001);
        System.assertEquals(str, 'One Thousand One');
    }
}