=begin
1. you are given two arguments for a folders with files;
1.1 if there are other arguments they should be discarded;
2. file names in this folders are in the form First_Last_digits.rb; 
3. find  the students that are only in the first folder and not in the second. A student is in both folders if it there is a file with the same First and Last Name. Digits might be different;
4. Sort the result by Last name DESC;
5. Produce a result in CSV format named result.csv:

	LastName1,FirstName1
	LastName2,FirstName2
	...
	LastNameN,FirstNameN
=end

require 'csv'

folder2_arr = []
checked = []

CSV.open("result.csv", "w") do |csv|
Dir.glob(ARGV[1]+"*").each do |filename|
  name = filename.split("/").last.split("_")
  if(name.size == 3)
    first_name = name[0]
    last_name =  name[1].split(".").first
    folder2_arr << [last_name, first_name]
	checked << last_name + first_name
  end
end

Dir.glob(ARGV[0]+"*").each do |filename|
  name = filename.split("/").last.split("_")
  if(name.size == 3)
    first_name = name[0]
    last_name = name[1].split(".").first
    csv << [last_name, first_name]  if !checked.include? (last_name + first_name) 
  end
end
end


my_csv = CSV.read 'result.csv'
my_csv = my_csv.sort_by { |a,b| [b,a] }
CSV.open("result.csv", "w") do |csv|
  my_csv.each {|element| csv << element}
end




