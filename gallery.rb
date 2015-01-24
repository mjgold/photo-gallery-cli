# Creates a photo gallery from photo files passed through the command line

# Example: ruby gallery.rb photos/bunny1.jpg photos/bunny2.jpg

require 'FileUtils'

### METHODS

def file_paths(arguments)
  file_paths = []
  arguments.each do |arg|
    file_paths << File.path(arg)
  end

  file_paths
end

def img_tag(filepath)
  "<img src=\"#{filepath}\">"
end

# Stylesheet hardcoded for now
def full_html(img_tags)
  html_top = <<-HTML_TOP
  <!DOCTYPE html>
  <html>
  <head>
    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
    <title>My Gallery</title>
  </head>
  <body>
    <h1 id='topheader'>My Gallery</h1>
    <div class="section group">
  HTML_TOP

  img_html = add_css_to_img_tags(img_tags)

  html_bottom = <<-HTML_BOTTOM
    </div>
  </body>
  </html>
  HTML_BOTTOM

  html_top + img_html + html_bottom
end

def add_css_to_img_tags(img_tags)
  img_html = ''
  img_tags.each_with_index do |tag, i|
    col_num = i % 3 + 1
    img_html += div_tag(tag, col_num)
  end

  img_html
end

def div_tag(tag, col_num)
  "<div class='col span_#{col_num}_of_3'>#{tag}</div>"
end

def create_dir(dir = 'public', img_dir = 'images')
  new_dir = "#{dir}/#{img_dir}"
  FileUtils.mkdir_p new_dir

  new_dir
end

### MAIN

file_paths = file_paths(ARGV)
new_dir = create_dir # Get user-specified directories later
FileUtils.copy(file_paths, new_dir)

img_tags = []
file_paths.each do |filepath|
  img_tags << img_tag(filepath)
end

html = full_html(img_tags)
File.write('gallery.html', html)

### TESTS

if __FILE__ == $PROGRAM_NAME

  arguments = ['photos/bunny1.jpg']
  file_paths = file_paths(arguments)
  # p img_tag(file_paths[0])
  p img_tag(file_paths[0]) == \
    "<img src=\"photos/bunny1.jpg\">"

  arguments = ['photos/bunny1.jpg', 'photos/bunny2.jpg']
  file_paths = file_paths(arguments)
  p img_tag(file_paths[0]) == \
    "<img src=\"photos/bunny1.jpg\">"
  p img_tag(file_paths[1]) == \
    "<img src=\"photos/bunny2.jpg\">"

end
