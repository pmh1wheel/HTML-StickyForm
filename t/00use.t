#!/usr/bin/perl

use Test::More tests => 3;
use Test::NoWarnings;
use blib;
use strict;
use warnings;

BEGIN{
  use_ok('HTML::StickyForm');
  use_ok('HTML::StickyForm::RequestHash');
}
