# $Id: 10_escape.t,v 1.1 2005/10/19 13:58:39 pmh Exp $


use Test::More tests => 9;
use strict;

BEGIN { use_ok('HTML::StickyForm'); }
ok(*_escape=\&HTML::StickyForm::_escape,'"import" sub');


for(
  [undef,'','undef'],
  ['abc','abc','no change'],
  ['abc&def','abc&#38;def','amp'],
  ['abc&def&ghi','abc&#38;def&#38;ghi','amp amp'],
  ['<tag><soup>','&#60;tag&#62;&#60;soup&#62;','<>'],
  ["\xff",'&#255;','8-bit'],
  ["\x{1ff}",'&#511;','9-bit'],
){
  my($from,$to,$name)=@$_;

  _escape($from);

  is($from,$to,$name);
}

