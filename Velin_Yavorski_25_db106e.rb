=begin
1. you are given two arguments for a folders with files;
1.1 if there are other arguments they should be discarded;
2. Find all the files from both folders that are not in the format FirsrName_LastName_digit.rb. If there are duplicates the file must be written only once. If two files are of the same lenght those files should be sorted in ASC order;
3. Calculate the length of their names (including extensions).;
4. Sort the result by length DESC;
5. Produce a result in CSV format named result.csv:

			File1.extension,3
			File2.extension,4
			...
			FileN.extension,3

=end

require 'csv'

cf = []

CSV.open("result.csv", "w") do |csv_array|
  Dir.glob(ARGV[0]+"*").each do |filename|
    name = filename.split("/").last.split("_")
	name_r = filename.split("/").last
	num = name_r.length
    if(name != 3)
	  csv_array << [name_r, name_r.length]
	  cf << name_r + num.to_s
	end
  end
  
  Dir.glob(ARGV[1]+"*").each do |filename|
    name = filename.split("/").last.split("_")
	name_r = filename.split("/").last
	num = name_r.length.to_s
	if(name != 3)
	  if !cf.include?(name_r + num)
	    csv_array << [name_r, name_r.length] 
	  end
	end
  end
end

my_csv = CSV.read 'result.csv'

my_csv = my_csv.sort_by {|a, b| [-b.to_i, a]}
CSV.open("result.csv", "w") do |csv_arr|
  my_csv.each {|element| csv_arr << element}
end