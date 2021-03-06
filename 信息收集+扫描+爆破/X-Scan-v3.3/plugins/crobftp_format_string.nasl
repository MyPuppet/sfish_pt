# 
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


# References:
#
# Date: 2 Jun 2003 16:55:10 -0000
# From: Luca Ercoli <luca.ercoli@inwind.it>
# To: bugtraq@securityfocus.com
# Subject: Format String Vulnerability in Crob Ftp Server

if(description)
{
 script_id(11687);
 script_bugtraq_id(7776);
 script_xref(name:"OSVDB", value:"4640");
 script_xref(name:"Secunia", value:"8929");
 script_version ("$Revision: 1.7 $");
 
 script_name(english:"Crob FTP Server user Field Remote Format String");
 script_summary(english:"Logs as a %x");

 script_set_attribute(
   attribute:"synopsis",
   value:"The remote FTP server has a format string vulnerability."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The version of Crob FTP server running on the remote host has a format\n",
     "string vulnerability when processing the USER command.  A remote\n",
     "attacker could exploit this to crash the service, or possibly execute\n",
     "arbitrary code."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://seclists.org/bugtraq/2003/Jun/0027.html"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Upgrade to Crob FTP server 2.50.10 or later."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"FTP");
 
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");

 script_dependencie("find_service1.nasl", "ftp_anonymous.nasl");
 script_require_keys("ftp/login");
 script_require_ports("Services/ftp", 21);

 exit(0);
}

include("ftp_func.inc");

port = get_kb_item("Services/ftp");
if (! port) port = 21;
if (! get_port_state(port)) exit(0);
soc = open_sock_tcp(port);
if (! soc) exit(0);

r = ftp_recv_line(socket:soc);
if ( "Crob FTP" >!< r ) exit(0);

send(socket:soc, data:'USER %d\r\n');
r = ftp_recv_line(socket:soc);
if(egrep(pattern:"^331.* for [0-9]+", string:r))security_hole(port);
ftp_close(socket:soc);
