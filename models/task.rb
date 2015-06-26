class Task
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String
  property :completed,    Boolean
  property :description,  String
end

puts "Task Table created!"
