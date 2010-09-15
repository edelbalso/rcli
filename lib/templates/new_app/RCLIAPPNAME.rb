#!/usr/bin/env ruby

require 'rubygems'
require 'rcli'

#Rcli.trace_app = true # Uncomment if you want to enable tracing.

### LAUNCH RCLIAPPNAME
Rcli.script_root = Pathname(__FILE__).realpath.parent.to_s
commander = Commander.new
commander.go