require 'byebug/command'
require 'byebug/helpers/bin'
require 'byebug/helpers/path'
require 'shellwords'
require 'English'
require 'rbconfig'

module Byebug
  #
  # Restart debugged program from within byebug.
  #
  class RestartCommand < Command
    include Helpers::BinHelper
    include Helpers::PathHelper

    self.allow_in_control = true
    self.allow_in_post_mortem = true

    def self.regexp
      /^\s* restart (?:\s+(?<args>.+))? \s*$/x
    end

    def self.description
      <<-EOD
        restart [args]

        #{short_description}

        This is a re-exec - all byebug state is lost. If command arguments are
        passed those are used.
      EOD
    end

    def self.short_description
      'Restarts the debugged program'
    end

    def execute
      cmd = [$PROGRAM_NAME]

      cmd = prepend_byebug_bin(cmd)
      cmd = prepend_ruby_bin(cmd)

      cmd += (@match[:args] ? @match[:args].shellsplit : $ARGV)

      puts pr('restart.success', cmd: cmd.shelljoin)
      Kernel.exec(*cmd)
    end

    private

    def prepend_byebug_bin(cmd)
      cmd.unshift(bin_file) if Byebug.mode == :standalone
      cmd
    end

    def prepend_ruby_bin(cmd)
      cmd.unshift(RbConfig.ruby) if which('ruby') != which(cmd.first)
      cmd
    end
  end
end
