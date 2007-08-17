  package Code::Loader::Unit
# **************************
; our $VERSION='0.01'
# *******************

; use base 'Class::Accessor::Fast'
; use Carp ()
  
; __PACKAGE__->mk_accessors
    qw( is_empty       # es gibt keine Quelle oder Quelle ist leer
	errors         # Laden oder initialisieren verursachte Fehler
	is_loaded      # Code ist bereits geladen / moeglicherweise mit Fehlern
	was_loaded     # Der letzte Aufruf von load hat die Datei geladen.
	returnvalue    # Der Rueckgabewert wenn Unit in der load Methode 
	               # geladen wird / auch false ist erlaubt.
	loadattempts   # Zaehlt wie oft versucht wurde eine Einheit zu laden.
	loadcounter    # Zaehlt wie oft eine Einheit geladen wurde.
      )

; sub new
    { my ($pack,@args) = @_
    ; my $class = ref $pack || $pack
    ; $class->SUPER::new( {is_empty => 1, errors => [], @args} )
    }

; sub create
    { my ($pack,@args)=@_
    ; (local $Carp::CarpLevel=$Carp::CarpLevel)++
    ; my $temp=$pack->new(@args)
    ; if(my $exists=Code::Loader::_retrieve($temp))
       { return $exists }
    ; return Code::Loader::_store($temp)
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

; 1
  
__END__

