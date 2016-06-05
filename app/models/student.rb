class Student
  
  attr_accessor :id, :first_name, :last_name, :email, :phone_number, :short_bio, :linkedin_url, :wordpress_url, :resume_url, :github_url, :photo

  def initialize(hash)
    
    @id = hash.body["student"]["id"]
    @first_name = hash.body["student"]["first_name"]
    @last_name = hash.body["student"]["last_name"]
    @email = hash.body["student"]["email"]
    @phone_number = hash.body["student"]["phone_number"]
    @short_bio = hash.body["student"]["short_bio"]
    @linkedin_url = hash.body["student"]["linkedin_url"]
    @wordpress_url = hash.body["student"]["wordpress_url"]
    @resume_url = hash.body["student"]["resume_url"]
    @github_url = hash.body["student"]["github_url"]
    @photo = hash.body["student"]["photo"]
  end

  def self.find(id)
    student_hash = Unirest.get("#{ENV['DOMAIN']}/students/#{id}.json")
    return Student.new(student_hash)
  end

  def self.all
    student_hashes = Unirest.get("#{ENV['DOMAIN']}/students.json")
    @students = []
    student_hashes.each do |hash|
      @student << Student.new(hash)
    end
    return @students

  end
end
