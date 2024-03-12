// To parse this JSON data, do
//
//     final jobsResponse = jobsResponseFromJson(jsonString);

import 'dart:convert';

List<JobsResponse> jobsResponseFromJson(String str) =>
    List<JobsResponse>.from(json.decode(str).map((x) => JobsResponse.fromJson(x)));

String jobsResponseToJson(List<JobsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobsResponse {
  final SalaryRange salaryRange;
  final String id;
  final String title;
  final String description;
  final List<String> requirements;
  final List<String> responsibilities;
  final String location;
  final Employer employer;

  JobsResponse({
    required this.salaryRange,
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.responsibilities,
    required this.location,
    required this.employer,
  });

  factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
    salaryRange: SalaryRange.fromJson(json["salaryRange"]),
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    requirements: List<String>.from(json["requirements"].map((x) => x)),
    responsibilities: List<String>.from(json["responsibilities"].map((x) => x)),
    location: json["location"],
    employer: Employer.fromJson(json["employer"])
  );

  Map<String, dynamic> toJson() => {
    "salaryRange": salaryRange.toJson(),
    "_id": id,
    "title": title,
    "description": description,
    "requirements": List<dynamic>.from(requirements.map((x) => x)),
    "responsibilities": List<dynamic>.from(responsibilities.map((x) => x)),
    "location": location,
    "employer": employer.toJson(),
  };
}

class Employer {
  final String id;
  final String email;
  final String image;

  Employer({
    required this.id,
    required this.email,
    required this.image,
  });

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
    id: json["_id"],
    email: json["email"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "image": image,
  };
}

class SalaryRange {
  final double low;
  final double high;
  final String currency;

  SalaryRange({
    required this.low,
    required this.high,
    required this.currency,
  });

  factory SalaryRange.fromJson(Map<String, dynamic> json) => SalaryRange(
    low: json["low"]?.toDouble(),
    high: json["high"]?.toDouble(),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "low": low,
    "high": high,
    "currency": currency,
  };
}
