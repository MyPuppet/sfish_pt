# This script was automatically generated from the dsa-487
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15324);
 script_version("$Revision: 1.11 $");
 script_xref(name: "DSA", value: "487");
 script_cve_id("CVE-2004-0179");
 script_bugtraq_id(10136);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-487 security update');
 script_set_attribute(attribute: 'description', value:
'Multiple format string vulnerabilities were discovered in neon, an
HTTP and WebDAV client library.  These vulnerabilities could
potentially be exploited by a malicious WebDAV server to execute
arbitrary code with the privileges of the process using libneon.
For the current stable distribution (woody) these problems have been
fixed in version 0.19.3-2woody3.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2004/dsa-487');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2004/dsa-487
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA487] DSA-487-1 neon");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-487-1 neon");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'libneon-dev', release: '3.0', reference: '0.19.3-2woody3');
deb_check(prefix: 'libneon19', release: '3.0', reference: '0.19.3-2woody3');
deb_check(prefix: 'neon', release: '3.0', reference: '0.19.3-2woody3');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
