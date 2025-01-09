import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          centerTitle: true,
          title: Text(
            'PRIVACY POLICY',
            style: TextStyle(fontWeight: FontWeight.bold, color: whitecolor),
          ),
          backgroundColor: chatgradient),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Le'xplore",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: chatgradient),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Last updated: dec 31, 2024',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Text(
              'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Text(
              'Interpretation and Definitions',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const SizedBox(height: 10),
            Text(
              'Interpretation',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            Text(
              'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Definitions',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const SizedBox(height: 10),
            Text(
              'For the purposes of this Privacy Policy:',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              '- Account means a unique account created for You to access our Service or parts of our Service.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Affiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Application refers to Travl agency, the software program provided by the Company.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to TRAVEL AGENCY.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Country refers to: Kerala, India',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Personal Data is any information that relates to an identified or identifiable individual.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Service refers to the Application.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Collecting and Using Your Personal Data',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const SizedBox(height: 10),
            Text(
              'Types of Data Collected',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'Personal Data',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            Text(
              'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '- Email address',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- First name and last name',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Phone number',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Usage Data',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            Text(
              'Usage Data is collected automatically when using the Service. Usage Data may include information such as Your Device\'s Internet Protocol address (e.g., IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers, and other diagnostic data.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Retention of Your Personal Data',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Transfer of Your Personal Data',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'Your information, including Personal Data, is processed at the Company\'s operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Delete Your Personal Data',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Our Service may give You the ability to delete certain information about You from within the Service.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Disclosure of Your Personal Data',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: chatgradient,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Business Transactions',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Law enforcement',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Other legal requirements',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '- Comply with a legal obligation',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Protect and defend the rights or property of the Company',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Prevent or investigate possible wrongdoing in connection with the Service',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Protect the personal safety of Users of the Service or the public',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Text(
              '- Protect against legal liability',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Security of Your Personal Data',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Children\'s Privacy',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent\'s consent before We collect and use that information.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Links to Other Websites',
              style: TextStyle(
                fontSize: 24,
                color: chatgradient,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party\'s site. We strongly advise You to review the Privacy Policy of every site You visit.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Changes to this Privacy Policy',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Contact Us',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: chatgradient),
            ),
            const Divider(thickness: 1.5, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              'If you have any questions about this Privacy Policy, You can contact us:',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '- By email: mubee160@gmail.com',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '- By phone number: 7025963877',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'THANK YOU...',
                style: TextStyle(fontSize: 28, color: chatgradient),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
