class PdfsController < ApplicationController

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text @student.first_name  
        pdf.text @student.last_name
        pdf.text @student.phone_number
        pdf.text @student.linkedin_url
        pdf.text @student.wordpress_url
        pdf.text @student.resume_url
        pdf.text @student.github_url
        pdf.text @student.short_bio

        send_data pdf.render, type: "application/pdf", disposition:"inline"
      end
    end
  end


end
        
