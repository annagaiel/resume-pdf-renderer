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
        pdf.text @student["student"]["first_name"] + " " + @student["student"]["last_name"]
      
        pdf.text "Email:" + @student["student"]["email"]
        pdf.text "Phone Number:" + @student["student"]["phone_number"]
        pdf.text "Linkedin URL:" + @student["student"]["linkedin_url"]
        pdf.text "Twitter:" + @student["student"]["twitter_handle"]
        pdf.text "Wordpress:" + @student["student"]["wordpress_url"]
        pdf.text "Resume URL:" + @student["student"]["resume_url"]
        pdf.text "Github URL:" + @student["student"]["github_url"]
        pdf.text "BIO:" + @student["student"]["short_bio"]

        send_data pdf.render, type: "application/pdf", disposition:"inline"
      end
    end
  end

  require "prawn"

Prawn::Document.generate("http://localhost:3001/api/v1/students/#{params[:id]}.pdf") do
 
  pdf.text @student["student"]["first_name"] + " " + @student["student"]["last_name"], size: 16, font: "Helvetica", color: "0000FF", align: :center
  pdf.text "Phone Number:" + @student["student"]["phone_number"], align: :center

  font_size 12
  font "Courier" do
    pdf.text "Email:" + @student["student"]["email"]
    pdf.text "Linkedin URL:" + @student["student"]["linkedin_url"]
    pdf.text "Twitter:" + @student["student"]["twitter_handle"]
    pdf.text "Wordpress:" + @student["student"]["wordpress_url"]
    pdf.text "Resume URL:" + @student["student"]["resume_url"]
    pdf.text "Github URL:" + @student["student"]["github_url"]
  end
    
    pdf.text "BIO:" + @student["student"]["short_bio"], size: 16, font: "Helvetica", color: "660033", align: :center
  end
end

#   def header
#     image "(http://localhost:3001/api/v1/students/#{params[:id]})", width: 530, height: 150
#   end
# end
