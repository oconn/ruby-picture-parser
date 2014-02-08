require 'exifr'



class Parser
  def initialize
  end

  def photo_to_exif(file)
    
  end

  def parse_images
		images = []
	  Dir.entries("img/").each do |img|
	  	unless img[-4..-1] != ".jpg"
	  	  images << img if EXIFR::JPEG.new("img/#{img}").exif?
	    end
	  end
	  images
	end

end

class ExifData
  def initialize
  end
end

image_parser = Parser.new
