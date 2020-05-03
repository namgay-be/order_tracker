require 'tempfile'
class CustomTempfile < Tempfile
  def initialize(filename, temp_dir = nil)
    temp_dir ||= Dir.tmpdir
    extension = File.extname(filename)
    basename = File.basename(filename, extension)
    super([basename, extension], temp_dir)
  end
end
