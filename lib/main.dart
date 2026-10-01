import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const SarkariAllInOneApp());
}

class SarkariAllInOneApp extends StatelessWidget {
  const SarkariAllInOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sarkari Services Portal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<void> _launchPortal(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open $urlString')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error launching official link')),
        );
      }
    }
  }

  final List<Map<String, dynamic>> aadhaarServices = const [
    {"title": "Mobile Link Status", "icon": Icons.phone_android, "color": Colors.orange, "url": "https://myaadhaar.uidai.gov.in/"},
    {"title": "Document Update", "icon": Icons.file_upload, "color": Colors.blue, "url": "https://myaadhaar.uidai.gov.in/"},
    {"title": "Download e-Aadhaar", "icon": Icons.download, "color": Colors.green, "url": "https://myaadhaar.uidai.gov.in/genricDownloadAadhaar"},
    {"title": "Verify e-KYC Status", "icon": Icons.verified_user, "color": Colors.purple, "url": "https://myaadhaar.uidai.gov.in/"},
  ];

  final List<Map<String, dynamic>> bankServices = const [
    {"title": "NPCI Bank Link Status", "icon": Icons.account_balance, "color": Colors.teal, "url": "https://myaadhaar.uidai.gov.in/check-aadhaar-bank-seeding"},
    {"title": "DBT Status Portal", "icon": Icons.payments, "color": Colors.deepOrange, "url": "https://pfms.nic.in/"},
  ];

  final List<Map<String, dynamic>> rationServices = const [
    {"title": "Download Ration Card", "icon": Icons.card_membership, "color": Colors.amber, "url": "https://nfsa.gov.in/"},
    {"title": "Ration e-KYC Status", "icon": Icons.fact_check, "color": Colors.indigo, "url": "https://nfsa.gov.in/"},
    {"title": "Aadhaar Seeding Status", "icon": Icons.link, "color": Colors.lightGreen, "url": "https://nfsa.gov.in/"},
    {"title": "Ration Shop Locator", "icon": Icons.storefront, "color": Colors.pink, "url": "https://nfsa.gov.in/"},
  ];

  final List<Map<String, dynamic>> panServices = const [
    {"title": "PAN-Aadhaar Link Status", "icon": Icons.qr_code, "color": Colors.red, "url": "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/link-aadhaar-status"},
    {"title": "Link PAN with Aadhaar", "icon": Icons.add_link, "color": Colors.cyan, "url": "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/aadharlink"},
    {"title": "Download Instant e-PAN", "icon": Icons.picture_as_pdf, "color": Colors.deepPurple, "url": "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/instant-e-pan"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sarkari Utility Services', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDisclaimerCard(),
            const SizedBox(height: 12),

            _buildSectionTitle("Aadhaar Card Services", Icons.fingerprint),
            _buildGrid(context, aadhaarServices),
            const SizedBox(height: 18),

            _buildSectionTitle("Bank & NPCI Direct Transfer", Icons.account_balance_wallet),
            _buildGrid(context, bankServices),
            const SizedBox(height: 18),

            _buildSectionTitle("Ration Card & e-KYC Services", Icons.rice_bowl),
            _buildGrid(context, rationServices),
            const SizedBox(height: 18),

            _buildSectionTitle("PAN Card Services", Icons.badge),
            _buildGrid(context, panServices),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimerCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade700),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.amber),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Disclaimer: This app provides direct links to official government portals for user convenience. It is not an official government app.',
              style: TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo, size: 22),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<Map<String, dynamic>> serviceList) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: serviceList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        final item = serviceList[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => _launchPortal(context, item["url"]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: item["color"].withOpacity(0.15),
                    radius: 22,
                    child: Icon(item["icon"], color: item["color"], size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
