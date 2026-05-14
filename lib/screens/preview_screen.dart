import 'package:flutter/material.dart';
import '../models/cv_model.dart';

class PreviewScreen extends StatelessWidget {
  final CVModel cv;
  const PreviewScreen({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F6AF5),
        foregroundColor: Colors.white,
        title: const Text(
          'Your CV',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _showJson(context),
            icon: const Icon(Icons.data_object, color: Colors.white, size: 18),
            label: const Text(
              'JSON',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (cv.basics.summary.isNotEmpty) ...[
                      _sectionTitle('Summary'),
                      Text(
                        cv.basics.summary,
                        style: const TextStyle(
                          fontSize: 13.5,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (cv.experience.isNotEmpty) ...[
                      _sectionTitle('Experience'),
                      ...cv.experience.map(_experienceTile),
                      const SizedBox(height: 8),
                    ],
                    if (cv.education.isNotEmpty) ...[
                      _sectionTitle('Education'),
                      ...cv.education.map(_educationTile),
                      const SizedBox(height: 8),
                    ],
                    if (cv.skills.isNotEmpty) ...[
                      _sectionTitle('Skills'),
                      _skillsWrap(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4F6AF5), Color(0xFF7B8FF7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cv.basics.name.isEmpty ? 'Your Name' : cv.basics.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          if (cv.basics.title.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              cv.basics.title,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: [
              if (cv.basics.email.isNotEmpty)
                _contactChip(Icons.email_outlined, cv.basics.email),
              if (cv.basics.phone.isNotEmpty)
                _contactChip(Icons.phone_outlined, cv.basics.phone),
              if (cv.basics.location.isNotEmpty)
                _contactChip(Icons.location_on_outlined, cv.basics.location),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: Colors.white70),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4F6AF5),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Divider(color: Color(0xFFDDE2FF), thickness: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _experienceTile(Experience exp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5, right: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF4F6AF5),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.role,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  exp.company,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4F6AF5),
                  ),
                ),
                if (exp.startDate.isNotEmpty || exp.endDate.isNotEmpty)
                  Text(
                    '${exp.startDate} — ${exp.endDate}',
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                if (exp.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    exp.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _educationTile(Education edu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF4F6AF5), width: 2),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${edu.degree} in ${edu.field}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  edu.institution,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4F6AF5),
                  ),
                ),
                if (edu.startYear.isNotEmpty || edu.endYear.isNotEmpty)
                  Text(
                    '${edu.startYear} — ${edu.endYear}',
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillsWrap() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: cv.skills.map((s) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF1FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFCDD4FF)),
          ),
          child: Text(
            '${s.name}  ·  ${s.level}',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF4F6AF5),
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showJson(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'CV JSON',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: SingleChildScrollView(
          child: SelectableText(
            cv.toJson(),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
