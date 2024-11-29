import 'DienThoai.dart';
import 'HoaDon.dart';

class CuaHang {
  // Thuoc tinh
  String _tenCuaHang;
  String _diaChi;
  List<DienThoai> _danhSachDienThoai = [];
  List<HoaDon> _danhSachHoaDon = [];

  // Constructor
  CuaHang(this._tenCuaHang, this._diaChi);

  // Getter
  String get tenCuaHang => _tenCuaHang;
  String get diaChi => _diaChi;
  List<DienThoai> get danhSachDienThoai => _danhSachDienThoai;
  List<HoaDon> get danhSachHoaDon => _danhSachHoaDon;

  // Setter
  set tenCuaHang(String tenCuaHang) {
    if (tenCuaHang.isNotEmpty) {
      _tenCuaHang = tenCuaHang;
    }
  }

  set diaChi(String diaChi) {
    if (diaChi.isNotEmpty) {
      _diaChi = diaChi;
    }
  }

  // Them dien thoai
  void themDienThoai(DienThoai dienThoai) {
    _danhSachDienThoai.add(dienThoai);
  }

  // Cap nhat dien thoai
  void capNhatDienThoai(String maDT, String tenMoi, double giaBanMoi) {
    for (var dt in _danhSachDienThoai) {
      if (dt.maDT == maDT) {
        dt.tenDT = tenMoi;
        dt.giaBan = giaBanMoi;
        return;
      }
    }
    throw ArgumentError("Không tìm thấy điện thoại với mã: $maDT");
  }

  // Ngung kinh doanh dien thoai
  void ngungKinhDoanh(String maDT) {
    for (var dt in _danhSachDienThoai) {
      if (dt.maDT == maDT) {
        dt.trangThai = false;
        return;
      }
    }
    throw ArgumentError("Không tìm thấy điện thoại với mã: $maDT");
  }

  // Tim kiem dien thoai theo ma, ten, hang
  List<DienThoai> timKiemDienThoai({String? maDT, String? tenDT, String? hangSanXuat}) {
    return _danhSachDienThoai.where((dienThoai) {
      return (maDT == null || dienThoai.maDT.contains(maDT)) &&
             (tenDT == null || dienThoai.tenDT.contains(tenDT)) &&
             (hangSanXuat == null || dienThoai.hangSanXuat.contains(hangSanXuat));
    }).toList();
  }

  // Hien thi danh sach dien thoai
  void hienThiDanhSachDienThoai() {
    print("Danh sách điện thoại trong $_tenCuaHang tai $_diaChi:");
    for (var dt in _danhSachDienThoai) {
      dt.HienThiThongTinDT();
      print("--------\n");
    }
  }

  // Tạo hóa đơn mới và tự động cập nhật tồn kho
  void taoHoaDon(HoaDon hoaDon) {
    if (hoaDon.soLuongMua <= hoaDon.dienThoai.soLuongTonKho) {
      hoaDon.dienThoai.soLuongTonKho -= hoaDon.soLuongMua;
      _danhSachHoaDon.add(hoaDon);
    } else {
      throw ArgumentError("Không đủ hàng trong kho.");
    }
  }

  // Tìm kiếm hóa đơn theo mã, ngày, khách hàng
  List<HoaDon> timKiemHoaDon({String? maHD, DateTime? ngayBan, String? tenKhach}) {
    return _danhSachHoaDon.where((hoaDon) {
      return (maHD == null || hoaDon.maHD.contains(maHD)) &&
             (ngayBan == null || hoaDon.ngayBan.isAtSameMomentAs(ngayBan)) &&
             (tenKhach == null || hoaDon.tenKhachHang.contains(tenKhach));
    }).toList();
  }

  // Hiển thị danh sách hóa đơn
  void hienThiDanhSachHoaDon() {
    print("Danh sách hóa đơn:");
    for (var hd in _danhSachHoaDon) {
      hd.hienThiThongTinHoaDon();
      print("--------");
    }
  }

  // Tính tổng doanh thu theo khoảng thời gian
  double tongDoanhThu(DateTime tuNgay, DateTime denNgay) {
    double doanhThu = 0;
    for (var hoaDon in _danhSachHoaDon) {
      if (hoaDon.ngayBan.isAfter(tuNgay) && hoaDon.ngayBan.isBefore(denNgay)) {
        doanhThu += hoaDon.giaBanThucTe * hoaDon.soLuongMua;
      }
    }
    return doanhThu;
  }

  // Tính tổng lợi nhuận theo khoảng thời gian
  double tongLoiNhuan(DateTime tuNgay, DateTime denNgay) {
    double loiNhuan = 0;
    for (var hoaDon in _danhSachHoaDon) {
      if (hoaDon.ngayBan.isAfter(tuNgay) && hoaDon.ngayBan.isBefore(denNgay)) {
        loiNhuan += hoaDon.tinhLoiNhuanThucTe();
      }
    }
    return loiNhuan;
  }

  // Thống kê top điện thoại bán chạy
  List<DienThoai> topDienThoaiBanChay() {
    Map<DienThoai, int> soLuongBan = {};
    for (var hoaDon in _danhSachHoaDon) {
      if (soLuongBan.containsKey(hoaDon.dienThoai)) {
        soLuongBan[hoaDon.dienThoai] = soLuongBan[hoaDon.dienThoai]! + hoaDon.soLuongMua;
      } else {
        soLuongBan[hoaDon.dienThoai] = hoaDon.soLuongMua;
      }
    }
    var sortedList = soLuongBan.keys.toList()
      ..sort((a, b) => soLuongBan[b]!.compareTo(soLuongBan[a]!));
    return sortedList;
  }

  // Thống kê tồn kho
  void thongKeTonKho() {
    print("Tồn kho hiện tại:");
    for (var dt in _danhSachDienThoai) {
      print("${dt.tenDT} - ${dt.soLuongTonKho} sản phẩm");
    }
  }
}
