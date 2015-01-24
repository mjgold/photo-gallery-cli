# Creates a photo gallery from photo files passed through the command line

# Example: ruby gallery.rb photos/bunny1.jpg photos/bunny2.jpg

def get_file_paths(arguments)
  file_paths = []
  arguments.each do |arg|
    file_paths << Dir.pwd + '/' + arg
  end

  file_paths
end

def get_img_tag(filepath)
  "<img src=\"" + filepath + "\">"
end

# Stylesheet hardcoded for now
def get_html(img_tags)
  # joined_img_tags = img_tags.map { |tag| "#{tag}\n" }.join

  html = <<-HTML
  <!DOCTYPE html>
  <html>
  <head>
    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
    <title>My Gallery</title>
  </head>
  <body>
    <h1 id='topheader'>My Gallery</h1>
    <div class="section group">
  HTML

  img_html = add_css_to_img_tags(img_tags)

  html2 = <<-HTML2
    </div>
  </body>
  </html>
  HTML2

  html + img_html + html2
end

def add_css_to_img_tags(img_tags)
  img_html = ''
  img_tags.each_with_index do |tag, i|
    col_num = i % 3 + 1
    img_html += make_div_tag(tag, col_num)
  end

  img_html
end

def make_div_tag(tag, col_num)
  '<div class="col span_' \
  + col_num.to_s \
  + '_of_3">' \
  + tag \
  + '</div>'
end

file_paths = get_file_paths(ARGV)

img_tags = []
file_paths.each do |filepath|
  img_tags << get_img_tag(filepath)
end

html = get_html(img_tags)
File.write('gallery.html', html)

if __FILE__ == 'gallery.rb'

  arguments = ['photos/bunny1.jpg']
  file_paths = get_file_paths(arguments)
  p get_img_tag(file_paths[0]) == \
    "<img src=\"/Users/mark/Dropbox/Code/photo-gallery-cli/photos/bunny1.jpg\">"

  arguments = ['photos/bunny1.jpg', 'photos/bunny2.jpg']
  file_paths = get_file_paths(arguments)
  p get_img_tag(file_paths[0]) == \
    "<img src=\"/Users/mark/Dropbox/Code/photo-gallery-cli/photos/bunny1.jpg\">"
  p get_img_tag(file_paths[1]) == \
    "<img src=\"/Users/mark/Dropbox/Code/photo-gallery-cli/photos/bunny2.jpg\">"

end
