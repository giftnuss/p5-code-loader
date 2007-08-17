  package Code::Loader
# ********************
; our $VERSION='0.01'
# *******************
  
# the storage for created units

; my %storage
  
; sub _store
    { my ($unit)=@_
    ; return $storage{$unit->identifier}=$unit
    }

; sub _retrieve
    { my ($unit)=@_
    ; return $storage{$self->identifier}
    }

; 1
  
__END__

