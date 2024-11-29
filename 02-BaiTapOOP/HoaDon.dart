import 'DienThoai.dart';

class HoaDon {
  // Thuoc tinh
  String _maHD;
  DateTime _ngayBan;
  DienThoai _dienThoai;
  int _soLuongMua;
  double _giaBanThucTe;
  String _tenKhachHang;
  String _soDienThoaiKhach;

  // Constructor
  HoaDon(this._maHD, this._ngayBan, this._dienThoai, this._soLuongMua,
      this._giaBanThucTe, this._tenKhachHang, this._soDienThoaiKhach) {
    if (!_maHD.startsWith("HD-")) {
      throw ArgumentError("Mã hóa đơn phải có định dạng 'HD-XXX'.");
    }
    if (_ngayBan.isAfter(DateTime.now())) {
      throw ArgumentError("Ngày bán không thể sau ngày hiện tại.");
    }
    if (_soLuongMua <= 0 || _soLuongMua > _dienThoai.soLuongTonKho) {
      throw ArgumentError("Số lượng mua phải lớn hơn 0 và không vượt quá tồn kho.");
    }
    if (_giaBanThucTe <= 0) {
      throw ArgumentError("Giá bán thực tế phải lớn hơn 0.");
    }
    if (_tenKhachHang.isEmpty || _soDienThoaiKhach.isEmpty) {
      throw ArgumentError("Tên khách hàng và số điện thoại không được rỗng.");
    }
    if (!_soDienThoaiKhach.startsWith("0") || _soDienThoaiKhach.length != 10) {
      throw ArgumentError("Số điện thoại không hợp lệ.");
    }
  }

  // Getter
  String get maHD => _maHD;
  DateTime get ngayBan => _ngayBan;
  DienThoai get dienThoai => _dienThoai;
  int get soLuongMua => _soLuongMua;
  double get giaBanThucTe => _giaBanThucTe;
  String get tenKhachHang => _tenKhachHang;
  String get soDienThoaiKhach => _soDienThoaiKhach;

  // Setter
  set soLuongMua(int soLuongMua) {
    if (soLuongMua > 0 && soLuongMua <= _dienThoai.soLuongTonKho) {
      _soLuongMua = soLuongMua;
    } else {
      throw ArgumentError("Số lượng mua phải hợp lệ.");
    }
  }

  set giaBanThucTe(double giaBanThucTe) {
    if (giaBanThucTe > 0) {
      _giaBanThucTe = giaBanThucTe;
    } else {
      throw ArgumentError("Giá bán thực tế phải lớn hơn 0.");
    }
  }

  set tenKhachHang(String tenKhachHang) {
    if (tenKhachHang.isNotEmpty) {
      _tenKhachHang = tenKhachHang;
    } else {
      throw ArgumentError("Tên khách hàng không được rỗng.");
    }
  }

  set soDienThoaiKhach(String soDienThoaiKhach) {
    if (soDienThoaiKhach.startsWith("0") && soDienThoaiKhach.length == 10) {
      _soDienThoaiKhach = soDienThoaiKhach;
    } else {
      throw ArgumentError("Số điện thoại không hợp lệ.");
    }
  }

  // Tinh tong tien
  double tinhTongTien() {
    return _soLuongMua * _giaBanThucTe;
  }

  // Tinh Loi nhuan thuc te
  double tinhLoiNhuanThucTe() {
    return (_giaBanThucTe - _dienThoai.giaNhap) * _soLuongMua;
  }

  // Hien thi hoa don
  void hienThiThongTinHoaDon() {
    print("Mã hóa đơn: $_maHD");
    print("Ngày bán: $_ngayBan");
    print("Tên khách hàng: $_tenKhachHang");
    print("Số điện thoại khách: $_soDienThoaiKhach");
    print("Tên điện thoại: ${_dienThoai.tenDT}");
    print("Số lượng mua: $_soLuongMua");
    print("Giá bán thực tế: $_giaBanThucTe");
    print("Tổng tiền: ${tinhTongTien()}");
    print("Lợi nhuận thực tế: ${tinhLoiNhuanThucTe()}");
  }
}
