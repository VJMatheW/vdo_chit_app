import 'data_models.dart';

class Installment{
   int _id;
   int _installmentNo;
   int _finalBidderId;
   int _finalBidAmount;
   int _payableAmount;
   Bidder _bidder;

   Installment({ int id, int installmentNo, int finalBidderId, int finalBidAmount, int payableAmount, Bidder bidder }){
      _id = id;
      _installmentNo = installmentNo;
      _finalBidderId = finalBidderId;
      _finalBidAmount = finalBidAmount;
      _payableAmount = payableAmount;
      _bidder = bidder;
   }

   factory Installment.fromJson(Map<String, dynamic> jsonObject, Bidder bidder){
      return Installment(
         id: jsonObject["id"],
         installmentNo: jsonObject["installment_no"],
         finalBidderId: jsonObject["final_bidder_id"],
         finalBidAmount: jsonObject["final_bid_amount"],
         payableAmount: jsonObject["payable_amount"],
         bidder: bidder
      );
   }

   int get id => _id;
   int get installmentNo => _installmentNo;
   int get finalBidderId => _finalBidderId;
   int get finalBidAmount => _finalBidAmount;
   int get payableAmount => _payableAmount;
   Bidder get bidder => _bidder;
}