class Sql {
  /// DDL
  static const CHIT_CONFIG =
      "CREATE TABLE CHIT_CONFIG(id INTEGER PRIMARY KEY AUTOINCREMENT, amt INTEGER, percentage INTEGER, members_count INTEGER)";
  static const MEMBER_CONFIG =
      "CREATE TABLE MEMBER_CONFIG(id INTEGER PRIMARY KEY AUTOINCREMENT, phone VARCHAR(12), name VARCHAR(50))";
  static const CHIT =
      "CREATE TABLE CHIT(id INTEGER PRIMARY KEY AUTOINCREMENT,chit_config_id INTEGER, name VARCHAR, start_date TEXT, chit_date TEXT, created_at TEXT DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(chit_config_id) REFERENCES chit_config(id))";
  static const CHIT_MEMBER =
      "CREATE TABLE CHIT_MEMBER(id INTEGER PRIMARY KEY AUTOINCREMENT, chit_id INTEGER, member_config_id INTEGER, credit_amt INTERGER DEFAULT 0, pending_amt DEFAULT 0, created_at TEXT DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY(chit_id) REFERENCES CHIT(id), FOREIGN KEY(member_config_id) REFERENCES MEMBER_CONFIG(id))";
  static const CHIT_MONTH =
      "CREATE TABLE CHIT_MONTH(id INTEGER PRIMARY KEY AUTOINCREMENT, chit_id INTEGER, final_bid_amt INTEGER, final_bidder_id INTEGER, payable_amt INTEGER, created_at TEXT DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY(chit_id) REFERENCES CHIT(id), FOREIGN KEY(final_bidder_id) REFERENCES CHIT_MEMBER(id))";
  static const CHIT_MONTHLY_MEMBER_TR =
      "CREATE TABLE CHIT_MONTHLY_MEMBER_TR(id INTEGER PRIMARY KEY AUTOINCREMENT, chit_member_id INTEGER, chit_month_id INTEGER, paid_status INTEGER NOT NULL DEFAULT 0 CHECK(paid_status IN (0,1)), created_at TEXT DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY(chit_member_id) REFERENCES CHIT_MEMBER(id), FOREIGN KEY(chit_month_id) REFERENCES CHIT_MONTH(id))";
  static const PAYMENT_MODE =
      "CREATE TABLE PAYMENT_MODE(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR)";
  static const TRANSACTIONS =
      "CREATE TABLE TRANSACTIONS(id INTEGER PRIMARY KEY AUTOINCREMENT, chit_member_id INTEGER, chit_monthly_member_tr_id INTEGER, paid_amount INTEGER, pay_mode INTEGER, created_at TEXT DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY(chit_member_id) REFERENCES chit_member(id), FOREIGN KEY(chit_monthly_member_tr_id) REFERENCES CHIT_MONTHLY_MEMBER_TR(id), FOREIGN KEY(pay_mode) REFERENCES PAYMENT_MODE(id))";

  /// DML - Insert
  static const I_CHIT_CONFIG =
      "INSERT INTO CHIT_CONFIG(amt, percentage, members_count) values(?, ?, ?)";
  static const I_MEMBER_CONFIG =
      "INSERT INTO MEMBER_CONFIG(name, phone) values(?, ?)";
  static const I_CHIT =
      "INSERT INTO CHIT(chit_config_id, name, start_date, chit_date) VALUES(?, ?, ?, ?)";

  ///DML - select
}
