#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(22962);
 script_version("$Revision: 1.21 $");

 script_name(english: "Solaris 5.10 (sparc) : 120500-23");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 120500-23");
 script_set_attribute(attribute: "description", value:
'Sun Cluster 3.1: Core Patch for Solaris 10.
Date this patch was last updated by Sun : Apr/23/09');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-120500-23-1");
 script_set_attribute(attribute: "risk_factor", value: "Medium");
 script_end_attributes();

 script_summary(english: "Check for patch 120500-23");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120500-23", obsoleted_by:"", package:"SUNWscdev", version:"3.1.0,REV=2005.07.18.14.37");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120500-23", obsoleted_by:"", package:"SUNWscgds", version:"3.1.0,REV=2005.07.18.14.37");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120500-23", obsoleted_by:"", package:"SUNWscr", version:"3.1.0,REV=2005.07.18.14.37");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120500-23", obsoleted_by:"", package:"SUNWscu", version:"3.1.0,REV=2005.07.18.14.37");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120500-23", obsoleted_by:"", package:"SUNWscvm", version:"3.1.0,REV=2005.07.18.14.37");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_warning(0);
	else  
	   security_warning(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
