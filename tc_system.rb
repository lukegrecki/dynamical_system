require_relative 'system'
#require 'test/unit'

rule = { :s1 => :s2, :s2 => :s3, :s3 => :s1, :s4 => :s5, :s5 => :s4, :s6 => :s6 }
sys = System.new(rule, :s1)

