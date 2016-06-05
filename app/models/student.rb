class Student
  
  attr_accessor :id, :first_name, :last_name, :email, :phone_number, :short_bio, :linkedin_url, :wordpress_url, :resume_url, :github_url, :photo

  def initialize(hash)
    
    @id = hash["student"]["id"]
    @first_name = hash["student"]["first_name"]
    @last_name = hash["student"]["last_name"]
    @email = hash["student"]["email"]
    @phone_number = hash["student"]["phone_number"]
    @short_bio = hash["student"]["short_bio"]
    @linkedin_url = hash["student"]["linkedin_url"]
    @wordpress_url = hash["student"]["wordpress_url"]
    @resume_url = hash["student"]["resume_url"]
    @github_url = hash["student"]["github_url"]
    @photo = hash["student"]["photo"]
  end

  def self.find(id)
    student_hash = Unirest.get("#{ENV['DOMAIN']}/students/#{id}.json").body
    return Student.new(student_hash)
  end

  def self.all
    student_hashes = Unirest.get("#{ENV['DOMAIN']}/students.json").body
    @students = []
    student_hashes.each do |hash|
      @student << Student.new(hash)
    end
    return @students

  end
end
