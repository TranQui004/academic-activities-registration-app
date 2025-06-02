class Event {
  final String id;
  final String? DDToChuc;
  final String? DoiTuong;
  final String? DonViToChuc;
  final String? HDChinh;
  final String? LoaiHD;
  final String? MoTa;
  final int SLDangKy;
  final int SLToiDa;
  final DateTime TGKetThuc;
  final DateTime TGToChuc;
  final String? TenSuKien;
  final String? ThongTinThem;
  final String? UrlAnh;

  Event({
    required this.id,
    required this.DDToChuc,
    required this.DoiTuong,
    required this.DonViToChuc,
    required this.HDChinh,
    required this.LoaiHD,
    required this.MoTa,
    required this.SLDangKy,
    required this.SLToiDa,
    required this.TGKetThuc,
    required this.TGToChuc,
    required this.TenSuKien,
    required this.ThongTinThem,
    required this.UrlAnh
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      DDToChuc: map['DDToChuc'],
      DoiTuong: map['DoiTuong'],
      DonViToChuc: map['DonViToChuc'],
      HDChinh: map['HDChinh'],
      LoaiHD: map['LoaiHD'],
      MoTa: map['MoTa'],
      SLDangKy: map['SLDangKy'],
      SLToiDa: map['SLToiDa'],
      TGKetThuc: map['TGKetThuc'].toDate(),
      TGToChuc: map['TGToChuc'].toDate(),
      TenSuKien: map['TenSuKien'],
      ThongTinThem: map['ThongTinThem'],
      UrlAnh: map['UrlAnh']
    );
  }
}