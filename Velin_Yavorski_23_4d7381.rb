=begin
Develop a program named FirstName_LastName_ClassNumber_4d7381.rb

1. you are given two arguments for a folders with files;
1.1 if there are other arguments they should be discarded;
2. Find all the files from both folders that have exactly 7 digits from 0 to 9 in their names excluding extension. If there are duplicates the file must be written only once.;
3. Calculate the length of their names (including extensions) divided by 2 rounded to the smalles number;
4. Sort the result by File name DESC;
5. Produce a result in CSV format named result.csv:

			File1.extension,3
			File2.extension,4
			...
			FileN.extension,3
=end

require 'csv'

checked = []

CSV.open("result.csv", "w") do |csv|
  Dir.glob(ARGV[0]+"*").each do |filename|
    name_no_ext = filename.split("/").last.split(".").first
	name_yes_ext = filename.split("/").last
	num_in_file = name_no_ext.scan(/[0123456789]/).count
	if num_in_file == 7
	  name_length = (name_yes_ext.length/2).floor
	  csv << [name_yes_ext, name_length]
	  checked << name_yes_ext
	end
  end
  
  Dir.glob(ARGV[1]+"*").each do |filename|
    name = filename.split("/").last.split(".").first
	name_no_ext = filename.split("/").last.split(".").first
	name_yes_ext = filename.split("/").last
	num_in_file = name_no_ext.scan(/[0123456789]/).count
	if (num_in_file == 7 && !checked.include?(name_yes_ext))
	  name_length = (name_yes_ext.length/2).floor
	  csv << [name_yes_ext, name_length]
	end
  end
end

my_csv = CSV.read 'result.csv'

my_csv = my_csv.sort_by {|a| a}.reverse
CSV.open("result.csv", "w") do |csv|
  my_csv.each {|element| csv << element}
end




