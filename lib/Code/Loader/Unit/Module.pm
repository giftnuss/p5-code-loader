  package Code::Loader::Unit::Module
# **********************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings
  
; use base 'Code::Loader::Unit::File'

; __PACKAGE__->mk_accessors qw/modulename namespaces/
 
=head2 Constructor

There three different kinds to construct such an unit.
If there is more than one kind is used in one constructor
call the first in following list ist really used.

=over 4

=item filename

The most significant unit desciptor is inherited from
base class C<Code::Loader::Unit::File>.

=item modulename

A string which is a normal perl package name.
  
=item namespaces
  
It means a list of strings, which when joined with '::'
is a correct perl package name.
  
=back 4

;  

; 1
  
__END__
  
