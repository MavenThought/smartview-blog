require 'yaml'
require 'pry'

# This is a Jekyll plugin to import arbitrary variables from a YAML file,
# and make it available from templates. YAML file name could be defined by
# JEKYLL_VARIABLES environmental variable. If this file exists and contains
# hash definition, eac hash item becomes accessible via 'site' template
# object fields.

# This file should be copyed or linked to '_plugins' directory inside Jekyll
# site source directory, or 'plugins' folder if you using Octopress.

module Jekyll
  class EnvironmentVariablesGenerator < Generator
    def generate(site)
      begin
        if env_file = ENV['RACK_ENV']
          vars = YAML.load_file File.join(site.source, "environments", env_file + ".yml")
          vars.keys.each {|name| site.config[name.downcase] = vars[name]}
        end
      rescue => e
        return
      end
    end
  end
end
