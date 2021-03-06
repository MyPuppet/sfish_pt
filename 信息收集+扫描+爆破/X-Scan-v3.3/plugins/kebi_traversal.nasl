#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(11453); 
 script_version("$Revision: 1.13 $");

 script_bugtraq_id(7125);
 script_xref(name:"OSVDB", value:"51750");  

 script_name(english:"Kebi Academy Home Page Administration file Parameter Traversal Arbitrary File Access");
 
 script_set_attribute(
  attribute:"synopsis",
  value:string(
   "The remote web server contains a CGI script that is susceptible to a\n",
   "directory traversal attack."
  )
 );
 script_set_attribute(
  attribute:"description", 
  value:string(
   "Kebi Academy, a Korean web application, fails to sanitize user input\n",
   "to the 'file' parameter to the 'home' script of directory traversal\n",
   "sequences.  A remote attacker can leverage this issue to read\n",
   "arbitrary files or even upload arbitrary code to the affected host, to\n",
   "be executed subject to the privileges under which the web server\n",
   "operates."
  )
 );
 script_set_attribute(
  attribute:"see_also", 
  value:"http://archives.neohapsis.com/archives/bugtraq/2003-03/0239.html"
 );
 script_set_attribute(
  attribute:"see_also", 
  value:"http://www.nessus.org/u?c0d14d26"
 );
 script_set_attribute(
  attribute:"solution", 
  value:"Contact the vendor for an update."
 );
 script_set_attribute(
  attribute:"cvss_vector", 
  value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P"
 );
 script_set_attribute(
  attribute:"vuln_publication_date", 
  value:"2003/03/17"
 );
 script_set_attribute(
  attribute:"plugin_publication_date", 
  value:"2003/03/24"
 );
 script_end_attributes();
 
 summary["english"] = "kebi academy is vulnerable to an exploit which lets an attacker view any file that the cgi/httpd user has access to.";
 script_summary(english:summary["english"]);

 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("find_service1.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

function check(url)
{
  local_var r, w;

  w = http_send_recv3(method:"GET",item:url, port:port);
  if (isnull(w)) exit(0);
  r = strcat(w[0], w[1], '\r\n', w[2]);
  
  if(egrep(pattern:".*root:.*:0:[01]:", string:r))
  {
   	security_hole(port:port);
	return(1);
  }
 return(0);
}


alldirs = make_list("", "/k");


dirs = cgi_dirs();
foreach  d (dirs)
{
 alldirs = make_list(alldirs, d, string(d, "/k"));
}


foreach d (alldirs)
{
 url = string(d, "/home?dir=/&file=../../../../../../../../../../../../etc/passwd&lang=kor");
 if(check(url:url))exit(0);
}
