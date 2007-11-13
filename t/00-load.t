#!/usr/bin/perl

; use strict
; package main

; use Test::More tests => 11

; BEGIN 
    { use_ok( 'Code::Loader' ) 
    ; diag( "Testing Code::Loader $Code::Loader::VERSION, Perl $], $^X" )
    }

; BEGIN { use_ok( 'Code::Loader::Unit' ) }
; BEGIN { use_ok( 'Code::Loader::Unit::File' ) }
; BEGIN { use_ok( 'Code::Loader::Unit::Module' ) }

; my @accessors =
    qw/is_empty errors is_loaded was_loaded returnvalue loadattempts
	   loadcounter/
       
; ok(Code::Loader::Unit->can($_),"Accessor: $_") for @accessors

