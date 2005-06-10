#!/usr/bin/perl -wT
#
# download.pl -- CGI interface for downloading files on packages.debian.org
#
# Copyright (C) 1998 (?) James Treacy
# Copyright (C) 2001 Josip Rodin
# Copyright (C) 2004 Frank Lichtenheld
#
# Licensed under the GPL or something.

require 5.001;
use strict;
use CGI ();

use lib "../lib";

use Packages::HTML ();

my ($input,   # The CGI data
    $file, $filen, $md5sum, @file_components, $type, $arch);

my @north_american_sites = qw(
	ftp.cs.umn.edu/pub/ubuntu
	mirror.clarkson.edu/pub/distributions/ubuntu
	ubuntu.mirrors.tds.net/ubuntu
	itanix.rutgers.edu/ubuntu
	www.opensourcemirrors.org/ubuntu
	ftp.ale.org/pub/mirrors/ubuntu
	ubuntu.secs.oakland.edu
	);
my @european_sites = qw(
	archive.ubuntu.com/ubuntu
	ubuntu.inode.at/ubuntu
	ubuntu.uni-klu.ac.at/ubuntu
	gd.tuwien.ac.at/opsys/linux/ubuntu/archive
	ftp.belnet.be/pub/mirror/ubuntu.com
	mirror.freax.be/ubuntu/archive.ubuntu.com
	archive.ubuntu.cz/ubuntu
	mirrors.dk.telia.net/ubuntu
	mirrors.dotsrc.org/ubuntu
	mir1.ovh.net/ubuntu/ubuntu
	ftp.inf.tu-dresden.de/os/linux/dists/ubuntu
	www.artfiles.org/ubuntu.com/archive
	ftp.rz.tu-bs.de/pub/mirror/ubuntu-packages
	ftp.join.uni-muenster.de/pub/mirrors/ftp.ubuntu.com/ubuntu
	ftp.kfki.hu/linux/ubuntu
	ubuntu.odg.cc
	ftp.esat.net/mirrors/archive.ubuntu.com
	ftp.heanet.ie/pub/ubuntu
	na.mirror.garr.it/mirrors/ubuntu-archive
	ftp.litnet.lt/pub/ubuntu
	ubuntu.synssans.nl
	ubuntulinux.mainseek.com/ubuntu
	ftp.acc.umu.se/mirror/ubuntu
	mirror.switch.ch/ftp/mirror/ubuntu
	www.mirrorservice.org/sites/archive.ubuntu.com/ubuntu
	);
my @south_american_sites = qw(
	ftp.interlegis.gov.br/pub/ubuntu/archive
        ubuntu.c3sl.ufpr.br
	);
my @australian_sites = qw(
	mirror.isp.net.au/ftp/pub/ubuntu
	www.planetmirror.com/pub/ubuntu
	);
my @asian_sites = qw(
	archive.ubuntu.org.cn/ubuntu
	komo.vlsm.org/ubuntu
	kambing.vlsm.org/ubuntu
	ubuntu.csie.ntu.edu.tw/ubuntu
	); 

# list of architectures
my %arches = (
        i386    => 'Intel x86',
        powerpc => 'PowerPC',
        ia64    => 'Intel IA-64',
        mips    => 'MIPS',
        mipsel  => 'MIPS (DEC)',
        s390    => 'IBM S/390',
	"hurd-i386" => 'Hurd (i386)',
	amd64   => 'AMD64',
);

my $urlbase = "http://www.debian.org";

$ENV{PATH} = "/bin:/usr/bin";
# Read in all the variables set by the form
$input = new CGI;

print $input->header;

# If you want, just print out a list of all of the variables.
# print $input->dump;
# exit;

$file = $input->param('file');
param_error( "file" ) unless defined $file;
@file_components = split('/', $file);
$filen = pop(@file_components);

$md5sum = $input->param('md5sum');
param_error( "md5sum" ) unless defined $md5sum;

$type = $input->param('type');
param_error( "type" ) unless defined $type;

$arch = $input->param('arch');
param_error( "arch" ) unless defined $arch;

my $arch_string = $arch ne 'all' ? "on $arches{$arch} machines" : "";

print Packages::HTML::header( title => "Package Download Selection", lang => "en",
	      print_title_above => 1 );

print "<h2>Download Page for <kbd>$filen</kbd> $arch_string</h2>\n".
    "<p>You can download the requested file from the <tt>";
my $dir;
foreach $dir (@file_components) { print "$dir/"; };
print "</tt> subdirectory at";
print $type ne 'security' ? " any of these sites:" : ":";
print "</p>\n";

if ($type eq 'security') {

	print <<END;
<ul>
  <li><a href="http://security.ubuntu.com/ubuntu/$file">security.ubuntu.com/ubuntu</a>
</ul>
END

} elsif ($type eq 'main') {

    print '<table border="0"><tr><td valign="top">';
    print_links( "North America", $file, @north_american_sites );
    print "</td><td>";
    print_links( "Europe", $file, @european_sites );
    print "</td></tr><tr><td>";
    print_links( "Australia and New Zealand", $file, @australian_sites );
    print "</td><td>";
    print_links( "Asia", $file, @asian_sites );
    print "</td></tr><tr><td>";
    print_links( "South America", $file, @south_american_sites );
    print "</td></tr></table>";

	print <<END;
<p>If none of the above sites are fast enough for you, please see the
<a href="http://www.ubuntulinux.org/wiki/Archive">complete mirror list</a>.<br>
The list of mirrors used by this scripts was last synced with the mirror list
<em>Wed, 22 Dec 2004 01:32:12 +0000</em>.</p>
END
}

print <<END;
<p>Note that in some browsers you will need to tell your browser you want
the file saved to a file. For example, in Netscape or Mozilla, you should
hold the Shift key when you click on the URL.</p>
END

print "<p>The MD5sum for <tt>$filen</tt> is <strong>$md5sum</strong></p>\n"
    if $md5sum;

# compute modification date
my $delta_time = -M $0;
my $mod_time = $^T - ($delta_time * 86400);
my $time_str = gmtime($mod_time)." +0000";

my $trailer = Packages::HTML::trailer( ".." );
$trailer =~ s/LAST_MODIFIED_DATE/$time_str/;
print $trailer;

exit;

sub print_links {
    my ( $title, $file, @servers ) = @_;

    print "<p><em>$title</em></p>";
    print "<ul>";
    foreach (@servers) {
	print "<li><a href=\"http://$_/$file\">$_</a></li>\n";
	# print "<li><a href=\"ftp://$_/$file\">$_</a></li>\n";
    }
    print "</ul>";

}

sub param_error {
    my $param = shift;

    print "<p>Internal error: Required parameter \"$param\" is missing.</p>\n";
    print "<p>If the problem persists, please inform $ENV{SERVER_ADMIN}.</p>\n";
    exit;
}
