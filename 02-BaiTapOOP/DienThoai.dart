class DienThoai{
  //Thuoc tinh
  String _maDT;
  String _tenDT;
  String _hangSanXuat;
  double _giaNhap;
  double _giaBan;
  int _soLuongTonKho;
  bool _trangThai;


  //Contractor
  //DienThoai(this._maDT, this._tenDT, this._hangSanXuat);
  DienThoai(this._maDT, this._tenDT,
             this._hangSanXuat, this._giaNhap,
              this._giaBan,this._soLuongTonKho, this._trangThai);
  
  //Getter 
  String get maDT => _maDT;
  String get tenDT => _tenDT;
  String get hangSanXuat => _hangSanXuat;
  double get giaNhap => _giaNhap;
  double get giaBan => _giaBan;
  int get soLuongTonKho => _soLuongTonKho;
  bool get trangThai=> _trangThai;

  //Setter chua lam sdt, gia nhap, gia ban
  set tenDT(String tenDT){
    if(tenDT.isNotEmpty){
      _tenDT = tenDT;
    }
  }

  set hangSanXuat(String hangSanXuat){
    if(hangSanXuat.isNotEmpty){
      _hangSanXuat = hangSanXuat;
    }
  }

  set soLuongTonKho(int soLuongTonKho) {
    if (soLuongTonKho >= 0) {
      _soLuongTonKho = soLuongTonKho;
    }
  }

  double Loinhandukien(){
    return giaBan-giaNhap;
  }

  set giaNhap(double giaNhap) {
    if (giaNhap > 0) {
      _giaNhap = giaNhap;
    }
  }

  set giaBan(double giaBan) {
    if (giaBan > _giaNhap && giaBan > 0) {
      _giaBan = giaBan;
    } else {
      throw ArgumentError("Giá bán phải lớn hơn giá nhập và lớn hơn 0.");
    }
  }

  set trangThai(bool trangThai) {
    _trangThai = trangThai;
  }

  void HienThiThongTinDT(){
    print("Ma Dien thoai $_maDT" );
    print("Ten Dien Thoai $_tenDT" );
    print("Hang San Xuat $_hangSanXuat" );
    print("Gia Nhap $_giaNhap" );
    print("Gia Ban $_giaBan" );
    print("So Luong ton kho la $_soLuongTonKho" );
    print("------------------\n");
    //print("Ten Dien Thoai $_tenDT" );
     
  }

  //Kiem tra
  bool coTheBan() => _soLuongTonKho > 0 && _trangThai;

}