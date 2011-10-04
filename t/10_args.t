# $Id: 10_args.t,v 1.1 2011/10/04 19:58:19 pmh Exp $


use Test::More tests => 10;
use strict;

BEGIN { use_ok('HTML::StickyForm'); }
ok(*_args=\&HTML::StickyForm::_args,'"import" sub');


for(
  ['empty',		{}],
  ['name',		{name=>'fred'},name=>'fred'],

  ['empty hash',	{},{}],
  ['name hash',		{name=>'fred'},{name=>'fred'}],
){
  my($name,$expect,@args)=@$_;
  my $self=rand;
  my($got_self,$got)=_args($self,@args);

  is($got_self,$self,"$name, self preserved");
  is_deeply($got,$expect,"$name, args");
}

