#!/usr/bin/env ruby
require_relative 'card'
require_relative 'deck'
require_relative 'board'
require_relative 'player'
require_relative 'dealer'
require_relative 'interface'
require_relative 'casino'
require_relative 'accounting'

interface = Interface.new
bj = Casino.new(interface)
bj.start
