# $Id: 20form.t,v 1.1 2005/10/19 14:02:42 pmh Exp $

use Test::More no_plan;
use Test::XML;
use strict;

my $Form;
BEGIN{ use_ok($Form='HTML::StickyForm'); }

isa_ok(my $form=$Form->new,$Form,'form');

is(my $end=$form->form_end,'</form>','end');

for(
  [{},'<form method="GET">X</form>','empty'],
  [{method => 'get'},'<form method="get">X</form>','method=get'],
  [{action => "some/location"},'<form method="GET" action="some/location">X</form>','action'],
  [{MULTI=>1},'<form enctype="mutipart/form-data" method="GET">X</form>','multipart'],
){
  my($args,$expect,$name)=@$_;
  my $meth=delete $args->{MULTI} ? 'form_start_multipart' : 'form_start';

  my $out=$form->$meth(%$args)."X$end";
  is_xml($out,$expect,$name)
    or diag($out);
}
