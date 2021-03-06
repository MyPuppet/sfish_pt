
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(19422);
 script_version ("$Revision: 1.6 $");
 script_name(english: "RHSA-2005-589: gaim");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2005-589");
 script_set_attribute(attribute: "description", value: '
  An updated gaim package that fixes a buffer overflow security issue is now
  available.

  This update has been rated as having critical security impact by the Red
  Hat Security Response Team.

  Gaim is an Internet Instant Messaging client.

  A heap based buffer overflow issue was discovered in the way Gaim processes
  away messages. A remote attacker could send a specially crafted away
  message to a Gaim user logged into AIM or ICQ which could result in
  arbitrary code execution. The Common Vulnerabilities and Exposures project
  (cve.mitre.org) has assigned the name CAN-2005-2103 to this issue.

  Users of gaim are advised to upgrade to this updated package, which
  contains backported patches and is not vulnerable to this issue.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2005-589.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2005-2103");
script_summary(english: "Check for the version of the gaim packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"gaim-0.59.9-5.el2", release:'RHEL2.1') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
