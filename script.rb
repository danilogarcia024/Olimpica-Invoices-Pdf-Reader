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



#regex_1 = /\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+\.-\s+[\w\s\/]+)\s+/

regex_1 = /\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+\.-\s+[a-zA-Z0-9\/\.]+(?:\s[a-zA-Z0-9\/\.]+)*)\s+/
regexp_nombre_producto = /(\d+)\.-\s+([a-zA-Z0-9\/\.]+(?:\s[a-zA-Z0-9\/\.]+)*)/
regexp_to_inspect_before_line = /\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+\.-\s+[a-zA-Z0-9\/]+(?:\s[a-zA-Z0-9\/]+)*)\s+([\d]+\.\d{2})/
# regex_2 = /\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+\.-\s+\w+)\s+([\d]+\.\d{2})\s+\w+\s+([\d,]+\.\d{2})\s+([\d,]+\.\d{2})\s+([\d,]+\.\d{2})/

# Process lines to extract specific information, e.g., dates, transactions, amounts 
counters = []
lines.each_with_index do |line, index|
  # Example: Print each line (customize this to extract relevant data)
  #puts line if regex_1.match?(line)# || regex_2.match(line)
  #puts line
  if match = regex_1.match(line)
    codigo_negocio = match[1]
    codigo_ean = match[2]
    codigo_producto = match[3]
    nombre_producto = match[4]
    # cantidad = match[5]
    # cajas_und = match[6]
    match_nombre_producto_formatted = regexp_nombre_producto.match(nombre_producto)
    if match_nombre_producto_formatted
      counters.push(match_nombre_producto_formatted[1].to_i)
      nombre_producto_formatted = match_nombre_producto_formatted[2].strip
      puts [codigo_negocio, codigo_ean, codigo_producto, nombre_producto_formatted].join(',')
    else
      puts line
    end
    unless match_2 = regexp_to_inspect_before_line.match(line)
      puts lines[index]
    end
  end
  
end
puts counters.sort

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

