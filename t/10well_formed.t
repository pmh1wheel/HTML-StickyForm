# $Id: 10well_formed.t,v 1.1 2005/10/19 14:01:39 pmh Exp $

use Test::More tests => 8;
use strict;

BEGIN{ use_ok('HTML::StickyForm'); }

isa_ok(my $form=HTML::StickyForm->new,'HTML::StickyForm','form');

ok($form->well_formed,'starts off set');
ok($form->well_formed,'stays set');

ok(!$form->well_formed(0),'gets unset');
ok(!$form->well_formed,'stays unset');

ok($form->well_formed(1),'gets set');
ok($form->well_formed,'stays set');

# XXX We really ought to test the effect on form generation

