# $Id: 00use_old.t,v 1.1 2005/10/19 13:58:10 pmh Exp $

use Test::More tests => 3;
BEGIN{ use_ok('HTML::StickyForms'); }
BEGIN{ use_ok('HTML::StickyForm'); }

is($HTML::StickyForms::VERSION,$HTML::StickyForm::VERSION,'same version');
