#!/usr/bin/perl

use Test::More tests => 4;
use Test::NoWarnings;
use blib;
use warnings;

BEGIN{ use_ok('HTML::StickyForms'); }
BEGIN{ use_ok('HTML::StickyForm'); }

is($HTML::StickyForms::VERSION,$HTML::StickyForm::VERSION,'same version');
