/// status : "ok"
/// ch : "market.btcusdt.kline.1mon"
/// ts : 1580885101624
/// data : [{"amount":123527.105944981171846470,"open":9337.100000000000000000,"close":9280.470000000000000000,"high":9600.000000000000000000,"id":1580486400,"count":1095638,"low":9100.000000000000000000,"vol":1151593772.529603656613804285450000000000000000},{"amount":1202012.456391286064699800,"open":7194.700000000000000000,"close":9337.100000000000000000,"high":9576.220000000000000000,"id":1577808000,"count":9864195,"low":6871.000000000000000000,"vol":10038645567.217605490281740305930000000000000000}]

class Kmon {
  String status;
  String ch;
  int ts;
  List<DataBean> data;



  static Kmon fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Kmon kmonBean = Kmon();
    kmonBean.status = map['status'];
    kmonBean.ch = map['ch'];
    kmonBean.ts = map['ts'];
    kmonBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => DataBean.fromMap(o))
    );
    return kmonBean;
  }

  Map toJson() => {
    "status": status,
    "ch": ch,
    "ts": ts,
    "data": data,
  };
}

/// amount : 123527.105944981171846470
/// open : 9337.100000000000000000
/// close : 9280.470000000000000000
/// high : 9600.000000000000000000
/// id : 1580486400
/// count : 1095638
/// low : 9100.000000000000000000
/// vol : 1151593772.529603656613804285450000000000000000

class DataBean {
  double amount;
  double open;
  double close;
  double high;
  int id;
  int count;
  double low;
  double vol;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.amount = map['amount'];
    dataBean.open = map['open'];
    dataBean.close = map['close'];
    dataBean.high = map['high'];
    dataBean.id = map['id'];
    dataBean.count = map['count'];
    dataBean.low = map['low'];
    dataBean.vol = map['vol'];
    return dataBean;
  }



  Map toJson() => {
    "amount": amount,
    "open": open,
    "close": close,
    "high": high,
    "id": id,
    "count": count,
    "low": low,
    "vol": vol,
  };
}