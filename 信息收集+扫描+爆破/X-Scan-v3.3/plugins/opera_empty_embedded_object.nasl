#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(14638);
 script_version("$Revision: 1.6 $");
 script_bugtraq_id(11090);
 script_xref(name:"OSVDB", value:"9561");

 script_name(english:"Opera Empty Embedded Object DoS");

 script_set_attribute(attribute:"synopsis", value:
"The remote host has an application that is affected by a denial
of service vulnerability." );
 script_set_attribute(attribute:"description", value:
"The version of Opera installed on the remote host contains a flaw that
allows an attacker to crash this browser remotely. 

To exploit this flaw, an attacker would need to craft a rogue website
containing an embedded 'CCCC' object with an empty 'src' tag in it and
would need to lure a victim to visit it." );
 script_set_attribute(attribute:"solution", value:
"Install Opera 7.54 or newer." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:N/A:P" );

script_end_attributes();
 
 script_summary(english:"Determines the version of Opera.exe");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_family(english:"Windows");
 script_dependencies("opera_installed.nasl");
 script_require_keys("SMB/Opera/Version");
 exit(0);
}

#

include("global_settings.inc");

version_ui = get_kb_item("SMB/Opera/Version_UI");
version = get_kb_item("SMB/Opera/Version");
if (isnull(version)) exit(0);

ver = split(version, sep:'.', keep:FALSE);
for (i=0; i<max_index(ver); i++)
  ver[i] = int(ver[i]);

if (
  ver[0] < 7 ||
  (ver[0] == 7 && ver[1] < 54)
)
{
  if (report_verbosity && version_ui)
  {
    report = string(
      "\n",
      "Opera ", version_ui, " is currently installed on the remote host.\n"
    );
    security_warning(port:get_kb_item("SMB/transport"), extra:report);
  }
  else security_warning(get_kb_item("SMB/transport"));
}
