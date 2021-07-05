abstract class AppLanguage{
   // labels
   String lableChitName;
   String labelChitValue;
   String labelInstallmentNo;
   String labelMembers;
   String labelPayableAmount;
   String labelChitDate;
   String labelChitPercentage;
   String labelChitMembersCount;
   String labelChitAmount;
   String labelChitTemplateMembersCount;

   // appbar headings
   String appBarChitTemplate;
   String appBarChit;
   String appBarMember;

   // headings
   String headingOngoingChits;

   // modal popup headings
   String modalHeadingAddChitTemplate;

   // input place holder
   String hintDashboardSearchMember;
   String hintChitAmount;
   String hintChitPercentage;
   String hintChitMembersCount;

   // button text
   String buttonCreate;
   String buttonCancel;
}

class English implements AppLanguage{

   // labels
   String lableChitName = 'Name';
   String labelChitValue = 'Chit Value';
   String labelInstallmentNo = 'Installment No.';
   String labelMembers = 'Members';
   String labelPayableAmount = 'Payable Amount';
   String labelChitDate = 'Chit Date';
   String labelChitPercentage = 'Percentage';
   String labelChitMembersCount = 'Members count';
   String labelChitAmount = 'Amount';
   String labelChitTemplateMembersCount = 'Members';

   // appbar headings
   String appBarChitTemplate = 'Chit Template';
   String appBarChit = 'Chit';
   String appBarMember = 'Member';

   // headings   
   String headingOngoingChits = 'Ongoing Chits';

   // modal popup headings
   String modalHeadingAddChitTemplate = 'New Chit Template';

   // input place holder
   String hintDashboardSearchMember = 'Search member';
   String hintChitAmount = 'Amount';
   String hintChitPercentage = 'Percentage';
   String hintChitMembersCount = 'Members count';

   // button text
   String buttonCreate = 'Create';
   String buttonCancel = 'Cancel';
}

class Tamil implements AppLanguage{
   // labels
   String lableChitName = 'சீட்டு பெயர்';
   String labelChitValue = 'சீட்டு மதிப்பு';
   String labelInstallmentNo = 'தவணை எண்';
   String labelMembers = 'உறுப்பினர்கள்';
   String labelPayableAmount = 'செலுத்த வே. தொகை';
   String labelChitDate = 'சீட்டு தேதி';
   String labelChitPercentage = 'பீட் சதவிதம்';
   String labelChitMembersCount = 'உறுப்பினர்கள் எண்ணிக்கை';
   String labelChitAmount = 'மதிப்பு';
   String labelChitTemplateMembersCount = 'உறுப்பினர்கள்';

   // appbar headings
   String appBarChitTemplate = 'சீட்டு கட்டமைப்பு';
   String appBarChit = 'சீட்டு';
   String appBarMember = 'உறுப்பினர்கள்';

   // headings
   String headingOngoingChits = 'தற்போதைய சீட்டு';


   // modal popup headings
   String modalHeadingAddChitTemplate = 'புதிய சீட்டு கட்டமைப்பு';

   // input place holder
   String hintDashboardSearchMember = 'உறுப்பினர் தேடல்';
   String hintChitAmount = 'மதிப்பு';
   String hintChitPercentage = 'சதவிதம்';
   String hintChitMembersCount = 'எண்ணிக்கை';

   // button text
   String buttonCreate = 'உருவாக்கு';
   String buttonCancel = 'ரத்துசெய்';
}