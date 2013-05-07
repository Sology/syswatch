require 'sys/filesystem'
require 'pony'
require "yaml"

module SysWatch
	class Runner
		def initialize options
			@options = {
				:foreground => false,
				:verbose => false,
				:config => SysWatch::DEFAULTS[:config]
			}.merge!(options)

			if read_config
				Process.daemon unless @options[:foreground]

				if @options[:test]
					notify "/foo", 0.1
					return
				end

				begin
					@configuration[:mountpoints].each do |mp|
						examine mp
					end
				end while sleep(@configuration[:delay])
			end
		end

		def examine mountpoint
			stat = Sys::Filesystem.stat(mountpoint)
			percent_left = stat.blocks_available.to_f / stat.blocks.to_f
			puts percent_left
			if percent_left < @configuration[:treshold]/100.0
				notify mountpoint, percent_left
			end
		end

		def notify mountpoint, percent_left
			mail = {
				:subject => "[SysWatch - #{@configuration[:label]}] Alert", 
				:body => ("Mountpoint %s has only %d%% space left!" % [mountpoint, percent_left*100])
			}
			Pony.mail(mail.merge(@configuration[:mail]))
		end

		def read_config
			@configuration = YAML.load_file(@options[:config])			
		rescue
			$stderr.puts "Unable to open config file #{@options[:config]}. Exiting."
			false
		end
	end
end
