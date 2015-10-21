=begin
1. you are given an argument for a folder with files;
1.1 if there are other arguments they should be discarded
2. some file names in this folder are in the form First_Last_digits.rb. But there are also other files; 
3. find all the students that have 10 symbols in their second name;
4. Sort the result by Last Name ASC.
5. Produce a result in CSV format named result.csv:

		FirstName1,LastName1
		FirstName2,LastName2
		...
		FirstNameN,LastNameN
=end

require 'csv'

CSV.open("result.csv", "w") do |csv_array|
  Dir.glob(ARGV[0]+"*").each do |filename|
    name = filename.split("/").last.split("_")
    if(name.size == 3)
      first_name = name[0]
	  second_name = name[1]
	  csv_array << [first_name, second_name] if second_name.length == 10
    end
  end
end

my_csv = CSV.read 'result.csv'

my_csv = my_csv.sort_by {|c| c[1]}
CSV.open("result.csv", "w") do |csv_array|
  my_csv.each {|element| csv_array << element}
end