# This script was automatically generated from the dsa-1232
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(23845);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1232");
 script_cve_id("CVE-2006-5874");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1232 security update');
 script_set_attribute(attribute: 'description', value:
'Stephen Gran discovered that malformed base64-encoded MIME attachments
can lead to denial of service through a null pointer dereference.
For the stable distribution (sarge) this problem has been fixed in
version 0.84-2.sarge.12.
For the upcoming stable distribution (etch) this problem has been
fixed in version 0.86-1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1232');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your clamav package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1232] DSA-1232-1 clamav");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1232-1 clamav");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'clamav', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'clamav-base', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'clamav-daemon', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'clamav-docs', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'clamav-freshclam', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'clamav-milter', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'clamav-testfiles', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'libclamav-dev', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'libclamav1', release: '3.1', reference: '0.84-2.sarge.12');
deb_check(prefix: 'clamav', release: '4.0', reference: '0.86-1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
