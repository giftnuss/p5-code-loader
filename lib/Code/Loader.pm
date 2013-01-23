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
    
; sub _empty_storage
    { %storage = ()
    }

; 1
  
__END__


=head1 NAME

Code::Loader - storage for code units

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

   Code::Loader::_store($unit);
   
   my $loaded = Code::Loader::_retrieve($unit);

=head1 DESCRIPTION

This module is only a storage for code units. Each unit class has a method
C<identifier> which is used here as a hash key. The constructor of each unit
needs enough arguments to create the unique identifier for each object. So when
an unit is already loaded it could be retrieved from here.



=head1 AUTHOR

Sebastian Knapp E<lt>sk@computer-leipzig.comE<gt>

=head1 SEE ALSO

L<Code::Loader::Unit>

=head1 COPYRIGHT & LICENSE

Copyright 2007 Sebastian Knapp, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
