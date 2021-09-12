def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines

dns_raw = File.readlines("zone")
# dns_raw.split(',')

def parse_dns(string)
  data = []
  dns_raw.each do |line|
    ar = line.split(',')
  
    data.push({
      'type': ar[0],
      'src': ar[1],
      'dest': ar[2]
    })
    #do something with line
  end
  return data
end

def resolve(rec, lookup, domain)
  dns_records[:type]
end
# ..
# ..
# FILL YOUR CODE HERE
# ..
# ..

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
