#!/usr/bin/perl

; use strict
; package main

; use Test::More tests => 8

; use_ok('Shari::Code::Loader::Unit')

; my $unit = create Shari::Code::Loader::Unit::()

; ok(!$unit->is_loaded,"not loaded")
; is($unit->identifier,'')
; is($unit->loadattempts,0)
; is($unit->is_empty,1)
; is($unit->loadcount,0)
; ok(!$unit->has_error,"no errors")
; ok(!$unit->was_loaded)
