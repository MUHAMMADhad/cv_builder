import 'dart:convert';

class Basics {
  String name;
  String title;
  String email;
  String phone;
  String location;
  String summary;

  Basics({
    this.name = '',
    this.title = '',
    this.email = '',
    this.phone = '',
    this.location = '',
    this.summary = '',
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'title': title,
    'email': email,
    'phone': phone,
    'location': location,
    'summary': summary,
  };

  factory Basics.fromMap(Map<String, dynamic> m) => Basics(
    name: m['name'] ?? '',
    title: m['title'] ?? '',
    email: m['email'] ?? '',
    phone: m['phone'] ?? '',
    location: m['location'] ?? '',
    summary: m['summary'] ?? '',
  );
}

class Education {
  String institution;
  String degree;
  String field;
  String startYear;
  String endYear;

  Education({
    this.institution = '',
    this.degree = '',
    this.field = '',
    this.startYear = '',
    this.endYear = '',
  });

  Map<String, dynamic> toMap() => {
    'institution': institution,
    'degree': degree,
    'field': field,
    'startYear': startYear,
    'endYear': endYear,
  };

  factory Education.fromMap(Map<String, dynamic> m) => Education(
    institution: m['institution'] ?? '',
    degree: m['degree'] ?? '',
    field: m['field'] ?? '',
    startYear: m['startYear'] ?? '',
    endYear: m['endYear'] ?? '',
  );
}

class Experience {
  String company;
  String role;
  String startDate;
  String endDate;
  String description;

  Experience({
    this.company = '',
    this.role = '',
    this.startDate = '',
    this.endDate = '',
    this.description = '',
  });

  Map<String, dynamic> toMap() => {
    'company': company,
    'role': role,
    'startDate': startDate,
    'endDate': endDate,
    'description': description,
  };

  factory Experience.fromMap(Map<String, dynamic> m) => Experience(
    company: m['company'] ?? '',
    role: m['role'] ?? '',
    startDate: m['startDate'] ?? '',
    endDate: m['endDate'] ?? '',
    description: m['description'] ?? '',
  );
}

class Skill {
  String name;
  String level;

  Skill({this.name = '', this.level = 'Intermediate'});

  Map<String, dynamic> toMap() => {'name': name, 'level': level};

  factory Skill.fromMap(Map<String, dynamic> m) =>
      Skill(name: m['name'] ?? '', level: m['level'] ?? 'Intermediate');
}

class CVModel {
  Basics basics;
  List<Education> education;
  List<Experience> experience;
  List<Skill> skills;

  CVModel({
    Basics? basics,
    List<Education>? education,
    List<Experience>? experience,
    List<Skill>? skills,
  }) : basics = basics ?? Basics(),
       education = education ?? [],
       experience = experience ?? [],
       skills = skills ?? [];

  Map<String, dynamic> toMap() => {
    'basics': basics.toMap(),
    'education': education.map((e) => e.toMap()).toList(),
    'experience': experience.map((e) => e.toMap()).toList(),
    'skills': skills.map((s) => s.toMap()).toList(),
  };

  String toJson() => const JsonEncoder.withIndent('  ').convert(toMap());

  factory CVModel.fromMap(Map<String, dynamic> m) => CVModel(
    basics: Basics.fromMap(m['basics'] ?? {}),
    education: (m['education'] as List? ?? [])
        .map((e) => Education.fromMap(e))
        .toList(),
    experience: (m['experience'] as List? ?? [])
        .map((e) => Experience.fromMap(e))
        .toList(),
    skills: (m['skills'] as List? ?? []).map((e) => Skill.fromMap(e)).toList(),
  );

  factory CVModel.fromJson(String source) =>
      CVModel.fromMap(jsonDecode(source));
}
