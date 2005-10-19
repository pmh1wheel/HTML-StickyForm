# $Id: 00use.t,v 1.1 2005/10/19 13:57:28 pmh Exp $

use Test::More tests => 2;
use strict;

BEGIN{
  use_ok('HTML::StickyForm');
  use_ok('HTML::StickyForm::RequestHash');
}
