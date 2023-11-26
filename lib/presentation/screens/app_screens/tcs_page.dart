import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';

class PrivacyTermsAndConditionsScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const PrivacyTermsAndConditionsScreen(),
    );
  }

  const PrivacyTermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: const MenuDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Privacy, T&Cs",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const TcsDetailSection(),
    );
  }
}

class TcsDetailSection extends StatelessWidget {
  const TcsDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          const Text(
            "Privacy, Terms and Conditions",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Welcome to Wholecela",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "These terms and conditions outline the rules and regulations for the use of Wholecela's Website, located at wholecela.com.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "By accessing this website we assume you accept these terms and conditions. Do not continue to use wholecela if you do not agree to take all of the terms and conditions stated on this page.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: 'Client', 'You' and 'Your' refers to you, the person log on this website and compliant to the Company's terms and conditions. 'The Company', 'Ourselves', 'We', 'Our' and 'Us', refers to our Company. 'Party', 'Parties', or 'Us', refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client's needs in respect of provision of the Company's stated services, in accordance with and subject to, prevailing law of zw. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Cookies",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "We employ the use of cookies. By accessing wholecela, you agreed to use cookies in agreement with the Wholecela's Privacy Policy.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Most interactive websites use cookies to let us retrieve the user's details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "License",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Unless otherwise stated, Wholecela and/or its licensors own the intellectual property rights for all material on wholecela. All intellectual property rights are reserved. You may access this from wholecela for your own personal use subjected to restrictions set in these terms and conditions.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "You must not:",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Republish material from wholecela",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Sell, rent or sub-license material from wholecela",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Reproduce, duplicate or copy material from wholecela",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Redistribute content from wholecela",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "This Agreement shall begin on the date hereof. Our Terms and Conditions were created with the help of the Free Terms and Conditions Generator.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Wholecela does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Wholecela,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Wholecela shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Wholecela reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "You warrant and represent that:",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "You are entitled to post the Comments on our website and have all necessary licenses and consents to do so;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "You hereby grant Wholecela a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Hyperlinking to our Content",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "The following organizations may link to our Website without prior written approval:",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Government agencies;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Search engines;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "News organizations;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Online directory distributors may link to our Website in the same manner as they hyperlink to the Websites of other listed businesses; and",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "These organizations may link to our home page, to publications or to other Website information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party's site.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "We may consider and approve other link requests from the following types of organizations:",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "commonly-known consumer and/or business information sources;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "dot.com community sites;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "associations or other groups representing charities;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "online directory distributors;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "internet portals;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "accounting, law and consulting firms; and",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "educational institutions and trade associations.",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Wholecela; and (d) the link is in the context of general resource information.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party's site.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to Wholecela. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Approved organizations may hyperlink to our Website as follows:",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "By use of our corporate name; or",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "By use of the uniform resource locator being linked to; or",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "By use of any other description of our Website being linked to that makes sense within the context and format of content on the linking party's site.",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "No use of Wholecela's logo or other artwork will be allowed for linking absent a trademark license agreement.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "iFrames",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Website.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Content Liability",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "We shall not be hold responsible for any content that appears on your Website. You agree to protect and defend us against all claims that is rising on your Website. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Reservation of Rights",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "We reserve the right to request that you remove all links or any particular link to our Website. You approve to immediately remove all links to our Website upon request. We also reserve the right to amen these terms and conditions and it's linking policy at any time. By continuously linking to our Website, you agree to be bound to and follow these linking terms and conditions.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Removal of links from our website",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "If you find any link on our Website that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "Disclaimer",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kBigTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our website and the use of this website. Nothing in this disclaimer will:",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "limit or exclude our or your liability for death or personal injury;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "limit or exclude our or your liability for fraud or fraudulent misrepresentation;",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "limit any of our or your liabilities in any way that is not permitted under applicable law; or",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "exclude any of our or your liabilities that may not be excluded under applicable law.",
              style: TextStyle(
                color: kBlackColor,
                fontSize: kNormalTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
          const Text(
            "As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.",
            style: TextStyle(
              color: kBlackColor,
              fontSize: kMediumTextSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(height: 15),
        ],
      ),
    );
  }
}
