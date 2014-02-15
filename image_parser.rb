require 'exifr'
require 'sqlite3'

class Parser
  
  def photo_to_exif(file_path)
  	exif = EXIFR::JPEG.new(file_path).exif
  	gps = EXIFR::JPEG.new(file_path).gps
  	{exif: exif, gps: gps}
	end
end

class Image
  attr_reader :exif, :gps
  attr_accessor :id

  def initialize(args)
  	@id = get_id
  	@exif = args[:exif]
  	@gps = args[:gps]
  end

  def store_in_database
  	db = SQLite3::Database.new("database.db")
  	make = db.execute("SELECT make FROM image")
    make << self.exif.make
  end

  def get_id
    db = SQLite3::Database.new("database.db")
    
    #make = self
    

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

image_objects.each {|image| image.store_in_database}

db = SQLite3::Database.new("database.db")
p db.execute("SELECT * FROM image")

