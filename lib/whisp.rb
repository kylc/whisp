$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'treetop'
require 'bitescript'

# Parser
require 'whisp/parser/syntax'
require 'whisp/parser/parser'

# Interpreter
require 'whisp/interpreter/environment'
require 'whisp/interpreter/native_function_helper'
require 'whisp/interpreter/interpreter'

# Compiler
require 'whisp/compiler/nodes'
require 'whisp/compiler/compiler'

# Treetop now uses the Polyglot gem, so the following require statement will
# look for either a grammar.rb file or automatically load a grammar.tt file.
require 'whisp/parser/grammar'

module Whisp
  VERSION = "0.0.1"

  ROOT_PROJECT_PATH = File.expand_path File.join(File.dirname(__FILE__), "..")
end
