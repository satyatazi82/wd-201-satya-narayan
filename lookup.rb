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
# ..
#puts(dns_raw)
def parse_dns(raw)
	# raw.delete_at(0)
	hash = {}
	raw.each do |line|
				if line[0] == '#'
			next
		end
				if line.split(',').length() == 1
			next
		end
				record = line.split(',')
		hash[record[1].gsub(/\s+/, "")] = {
			"type" => record[0].gsub(/\s+/, ""),
			"src" => record[1].gsub(/\s+/, ""),
			"dest" => record[2].gsub(/\s+/, "")
		}
	end
	return hash
end
def resolve(dns_records, lookup, domain)
	rec = dns_records[domain]
	lookup.push(rec['dest'])
	#puts(rec)
	if rec["type"] == 'A'
		return lookup
	else
		return resolve(dns_records, lookup, rec["dest"])
	end
end
# ..
# ..
# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
