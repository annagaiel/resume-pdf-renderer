class PdfsController < ApplicationController

  def index
    @students = Unirest.get("http://localhost:3001/api/v1/students.json").body
  end

  def show
    @student = Unirest.get("http://localhost:3001/api/v1/students/#{params[:id]}.json").body
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text @student["student"]["first_name"] + " " + @student["student"]["last_name"], size: 33, font: "Helvetica", color: "0000FF", align: :center
      
        pdf.text "Email: " + @student["student"]["email"], align: :center, size: 18, font: "Helvetica"
        pdf.text "Phone Number: " + @student["student"]["phone_number"], align: :center, size: 18, font: "Helvetica"
      
        pdf.text "Linkedin URL:" + @student["student"]["linkedin_url"], align: :right, size: 14, font: "Helvetica"
        pdf.text "Twitter:" + @student["student"]["twitter_handle"], align: :right, size: 14, font: "Helvetica"
        pdf.text "Wordpress:" + @student["student"]["wordpress_url"], align: :right, size: 14, font: "Helvetica"
        pdf.text "Resume URL:" + @student["student"]["resume_url"], align: :right, size: 14, font: "Helvetica"
        pdf.text "Github URL:" + @student["student"]["github_url"], align: :right, size: 14, font: "Helvetica"
        pdf.text "BIO:" + @student["student"]["short_bio"],size: 20, font: "Helvetica", color: "660033", align: :center

        send_data pdf.render, type: "application/pdf", disposition:"inline"
      end
    end
  end
end


# #   def header
# #     image "(http://localhost:3001/api/v1/students/#{params[:id]})", width: 530, height: 150
# #   end
# # end
