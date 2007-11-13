  package Code::Loader
# ********************
; our $VERSION='0.01'
# *******************
; use strict; use warnings
# the storage for created units

; my %storage
  
; sub _store
    { my ($unit)=@_
    ; return $storage{$unit->identifier}=$unit
    }

; sub _retrieve
    { my ($unit)=@_
    ; return $storage{$unit->identifier}
    }

; 1
  
__END__


=head1 NAME

Code::Loader::Unit - a chunk of code which is loaded dynamically

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

   Code::Loader::_store($unit);
   
   my $loaded = Code::Loader::_retrieve($unit);

   # $loaded and unit are the same object

=head1 DESCRIPTION

=head1 TODO

=head1 AUTHOR

=head1 BUGS

=head1 SEE ALSO

=head1 COPYRIGHT & LICENSE

Copyright 2007 Sebastian Knapp, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
