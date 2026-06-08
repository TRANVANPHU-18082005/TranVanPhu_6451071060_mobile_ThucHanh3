import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/expandable_menu_item.dart';
import 'widgets/edit_about_me_dialog.dart';
import 'widgets/edit_skill_dialog.dart';
import 'widgets/add_edit_list_item_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Trạng thái mở rộng (Expand) của các mục
  bool isAboutMeExpanded = true;
  bool isWorkExpExpanded = true;
  bool isEducationExpanded = true;
  bool isSkillExpanded = true;
  bool isLanguageExpanded = true;
  bool isAppreciationExpanded = true;
  bool isResumeExpanded = true;
  
  // Dữ liệu hiển thị (mock data)
  String aboutMeText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lectus id commodo egestas metus interdum dolor.";
  List<Map<String, String>> experiences = [{'title': 'Manager', 'company': 'Amazon Inc', 'duration': 'Jan 2015 - Feb 2022 - 5 Years'}];
  List<Map<String, String>> educations = [{'title': 'Information Technology', 'school': 'University of Oxford', 'duration': 'Sep 2010 - Aug 2013 - 3 Years'}];
  List<String> skills = ["Leadership", "Teamwork", "Visioner", "Target oriented", "Consistent"];
  List<String> languages = ["English", "German", "Spanish", "Mandarin", "Italy"];
  List<Map<String, String>> appreciations = [{'title': 'Wireless Symposium (RWS)', 'category': 'Young Scientist', 'year': '2014'}];
  List<Map<String, String>> resumes = [{'title': 'Jamet kudasi - CV - UI/UX Designer', 'info': '867 Kb - 14 Feb 2022 at 11:30 am'}];

  void _handleUpdateProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã cập nhật toàn bộ profile thành công!'), backgroundColor: Colors.green),
    );
  }

  void _showEditAboutMeDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => EditAboutMeDialog(initialText: aboutMeText),
    );
    if (result != null) setState(() => aboutMeText = result);
  }

  void _showEditSkillDialog() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) => EditSkillDialog(initialSkills: skills),
    );
    if (result != null) setState(() => skills = result);
  }

  void _showEditLanguageDialog() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) => EditSkillDialog(title: 'Edit Languages', initialSkills: languages),
    );
    if (result != null) setState(() => languages = result);
  }

  void _showAddWorkExp() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const AddEditListItemDialog(
        title: 'Add Work Experience',
        field1Label: 'Job Title (e.g. Manager)',
        field2Label: 'Company (e.g. Amazon Inc)',
        field3Label: 'Duration (e.g. 2015 - 2022)',
      ),
    );
    if (result != null) {
      setState(() {
        experiences.add({'title': result['field1']!, 'company': result['field2']!, 'duration': result['field3']!});
      });
    }
  }

  void _showAddEducation() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const AddEditListItemDialog(
        title: 'Add Education',
        field1Label: 'Field of Study (e.g. IT)',
        field2Label: 'School (e.g. Oxford)',
        field3Label: 'Duration (e.g. 2010 - 2013)',
      ),
    );
    if (result != null) {
      setState(() {
        educations.add({'title': result['field1']!, 'school': result['field2']!, 'duration': result['field3']!});
      });
    }
  }

  void _showAddAppreciation() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const AddEditListItemDialog(
        title: 'Add Appreciation',
        field1Label: 'Award Name',
        field2Label: 'Category',
        field3Label: 'Year',
      ),
    );
    if (result != null) {
      setState(() {
        appreciations.add({'title': result['field1']!, 'category': result['field2']!, 'year': result['field3']!});
      });
    }
  }

  void _showAddResume() {
    setState(() {
      resumes.add({
        'title': 'New Document - CV.pdf',
        'info': '1.2 Mb - Just now',
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã giả lập tải CV lên!'), backgroundColor: Colors.blue));
  }

  // Builder cho các item có title, subtitle, duration (VD: Work Exp, Education, Appreciation)
  Widget _buildListItem(Map<String, String> data, VoidCallback onDelete) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1A34), fontSize: 14),
                ),
                const SizedBox(height: 4),
                if (data.containsKey('company') || data.containsKey('school') || data.containsKey('category'))
                  Text(
                    data['company'] ?? data['school'] ?? data['category'] ?? '',
                    style: const TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                if (data.containsKey('duration') || data.containsKey('year')) ...[
                  const SizedBox(height: 4),
                  Text(
                    data['duration'] ?? data['year'] ?? '',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ]
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            onPressed: onDelete,
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/Edit.svg',
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(Colors.orange, BlendMode.srcIn),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cửa sổ Edit Item')));
            },
          )
        ],
      ),
    );
  }

  // Builder cho Resume Item
  Widget _buildResumeItem(Map<String, String> data, VoidCallback onDelete) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E1A34))),
                const SizedBox(height: 4),
                Text(data['info'] ?? '', style: const TextStyle(color: Colors.black54, fontSize: 11)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: onDelete,
          )
        ],
      ),
    );
  }

  // Builder cho danh sách dạng Chip (Skill, Language)
  Widget _buildChipList(List<String> items, VoidCallback onSeeMoreTap) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...items.map((s) => Chip(
          label: Text(s, style: const TextStyle(fontSize: 12)),
          backgroundColor: const Color(0xFFF3F4F6),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        )),
        GestureDetector(
          onTap: onSeeMoreTap,
          child: const Padding(
            padding: EdgeInsets.only(top: 12.0, left: 8.0),
            child: Text("See more", style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/Back.svg',
            width: 24, height: 24,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        title: const Text('Profile', style: TextStyle(color: Color(0xFF1E1A34), fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Logo/Avatar
              Container(
                width: 120, height: 120,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 60),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Nguyễn Công Vũ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E1A34))),
              const SizedBox(height: 4),
              const Text('6451071089@st.utc2.edu.vn', style: TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 32),
              
              // === ABOUT ME ===
              ExpandableMenuItem(
                iconPath: 'assets/icons/About me.svg',
                title: 'About me',
                isExpanded: isAboutMeExpanded,
                headerAction: HeaderAction.edit,
                onHeaderTap: () => setState(() => isAboutMeExpanded = !isAboutMeExpanded),
                onIconTap: _showEditAboutMeDialog,
                expandedContent: Text(
                  aboutMeText,
                  style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                ),
              ),

              // === WORK EXPERIENCE ===
              ExpandableMenuItem(
                iconPath: 'assets/icons/Word Exp.svg',
                title: 'Work experience',
                isExpanded: isWorkExpExpanded,
                headerAction: HeaderAction.add,
                onHeaderTap: () => setState(() => isWorkExpExpanded = !isWorkExpExpanded),
                onIconTap: _showAddWorkExp,
                expandedContent: Column(
                  children: experiences.map((exp) => _buildListItem(exp, () {
                    setState(() => experiences.remove(exp));
                  })).toList(),
                ),
              ),

              // === EDUCATION ===
              ExpandableMenuItem(
                iconPath: 'assets/icons/Education.svg',
                title: 'Education',
                isExpanded: isEducationExpanded,
                headerAction: HeaderAction.add,
                onHeaderTap: () => setState(() => isEducationExpanded = !isEducationExpanded),
                onIconTap: _showAddEducation,
                expandedContent: Column(
                  children: educations.map((edu) => _buildListItem(edu, () {
                    setState(() => educations.remove(edu));
                  })).toList(),
                ),
              ),

              // === SKILL ===
              ExpandableMenuItem(
                iconPath: 'assets/icons/skill.svg',
                title: 'Skill',
                isExpanded: isSkillExpanded,
                headerAction: HeaderAction.edit,
                onHeaderTap: () => setState(() => isSkillExpanded = !isSkillExpanded),
                onIconTap: _showEditSkillDialog,
                expandedContent: _buildChipList(skills, _showEditSkillDialog),
              ),

              // === LANGUAGE ===
              ExpandableMenuItem(
                iconPath: 'assets/icons/Language.svg',
                title: 'Language',
                isExpanded: isLanguageExpanded,
                headerAction: HeaderAction.edit,
                onHeaderTap: () => setState(() => isLanguageExpanded = !isLanguageExpanded),
                onIconTap: _showEditLanguageDialog,
                expandedContent: _buildChipList(languages, _showEditLanguageDialog),
              ),

              // === APPRECIATION ===
              ExpandableMenuItem(
                iconPath: 'assets/icons/Appreciation.svg',
                title: 'Appreciation',
                isExpanded: isAppreciationExpanded,
                headerAction: HeaderAction.add,
                onHeaderTap: () => setState(() => isAppreciationExpanded = !isAppreciationExpanded),
                onIconTap: _showAddAppreciation,
                expandedContent: Column(
                  children: appreciations.map((appr) => _buildListItem(appr, () {
                    setState(() => appreciations.remove(appr));
                  })).toList(),
                ),
              ),

              // === RESUME ===
              ExpandableMenuItem(
                iconPath: 'assets/icons/Icon resume.svg',
                title: 'Resume',
                isExpanded: isResumeExpanded,
                headerAction: HeaderAction.add,
                onHeaderTap: () => setState(() => isResumeExpanded = !isResumeExpanded),
                onIconTap: _showAddResume,
                expandedContent: Column(
                  children: resumes.map((cv) => _buildResumeItem(cv, () {
                    setState(() => resumes.remove(cv));
                  })).toList(),
                ),
              ),
              
              const SizedBox(height: 24),
              // Update Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleUpdateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF11005E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
