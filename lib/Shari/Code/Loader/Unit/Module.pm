  package Shari::Code::Loader::Unit::Module
# *****************************************
; our $VERSION='0.01'
# *******************
; use strict; use warnings
; use base 'Shari::Code::Loader::Unit::File'

; __PACKAGE__->mk_accessors (qw/modulename namespaces/)

# TODO: wenn ein Modul bereits geladen ist sollte es nicht noch einmal
#       geladen werden, sondern direkt als geladen eingetragen werden.

; sub new
    { my ($self,%args) = @_
    
    ; $self = $self->SUPER::new(%args)

    ; if( $args{'filename'} )
        { $args{'skipdirs'} ||= 0 # 1 ist evtl sinnvoller
		; my ($v,$d,$n) = File::Spec->splitpath($args{'filename'})
		; my @d = File::Spec->splitdir($d)
		; pop @d if length($d[$#d]) == 0
		; @d = @d[$args{'skipdirs'} ... $#d]
		; $n =~ s/\..*//
		; $self->namespaces([@d,$n])
		; $self->modulename(join('::',@d,$n))
		; $self->filename($args{'filename'})
        }
      elsif( $args{'modulename'} )
        { die 'this ia a todo'
        }
      elsif( $args{'namespaces'} )
        { $self->namespaces([@{$args{'namespaces'}}])
        ; $self->modulename(join('::',@{$args{'namespaces'}}))
        ; $self->filename(join('/',@{$args{'namespaces'}}) . '.pm')
        }
    ; $self
    }

; sub identifier
    { return $_[0]->modulename
    }

; 1
  
__END__  
 
=head1 NAME

Code::Loader::Unit::Module

=head1 SYNOPSIS

=head1 DESCRIPTION

This is a subclass of L<Code::Loader::Unit::File> to load real perl modules.

=head2 Constructor

There are three different kinds to construct such an unit.
If there is more than one kind is used in one constructor
call the first one in the following list is used.

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

=head2 load

This
