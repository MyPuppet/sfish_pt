#
# (C) Tenable Network Security, Inc.
#

# 
# Ref: Jeremy Bae
#


include("compat.inc");

if(description)
{
  script_id(16059);
  script_version("$Revision: 1.14 $");
  script_cve_id("CVE-2004-1419", "CVE-2004-2738");
  script_bugtraq_id(12103);
  script_xref(name:"OSVDB", value:"12580");
  script_xref(name:"OSVDB", value:"12581");
  script_xref(name:"OSVDB", value:"12582");
  
  script_name(english:"ZeroBoard < 4.1pl5 Multiple Remote Vulnerabilities");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains several PHP scripts that are prone to
arbitrary PHP code execution and cross-site scripting attacks." );
 script_set_attribute(attribute:"description", value:
"The remote host runs ZeroBoard, a web BBS application popular in
Korea. 

The remote version of this software is vulnerable to cross-site
scripting and remote script injection due to a lack of sanitization of
user-supplied data. 

Successful exploitation of this issue may allow an attacker to execute
arbitrary code on the remote host or to use it to perform an attack
against third-party users." );
 script_set_attribute(attribute:"see_also", value:"http://marc.info/?l=bugtraq&m=110391024404947&w=2" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to ZeroBoard 4.1pl5 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P" );

script_end_attributes();

  script_summary(english:"Checks for Zeroboard flaws");
  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");
  script_family(english:"CGI abuses");
  script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
  script_dependencie("http_version.nasl", "cross_site_scripting.nasl");
  exit(0);
}

#the code

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

if (thorough_tests) dirs = list_uniq("/zboard", "/bbs", cgi_dirs());
else dirs = make_list(cgi_dirs());

port = get_http_port(default:80);

test_cgi_xss(port: port, dirs: dirs, 
  cgi: "/check_user_id.php", qs: "user_id=<script>foo</script>",
  pass_str: "<script>foo</script>", ctrl_re: "ZEROBOARD\.COM");
