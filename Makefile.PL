################################################################################
#
#   File name: Makefile.PL
#   Project: HTML::StickyForms
#
#   Author: Peter Haworth
#   Date created: 06/06/2000
#
#   sccs version: 1.2    last changed: 06/15/01
#
#   Copyright Peter Haworth 2001
#
################################################################################

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'HTML::StickyForms',
  VERSION_FROM => 'StickyForms.pm',
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

