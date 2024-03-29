﻿#!/usr/bin/perl

; use strict
; package main

; use Test::More tests => 10

# 01 -- loadable
; BEGIN { use_ok( 'Shari::Code::Loader::Unit::File' ) }
; diag( "Testing Shari::Code::Loader::Unit::File " .
        "$Code::Loader::Unit::File::VERSION, Perl $], $^X" )

; my $testfile1 = './t/code/one.pl'
; my $unit = Shari::Code::Loader::Unit::File
    ->create(filename => $testfile1)
    
; isa_ok($unit, 'Shari::Code::Loader::Unit::File')
    
# 02 -- unit is created but not loaded
; ok($unit->is_empty,'new units are empty')

# 03 -- has no error 
; ok(!$unit->has_error,'no error so far')

# 04 -- testfile exists
; ok(-f $testfile1)

# 05 -- filename as identifier
# this may change in future
; is($unit->identifier,$testfile1,'identifier=filename')

# 06 -- not up to date
; ok(!$unit->is_uptodate,'not uptodate')

; $unit->load

; ok($unit->is_ready,"unit is ready")

# 07 -- if no package is given the unit is used as namespace
# this may change in future
; is(Shari::Code::Loader::Unit::File::one(),1,"unit performs well")

# 08 -- is uptodate
; ok($unit->is_uptodate,'is uptodate')

#; use Data::Dumper
#; print Dumper($unit)

