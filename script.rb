#require 'pdf-reader-turtletext'
require 'pdf-reader'

pdf_filename = 'example_invoice_2.pdf'

io     = open(pdf_filename)
reader = PDF::Reader.new(io)
p reader.page_count

# Extract text from each page
extracted_text = ""
reader.pages.each do |page|
  extracted_text += page.text
end

# Optionally, split the text into lines for further processing
lines = extracted_text.split("\n")

regex_1 = regex = /\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+\.-\s+[\w\s]+)\s+([\d,]+\.\d{2})/
# regex_2 = /\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+\.-\s+\w+)\s+([\d]+\.\d{2})\s+\w+\s+([\d,]+\.\d{2})\s+([\d,]+\.\d{2})\s+([\d,]+\.\d{2})/

# Process lines to extract specific information, e.g., dates, transactions, amounts 
lines.each_with_index do |line, index|
  # Example: Print each line (customize this to extract relevant data)
  puts line if regex_1.match?(line)# || regekpjk'908j.60-y;64-5tg0p0b;ph-hg;-3-x_2.match(line)
  #puts line
end

# reader = PDF::Reader::Turtletext.new(pdf_filename)
# options = { :y_precision => 5 }
# reader_with_options = PDF::Reader::Turtletext.new(pdf_filename,options)

# textangle = reader.bounding_box do
#   page 1
#   below /negocio/i
#   above 10
#   right_of /subtotal/i 
# end


# text = reader.text_in_region(
#   14,   # minimum x (left-most)
#   800,  # maximum x (right-most)
#   250,  # minimum y (bottom-most)
#   400,  # maximum y (top-most)
#   1,    # page (default 1)
#   false # inclusive of x/y position if true (default false)
# )

# p text


# text_by_exact_match = reader.text_position(/valor total/i, 1)
# p text_by_exact_match

