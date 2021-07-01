abstract class AppLanguage{
   // labels
   String lableChitName;
   String labelChitValue;
   String labelInstallmentNo;
   String labelMembers;
   String labelPayableAmount;
   String labelChitDate;

   // appbar headings
   String appBarChitTemplate;

   // headings
   String headingOngoingChits;

   // input place holder
   String hintDashboardSearchMember;
}

class English implements AppLanguage{

   // labels
   String lableChitName = 'Name';
   String labelChitValue = 'Chit Value';
   String labelInstallmentNo = 'Installment No.';
   String labelMembers = 'Members';
   String labelPayableAmount = 'Payable Amount';
   String labelChitDate = 'Chit Date';

   // appbar headings
   String appBarChitTemplate = 'Chit Template';

   // headings   
   String headingOngoingChits = 'Ongoing Chits';

   // input place holder
   String hintDashboardSearchMember = 'Search member';
}

class Tamil implements AppLanguage{
   // labels
   String lableChitName = 'சீட்டு பெயர்';
   String labelChitValue = 'சீட்டு மதிப்பு';
   String labelInstallmentNo = 'தவணை எண்';
   String labelMembers = 'உறுப்பினர்கள்';
   String labelPayableAmount = 'செலுத்த வே. தொகை';
   String labelChitDate = 'சீட்டு தேதி';

   // appbar headings
   String appBarChitTemplate = 'சீட்டு கட்டமைப்பு';

   // headings
   String headingOngoingChits = 'தற்போதைய சீட்டு';

   // input place holder
   String hintDashboardSearchMember = 'உறுப்பினர் தேடல்';
}