#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(14198);
 script_version("$Revision: 1.6 $");
 script_bugtraq_id(10628);
 script_xref(name:"OSVDB", value:"7956");

 script_name(english:"Dr.Web scanMail Function Unspecified Overflow");

 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code may be run on the remote host." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Dr.Web - an antivirus program.

There is a buffer overflow in the remote version of Dr.Web which might
allow an attacker to execute arbitrary commands on the remote host. Very
little details are known regarding this issue at this time." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to version 4.31.5 or newer." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 script_summary(english:"Determines the presence of Dr.Web");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_family(english:"Windows");
 script_dependencies("drweb_overflow.nasl");
 script_require_keys("DrWeb/Version");
 exit(0);
}

#

version = get_kb_item("DrWeb/Version");
if ( ! version ) exit(0);	
if(ereg(pattern:"([123]\..*|4\.([0-9][^0-9]|1[0-9]|2[0-9]|30|31\.[0-4]([^0-9]|$)))", string:version))
 	security_warning(get_kb_item("SMB/transport"));
