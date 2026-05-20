# CV Builder
<img width="380" height="778" alt="image" src="https://github.com/user-attachments/assets/65994718-bb70-4a25-989f-d2238adf1377" />


# Team Members
Muhammad Hadi 2380242
Muhammad Rohan Ali 2380246
Tahami Ishaq 2380277
Ahmed Bilal 2380224

A Flutter package to build and preview professional CVs with easy-to-use form inputs and JSON serialization support.

## Features

- **CV Form**: A ready-to-use `FormScreen` that allows users to input their professional details.
- **Dynamic Sections**: Add multiple entries for Education, Experience, and Skills.
- **CV Preview**: View the generated CV in a clean, modern layout using `PreviewScreen`.
- **JSON Support**: Easily serialize the CV data to JSON for storage or API integration.
- **Model Driven**: Built on top of a robust `CVModel` that handles all data logic.

## Getting started

Add `cv_builder` to your `pubspec.yaml`:

```yaml
dependencies:
  cv_builder:
    path: ../cv_builder # Use the appropriate path or version
```

## Usage

### Simple Implementation

You can directly use the `FormScreen` provided by the package to start building a CV.

```dart
import 'package:flutter/material.dart';
import 'package:cv_builder/cv_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF4F6AF5),
        useMaterial3: true,
      ),
      home: const FormScreen(),
    );
  }
}
```

### Working with the Model

You can also use the `CVModel` independently to manage data.

```dart
import 'package:cv_builder/cv_builder.dart';

void main() {
  // Create a new CV
  final myCV = CVModel(
    basics: Basics(
      name: 'John Doe',
      title: 'Flutter Developer',
      email: 'john@example.com',
    ),
  );

  // Add education
  myCV.education.add(Education(
    institution: 'University of Technology',
    degree: 'B.Sc in Computer Science',
    startYear: '2018',
    endYear: '2022',
  ));

  // Convert to JSON
  String json = myCV.toJson();
  print(json);

  // Create from JSON
  final importedCV = CVModel.fromJson(json);
}
```

## Data Models

The package provides several data models to structure CV information:

- `CVModel`: The root model containing all sections.
- `Basics`: Personal information (name, title, contact, summary).
- `Education`: Educational background.
- `Experience`: Work history and descriptions.
- `Skill`: Technical or soft skills with proficiency levels.

## Additional information

For more details on how to contribute or report issues, please visit the [GitHub repository](https://github.com/MUHAMMADhad/cv_builder).
