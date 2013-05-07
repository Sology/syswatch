require "optparse"

module SysWatch

	# Handles command line interface
	class CLI
		
		# Initialize a new system watcher
		#
		# @param argv [Hash] the command line parameters hash (usually `ARGV`).
		# @param env [Hash] the environment variables hash (usually `ENV`).
		def initialize(argv, env)
			parse_options! argv

			@runner = Runner.new @options
		end

		# Parse the command line options
		def parse_options!(args)
			@options = {}
			opts = ::OptionParser.new do |opts|
				opts.banner = "Usage: syswatch [options]\n\n  Options:"

				opts.on("-f", "--foreground", "Do not daemonize, just run in foreground.") do |f|
					@options[:foreground] = f
				end

				opts.on("-v", "--verbose", "Be verbose, print out some messages.") do |v|
					@options[:verbose] = v
				end

				opts.on("-t", "--test", "Test notifications.") do |t|
					@options[:test] = t
				end

				opts.on("-c", "--config [FILE]", "Use a specific config file, instead of `#{SysWatch::DEFAULTS[:config]}`") do |config|
					@options[:config] = config
				end
			end
			opts.parse! args
		end
	end
end
