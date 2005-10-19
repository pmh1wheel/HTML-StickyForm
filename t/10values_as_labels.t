# $Id: 10values_as_labels.t,v 1.1 2005/10/19 14:01:39 pmh Exp $

use Test::More tests => 8;
use strict;

BEGIN{ use_ok('HTML::StickyForm'); }

isa_ok(my $form=HTML::StickyForm->new,'HTML::StickyForm','form');

ok(!$form->values_as_labels,'starts off unset');
ok(!$form->values_as_labels,'stays unset');

ok($form->values_as_labels(1),'gets set');
ok($form->values_as_labels,'stays set');

ok(!$form->values_as_labels(0),'gets unset');
ok(!$form->values_as_labels,'stays unset');
