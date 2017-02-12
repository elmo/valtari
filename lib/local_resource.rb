require 'open-uri'
class LocalResource
  attr_reader :uri

   def initialize(uri)
     @uri = uri
   end

    def file
      @file ||= Tempfile.new(tmp_filename, tmp_folder, encoding: encoding).tap do |f|
        io.rewind
        f.write(io.read)
        f.close
     end
   end

   def io
     @io ||= URI.parse(uri).open
   end

  def encoding
    io.rewind
    io.read.encoding
  end

  def tmp_filename
    [
      Pathname.new(uri).basename,
      Pathname.new(uri).extname
    ].to_s
  end

  def tmp_folder
    Rails.root.join('tmp')
  end

end
