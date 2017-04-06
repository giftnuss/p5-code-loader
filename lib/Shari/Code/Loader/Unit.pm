  package Shari::Code::Loader::Unit
# *********************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings
; use base 'Class::Accessor::Fast'
; require Carp
; require Code::Loader
  
; __PACKAGE__->mk_accessors
     ( 'is_empty'       # es gibt keine Quelle oder Quelle ist leer
     , 'errors'         # Laden oder initialisieren verursachte Fehler
     , 'is_loaded'      # Code ist bereits geladen / moeglicherweise mit Fehlern
     , 'was_loaded'     # Der letzte Aufruf von load hat die Datei geladen.
     , 'returnvalue'    # Der Rueckgabewert wenn Unit in der load Methode 
                        # geladen wird / auch false ist erlaubt.
     , 'loadattempts'   # Zaehlt wie oft versucht wurde eine Einheit zu laden.
     , 'loadcounter'    # Zaehlt wie oft eine Einheit geladen wurde.
     )

# Store and retrieve methode should be overwritable because in some
# cenarious a central storage for all units isn't appropriate.
; sub _retrieve
    { Carp::croak("Have to be called with an object, and not with class: $_[0]")
        unless ref $_[0]
    ; return Code::Loader::_retrieve($_[0])
    }
    
; sub _store
    { Carp::croak("Have to be called with an object, and not with class: $_[0]")
        unless ref $_[0]
    ; Code::Loader::_store($_[0])
    }
    
# Private real constructor
; sub new
    { my ($pack,@args) = @_
    ; my $class = ref $pack || $pack
    ; return $class->SUPER::new
        ({ is_empty      => 1, 
            errors       => [], 
            loadattempts => 0,
            loadcounter  => 0, @args 
        })
    }

# Public constructs a new object or retrieves a existing one.
; sub create
    { my ($pack,@args)=@_
#    ; (local $Carp::CarpLevel=$Carp::CarpLevel)++
    ; my $temp=$pack->new(@args)
    ; if(my $exists=$temp->_retrieve)
       { return $exists }
    ; return $temp->_store
    }

; sub add_error
    { my ($self,@err)=@_
    ; push @{$self->errors},@err
    }

; sub has_error
    { my ($self)=@_
    ; return scalar @{$self->errors}
    }

; sub get_error
    { my ($self)=@_
    ; return join "\n",@{$self->errors}
    }

; sub clear_error
    { my ($self)=@_
    ; @{$self->errors}=()
    }

####################################
#        Abstract Methods
####################################
; sub load
    { # Don't forget to set the new state.
    }

; sub is_uptodate
    { # negation of needs_reload
    }

; sub identifier
    { # Should be unique
    }
    
####################################
# Shortcuts and Aliase
####################################
; sub is_ready
    { my ($self) = @_
    ; $self->is_loaded && !$self->has_error
    }

; 1
  
__END__

=head1 NAME

Code::Loader::Unit - a chunk of of which is loaded dynamically

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

   package Code::Loader::Unit::Spreadsheet;
   use base 'Code::Loader::Unit';

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
