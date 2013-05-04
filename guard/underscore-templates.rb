require 'guard/guard'
require 'guard/watcher'

#
# Based on the guard-handlebars gem, which uses the following license:
#
# Copyright (C) 2012 by Chris Homer
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

module Guard
  class UnderscoreTemplates <  Guard
    def initialize(watchers = [], options = {})
      super(watchers, options)
      @options = options
      run_all
    end

    def run_all
      run_on_change(Watcher.match_files(self, Dir.glob(File.join('**', '*.*'))))
    end
  
    def run_on_change(paths)
      paths.each do |file|
        output_file = get_output(file)
        FileUtils.mkdir_p File.dirname(output_file)
        File.open(output_file, 'w') { |f| f.write(compile_underscore(file)) }
        ::Guard::UI.info "Compiled underscore template in '#{file}' to js in '#{output_file}'"
        ::Guard::Notifier.notify("Compiled underscore template in #{file}", :title => "Guard::UnderscoreTemplates", :image => :success) if @options[:notifications]
      end
      notify paths
    end

    def notify(changed_files)
      return unless ::Guard.respond_to? 'guards'
      ::Guard.guards.reject{ |guard| guard == self }.each do |guard|
        paths = Watcher.match_files(guard, changed_files)
        guard.run_on_change paths unless paths.empty?
      end
    end

  private

    # Get the file path to output the js based on the file being
    # built.  The output path is relative to where guard is being run.
    #
    # @param file [String] path to file being built
    # @return [String] path to file where output should be written
    #
    def get_output(file)
      file_dir = File.dirname(file)
      file_name = File.basename(file).split('.')[0..-2].join('.')
      unless file_name =~ /\.js$/
        file_name << ".js"
      end
      
      file_dir = file_dir.gsub(Regexp.new("#{@options[:input]}(\/){0,1}"), '') if @options[:input]
      file_dir = File.join(@options[:output], file_dir) if @options[:output]

      if file_dir == ''
        file_name
      else
        File.join(file_dir, file_name)
      end
    end

    def compile_underscore file
      content = IO.read(file)
      name = file.gsub('.tpl', '')      
      name = name.gsub(/^#{@options[:remove_prefix]}/, '')
      begin
        content = content.gsub("\n", '')
        content = content.gsub("'", "\\\\'")
        result = "App.templates = App.templates || {};\n"
        result = result + "App.templates['#{name}'] = '#{content}';\n"
        result
      rescue StandardError => error
        puts "ERROR COMPILING #{file}: #{error}"
      end
    end    
  end
end
