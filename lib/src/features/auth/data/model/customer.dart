/// Model representing a customer from the external API
class Customer {
  /// Unique customer number
  final int customerNumber;

  /// Customer's first name
  final String firstname;

  /// Customer's last name
  final String lastname;

  /// Customer's salutation (Mr, Mrs, or Diverse)
  final String salutation;

  /// Street name of customer's address
  final String street;

  /// House number of customer's address
  final String housenumber;

  /// Additional address information (optional)
  final String? additionalAddressInfo;

  /// Postal code of customer's address
  final String postalCode;

  /// City of customer's address
  final String city;

  /// Customer's date of birth
  final DateTime birthday;

  /// Customer's IBAN
  final String iban;

  /// Customer's BIC
  final String bic;

  /// Customer's mandate reference
  final String mandateReference;

  /// External customer number
  final String externalCustomerNumber;

  /// Debit number
  final String debitNumber;

  /// Customer's email address
  final String email;

  /// Creates a new Customer instance
  const Customer({
    required this.customerNumber,
    required this.firstname,
    required this.lastname,
    required this.salutation,
    required this.street,
    required this.housenumber,
    this.additionalAddressInfo,
    required this.postalCode,
    required this.city,
    required this.birthday,
    required this.iban,
    required this.bic,
    required this.mandateReference,
    required this.externalCustomerNumber,
    required this.debitNumber,
    required this.email,
  });

  /// Creates a Customer instance from API response data
  factory Customer.fromApiResponse(Map<String, dynamic> json) {
    return Customer(
      customerNumber: json['customer_number'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      salutation: json['salutation'] as String,
      street: json['street'] as String,
      housenumber: json['housenumber'] as String,
      additionalAddressInfo: json['additional_adress_info'] as String?,
      postalCode: json['postal_code'] as String,
      city: json['city'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      iban: json['IBAN'] as String,
      bic: json['BIC'] as String,
      mandateReference: json['mandate_reference'] as String,
      externalCustomerNumber: json['external_customer_number'] as String,
      debitNumber: json['debit_number'] as String,
      email: json['email'] as String,
    );
  }

  /// Converts the Customer instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'customer_number': customerNumber,
      'firstname': firstname,
      'lastname': lastname,
      'salutation': salutation,
      'street': street,
      'housenumber': housenumber,
      'additional_adress_info': additionalAddressInfo,
      'postal_code': postalCode,
      'city': city,
      'birthday': birthday.toIso8601String(),
      'IBAN': iban,
      'BIC': bic,
      'mandate_reference': mandateReference,
      'external_customer_number': externalCustomerNumber,
      'debit_number': debitNumber,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'Customer(customerNumber: $customerNumber, firstname: $firstname, lastname: $lastname, email: $email)';
  }
}
