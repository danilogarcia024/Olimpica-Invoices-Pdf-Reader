# require 'pdf-reader'

# File.open("example_invoice.pdf", "rb") do |io|
#   reader = PDF::Reader.new(io)
#   reader.pages.each do |page|
#     puts page.fonts
#     puts page.text
#     #puts page.raw_content
#   end
# end

require 'pdf-reader-turtletext'

pdf_filename = 'example_invoice.pdf'
reader = PDF::Reader::Turtletext.new(pdf_filename)
options = { :y_precision => 5 }
reader_with_options = PDF::Reader::Turtletext.new(pdf_filename,options)

textangle = reader.bounding_box do
  page 1
  below /negocio/i
  above 10
  right_of /subtotal/i 
end


text = reader.text_in_region(
  14,   # minimum x (left-most)
  700,  # maximum x (right-most)
  250,  # minimum y (bottom-most)
  400,  # maximum y (top-most)
  1,    # page (default 1)
  false # inclusive of x/y position if true (default false)
)

p text


text_by_exact_match = reader.text_position(/subtotal/i, 1)
p text_by_exact_match

