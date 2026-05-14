import 'package:flutter/material.dart';
import '../models/cv_model.dart';
import '../widgets/section_card.dart';
import 'preview_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final cv = CVModel();

  // Basics controllers
  final _name = TextEditingController();
  final _title = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _location = TextEditingController();
  final _summary = TextEditingController();

  @override
  void dispose() {
    for (final c in [_name, _title, _email, _phone, _location, _summary]) {
      c.dispose();
    }
    super.dispose();
  }

  void _buildAndPreview() {
    if (!_formKey.currentState!.validate()) return;

    cv.basics = Basics(
      name: _name.text.trim(),
      title: _title.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      location: _location.text.trim(),
      summary: _summary.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PreviewScreen(cv: cv)),
    );
  }

  // ── Helpers ──────────────────────────────────

  Widget _field(
    TextEditingController ctrl,
    String label, {
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF7F8FF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF4F6AF5), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
            : null,
      ),
    );
  }

  // ── Education entries ────────────────────────

  Widget _educationSection() {
    return Column(
      children: [
        ...cv.education.asMap().entries.map((entry) {
          final i = entry.key;
          final edu = entry.value;
          return _entryTile(
            title: edu.institution.isEmpty
                ? 'Institution ${i + 1}'
                : edu.institution,
            onEdit: () => _editEducation(i),
            onDelete: () => setState(() => cv.education.removeAt(i)),
          );
        }),
        _addButton('Add Education', () => _editEducation(null)),
      ],
    );
  }

  void _editEducation(int? index) {
    final edu = index != null ? cv.education[index] : Education();
    final inst = TextEditingController(text: edu.institution);
    final deg = TextEditingController(text: edu.degree);
    final field = TextEditingController(text: edu.field);
    final start = TextEditingController(text: edu.startYear);
    final end = TextEditingController(text: edu.endYear);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Education',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            const SizedBox(height: 14),
            _sheetField(inst, 'Institution'),
            _sheetField(deg, 'Degree (e.g. B.Sc)'),
            _sheetField(field, 'Field of Study'),
            Row(
              children: [
                Expanded(child: _sheetField(start, 'Start Year')),
                const SizedBox(width: 10),
                Expanded(child: _sheetField(end, 'End Year')),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _btnStyle(),
                onPressed: () {
                  setState(() {
                    final updated = Education(
                      institution: inst.text.trim(),
                      degree: deg.text.trim(),
                      field: field.text.trim(),
                      startYear: start.text.trim(),
                      endYear: end.text.trim(),
                    );
                    if (index != null) {
                      cv.education[index] = updated;
                    } else {
                      cv.education.add(updated);
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Experience entries ───────────────────────

  Widget _experienceSection() {
    return Column(
      children: [
        ...cv.experience.asMap().entries.map((entry) {
          final i = entry.key;
          final exp = entry.value;
          return _entryTile(
            title: exp.company.isEmpty ? 'Company ${i + 1}' : exp.company,
            subtitle: exp.role,
            onEdit: () => _editExperience(i),
            onDelete: () => setState(() => cv.experience.removeAt(i)),
          );
        }),
        _addButton('Add Experience', () => _editExperience(null)),
      ],
    );
  }

  void _editExperience(int? index) {
    final exp = index != null ? cv.experience[index] : Experience();
    final company = TextEditingController(text: exp.company);
    final role = TextEditingController(text: exp.role);
    final start = TextEditingController(text: exp.startDate);
    final end = TextEditingController(text: exp.endDate);
    final desc = TextEditingController(text: exp.description);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Experience',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            const SizedBox(height: 14),
            _sheetField(company, 'Company'),
            _sheetField(role, 'Role / Job Title'),
            Row(
              children: [
                Expanded(child: _sheetField(start, 'Start Date')),
                const SizedBox(width: 10),
                Expanded(child: _sheetField(end, 'End Date')),
              ],
            ),
            _sheetField(desc, 'Description', maxLines: 3),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _btnStyle(),
                onPressed: () {
                  setState(() {
                    final updated = Experience(
                      company: company.text.trim(),
                      role: role.text.trim(),
                      startDate: start.text.trim(),
                      endDate: end.text.trim(),
                      description: desc.text.trim(),
                    );
                    if (index != null) {
                      cv.experience[index] = updated;
                    } else {
                      cv.experience.add(updated);
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Skills entries ───────────────────────────

  Widget _skillsSection() {
    return Column(
      children: [
        ...cv.skills.asMap().entries.map((entry) {
          final i = entry.key;
          final skill = entry.value;
          return _entryTile(
            title: skill.name.isEmpty ? 'Skill ${i + 1}' : skill.name,
            subtitle: skill.level,
            onEdit: () => _editSkill(i),
            onDelete: () => setState(() => cv.skills.removeAt(i)),
          );
        }),
        _addButton('Add Skill', () => _editSkill(null)),
      ],
    );
  }

  void _editSkill(int? index) {
    final skill = index != null ? cv.skills[index] : Skill();
    final nameCtrl = TextEditingController(text: skill.name);
    String level = skill.level;
    const levels = ['Beginner', 'Intermediate', 'Advanced', 'Expert'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Skill',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 14),
              _sheetField(nameCtrl, 'Skill Name'),
              const Text(
                'Level',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: levels.map((l) {
                  final selected = l == level;
                  return ChoiceChip(
                    label: Text(l),
                    selected: selected,
                    selectedColor: const Color(0xFF4F6AF5),
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                      fontSize: 13,
                    ),
                    onSelected: (_) => setSheet(() => level = l),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: _btnStyle(),
                  onPressed: () {
                    setState(() {
                      final updated = Skill(
                        name: nameCtrl.text.trim(),
                        level: level,
                      );
                      if (index != null) {
                        cv.skills[index] = updated;
                      } else {
                        cv.skills.add(updated);
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Shared helpers ───────────────────────────

  Widget _sheetField(
    TextEditingController ctrl,
    String label, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF7F8FF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF4F6AF5), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _entryTile({
    required String title,
    String? subtitle,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        subtitle: subtitle != null && subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: Color(0xFF4F6AF5),
              ),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                size: 18,
                color: Colors.redAccent,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _addButton(String label, VoidCallback onTap) {
    return TextButton.icon(
      onPressed: onTap,
      icon: const Icon(
        Icons.add_circle_outline,
        size: 18,
        color: Color(0xFF4F6AF5),
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF4F6AF5),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  ButtonStyle _btnStyle() => ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF4F6AF5),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  // ── Build ────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F6AF5),
        foregroundColor: Colors.white,
        title: const Text(
          'CV Builder',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionCard(
              title: 'Basic Information',
              icon: Icons.person_outline,
              child: Column(
                children: [
                  _field(_name, 'Full Name', required: true),
                  _field(_title, 'Job Title / Headline'),
                  _field(_email, 'Email', keyboard: TextInputType.emailAddress),
                  _field(_phone, 'Phone', keyboard: TextInputType.phone),
                  _field(_location, 'Location (City, Country)'),
                  _field(_summary, 'Professional Summary', maxLines: 3),
                ],
              ),
            ),
            SectionCard(
              title: 'Education',
              icon: Icons.school_outlined,
              child: _educationSection(),
            ),
            SectionCard(
              title: 'Experience',
              icon: Icons.work_outline,
              child: _experienceSection(),
            ),
            SectionCard(
              title: 'Skills',
              icon: Icons.bolt_outlined,
              child: _skillsSection(),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              style: _btnStyle().copyWith(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              onPressed: _buildAndPreview,
              icon: const Icon(Icons.remove_red_eye_outlined),
              label: const Text(
                'Preview CV',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
