class OrganizationResponse {
  final bool status;
  final String message;
  final OrganizationData? data;

  OrganizationResponse({required this.status, required this.message, this.data});

  factory OrganizationResponse.fromJson(Map<String, dynamic> json) {
    return OrganizationResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: json['data'] != null ? OrganizationData.fromJson(json['data']) : null);
  }
}

class OrganizationData {
  final int organizationId;
  final String organizationName;
  final String address;
  final String phone;
  final String email;
  final String businessHours;
  final String createdAt;
  final String? updatedAt;

  OrganizationData({required this.organizationId, required this.organizationName, required this.address, required this.phone, required this.email, required this.businessHours, required this.createdAt, this.updatedAt});

  factory OrganizationData.fromJson(Map<String, dynamic> json) {
    return OrganizationData(
      organizationId: json['organization_id_PK'] ?? 0,
      organizationName: json['organization_name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      businessHours: json['business_hours'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'], // nullable, can be null
    );
  }
}
