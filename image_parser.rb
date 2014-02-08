require 'exifr'



class Parser
  def initialize
  end

  def photo_to_exif(file_path)
    width = EXIFR::JPEG.new(file_path).width               
		height = EXIFR::JPEG.new(file_path).height              
    model = EXIFR::JPEG.new(file_path).model              
		date_time = EXIFR::JPEG.new(file_path).date_time           
		exposure = EXIFR::JPEG.new(file_path).exposure_time.to_s  
		f_number = EXIFR::JPEG.new(file_path).f_number.to_f      
		latitude = EXIFR::JPEG.new(file_path).gps      
		longitude = EXIFR::JPEG.new(file_path).gps
		{ width: width, 
			height: height, 
			model: model, 
			date_time: date_time, 
			exposure: exposure, 
			f_number: f_number,
			latitude: latitude, 
			longitude: longitude}     
	end
end

class Image

  def initialize(args)
    @height = args[:height]
    @width = args[:width]
    @model = args[:model]
    @date_time = args[:date_time]
    @exposure = args[:exposure]
    @f_number = args[:f_number] 
    @latitude = args[:latitude]
    @logitude = args[:logitude]
  end

end

def get_images_with_exif
	images = []
  Dir.entries("img/").each do |img|
  	unless img[-4..-1] != ".jpg"
  	  images << "img/#{img}" if EXIFR::JPEG.new("img/#{img}").exif?
    end
  end
  images
end

image_parser = Parser.new
image_parser

images = get_images_with_exif
image_objects = []
images.each do |image_path| 
  image_objects << Image.new(image_parser.photo_to_exif(image_path))
end

p image_objects

