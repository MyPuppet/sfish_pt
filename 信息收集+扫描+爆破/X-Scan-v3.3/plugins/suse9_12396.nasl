
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41292);
 script_version("$Revision: 1.2 $");
 script_name(english: "SuSE9 Security Update:  Security update for CUPS (12396)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE9 system is missing the security patch 12396");
 script_set_attribute(attribute: "description", value: 'The following bugs have been fixed:
Specially crafted tiff files could cause an integer overflow in the
\'imagetops\' filter (CVE-2009-0163).
Specially crafted pdf files could cause overflows in the \'pdftops\'
filter
(CVE-2009-0165, CVE-2009-0166, CVE-2009-0146, CVE-2009-0147,
CVE-2009-0799, CVE-2009-0800, CVE-2009-1179, CVE-2009-1180,
CVE-2009-1181, CVE-2009-1182, CVE-2009-1183).
');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch 12396");
script_end_attributes();

script_cve_id("CVE-2009-0146","CVE-2009-0147","CVE-2009-0163","CVE-2009-0165","CVE-2009-0166","CVE-2009-0799","CVE-2009-0800","CVE-2009-1179","CVE-2009-1180","CVE-2009-1181","CVE-2009-1182","CVE-2009-1183");
script_summary(english: "Check for the security advisory #12396");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"cups-1.1.20-108.58", release:"SUSE9", cpu: "i586") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"cups-client-1.1.20-108.58", release:"SUSE9", cpu: "i586") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"cups-devel-1.1.20-108.58", release:"SUSE9", cpu: "i586") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"cups-libs-1.1.20-108.58", release:"SUSE9", cpu: "i586") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
