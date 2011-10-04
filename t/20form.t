# $Id: 20form.t,v 1.2 2011/10/04 19:58:19 pmh Exp $

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

  my $out=$form->$meth($args)."X$end";
  is_xml($out,$expect,"$name, ref")
    or diag($out);
  $out=$form->$meth(%$args)."X$end";
  is_xml($out,$expect,"$name, flat")
    or diag($out);
}
