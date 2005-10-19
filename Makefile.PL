################################################################################
#
#   File name: Makefile.PL
#   Project: HTML::StickyForms
#
#   Author: Peter Haworth
#   Date created: 06/06/2000
#
#   $Id: Makefile.PL,v 1.2 2005/10/19 12:05:10 pmh Exp $
#
#   Copyright Institute of Physics Publishing 2001-2005
#
################################################################################

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'HTML::StickyForms',
  VERSION_FROM => 'lib/HTML/StickyForm.pm',
  dist => {
    COMPRESS => 'gzip -9f',
    SUFFIX => 'gz',
    DIST_DEFAULT => 'all tardist',
  },
  $ExtUtils::MakeMaker::VERSION >= 5.4301 ? (
    ABSTRACT => 'Generic mod_perl/CGI HTML form generation',
    AUTHOR => 'Peter Haworth (pmh@edison.ioppublishing.com)',
  ) : (),
);

