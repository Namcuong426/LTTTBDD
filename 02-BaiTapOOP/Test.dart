import "DienThoai.dart";
import 'CuaHang.dart';
import 'HoaDon.dart';

void main() {
  // Kiem tra dien thaoi

  print("");
  print("--- KIỂM TRA TẠO VÀ QUẢN LÝ ĐIỆN THOẠI ---");
  print("");

  // Tao dien thoai
  DienThoai dt1 = DienThoai("DT001", "iPhone 13", "Apple", 15000000, 20000000, 10, true);
  DienThoai dt2 = DienThoai("DT002", "Galaxy S21", "Samsung", 12000000, 18000000, 5, true);

  // Tao cua hang va them dien thoai vao cua hang
  CuaHang cuaHang = CuaHang("Cửa Hàng Điện Thoại CellPhoneS", "123 Đường Lê Văn Việt");
  cuaHang.themDienThoai(dt1);
  cuaHang.themDienThoai(dt2);

  // Hien thi danh sach co trong cua hang hien tai
  cuaHang.hienThiDanhSachDienThoai();

  // Cap nhat dien thoai DT002
  cuaHang.capNhatDienThoai("DT002", "Galaxy S21 Ultra", 19000000);

  // Ngung kinh doanh DT001
  cuaHang.ngungKinhDoanh("DT001");

  // Hien thi lai danh sach sau khi thuc hien
  cuaHang.hienThiDanhSachDienThoai();


  // Hoa Don

  print("--- KIỂM TRA TẠO VÀ QUẢN LÝ HÓA ĐƠN ---\n");

  // Tao Hoa Don
  HoaDon hoaDon1 = HoaDon("HD-001", DateTime.now(), dt2, 2, 19000000, "Nguyễn Văn A", "0987654321");

  // Tao hoa don cho cua hang
  cuaHang.taoHoaDon(hoaDon1);

  // Hien thi hoa don
  cuaHang.hienThiDanhSachHoaDon();

  // Tinh thong tien va lợi nhuận
  print("Tổng tiền hóa đơn: ${hoaDon1.tinhTongTien()}");
  print("Lợi nhuận thực tế: ${hoaDon1.tinhLoiNhuanThucTe()}");


  // Thống kê báo cáo

  print("--- KIỂM TRA THỐNG KÊ BÁO CÁO ---\n");

  // Tao them hóa đơn
  HoaDon hoaDon2 = HoaDon("HD-002", DateTime.now(), dt1, 3, 20000000, "Trần Thị B", "0912345678");
  cuaHang.taoHoaDon(hoaDon2);

  // Tinh doanh thu
  double doanhThu = cuaHang.tongDoanhThu(DateTime(2024, 1, 1), DateTime.now());
  print("Doanh thu trong tháng: $doanhThu");

  // Tinh loi nhuan
  double loiNhuan = cuaHang.tongLoiNhuan(DateTime(2024, 1, 1), DateTime.now());
  print("Lợi nhuận trong tháng: $loiNhuan");

  // Thống kê top bán chạy
  var topDienThoai = cuaHang.topDienThoaiBanChay();
  print("Top bán chạy:");
  topDienThoai.forEach((dt) {
    print("${dt.tenDT} bán được ${dt.soLuongTonKho} chiếc");
  });

  // Báo cáo tồn kho
  cuaHang.thongKeTonKho();
}
