class Employ {
  late int id;
  late String empId;
  late String name;
  late String username;
  late String profileImg;
  late String email;
  late String phone;
  late String web;
  late String address;
  late String company;

  Employ(this.empId, this.name, this.username, this.profileImg, this.email,
      this.phone, this.web, this.address, this.company);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'emp_id': empId,
      'name': name,
      'username': username,
      'email': email,
      'profile_image': profileImg,
      'phone': phone,
      'website': web,
      'address': address,
      'company': company
    };
    return map;
  }

  Employ.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    empId = map['emp_id'];
    name = map['name'];
    username = map['username'];
    email = map['email'];
    profileImg = map['profile_image'];
    phone = map['phone'];
    web = map['website'];
    address = map['address'].toString();
    company = map['company'].toString();
  }

  static Address praseAddress(json) {
    //var list = json['address'] as List;
    Address aList = Address.fromMap(json);
    return aList;
  }

  static Company praseCompany(json) {
    print('company json :  $json');
    // var list = json['company'] as List;
    //List<Company> cList = list.map((data) => Company.fromMap(data)).toList();
    Company cList = Company.fromMap(json);
    return cList;
  }
}

class Address {
  late String id;
  late String empId;
  late String street;
  late String suite;
  late String city;
  late String zipcode;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'emp_id': empId,
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode
    };
    return map;
  }

  Address.fromMap(Map<String, dynamic> map) {
    street = map['street'];
    suite = map['suite'];
    city = map['city'];
    zipcode = map['zipcode'];
  }
}

class Company {
  late String id;
  late String empId;
  late String name;
  late String catchPhrase;
  late String bs;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'emp_id': empId,
      'company_name': name,
      'catchPhrase': catchPhrase,
      'bs': bs
    };
    return map;
  }

  Company.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    catchPhrase = map['catchPhrase'];
    bs = map['bs'];
  }
}
