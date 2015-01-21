
# user enters ruby gallery.rb <photo1 path> <photo2 path> <etc.>
# create an HTML page 
#   create HTML header
#   create HTML table
#   for each photo, insert <img tags>
#   create HTML footer

def get_file_paths(arguments)
	file_paths = Array.new
	arguments.each do |arg|
		file_paths << Dir.pwd + "/" + arg
	end

	file_paths
end

def get_img_tag(filepath)
	img_tag = "<img src=\"" + filepath + "\">"
end

def get_HTML(img_tags) 

  joined_img_tags = img_tags.map { |tag| "#{tag}\n"}.join

	html1 = <<-HTML_1
	<!DOCTYPE html>
	<html>
	<head>
		<title>My Gallery</title>
	</head>
	<body>
		<h1>My Gallery</h1>
		#{joined_img_tags}
  HTML_1


  html2 = <<-HTML_2
	</body>
	</html>
	HTML_2

	html = html1 + joined_img_tags + html2
	puts html
end

file_paths = get_file_paths(ARGV)

img_tags = Array.new
file_paths.each do |filepath|
	img_tags << get_img_tag(filepath)
end

html = get_HTML(img_tags)
p html

if __FILE__ == $0

	arguments = ["photos/bunny1.jpg"]
	file_paths = get_file_paths(arguments)	
	
	arguments = ["photos/bunny1.jpg", "photos/bunny2.jpg"]
	file_paths = get_file_paths(arguments)	
	p get_img_tag(file_paths[0]) == "<img src=\"/Users/mark/Dropbox/Code/photo-gallery-cli/photos/bunny1.jpg\">"
	p get_img_tag(file_paths[1]) == "<img src=\"/Users/mark/Dropbox/Code/photo-gallery-cli/photos/bunny2.jpg\">"
	
end
