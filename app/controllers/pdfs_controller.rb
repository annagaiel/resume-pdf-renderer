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

        pdf.text @student.first_name, size: 33, font: "Helvetica", color: "0000FF", align: :center   
        pdf.text @student.last_name, size: 33, font: "Helvetica", color: "0000FF", align: :center   
        pdf.text @student.phone_number, align: :center, size: 18, font: "Helvetica"
        pdf.text @student.linkedin_url, align: :right, size: 14, font: "Helvetica"

        pdf.text @student.wordpress_url, align: :right, size: 14, font: "Helvetica"

        pdf.text @student.resume_url, align: :right, size: 14, font: "Helvetica"

        pdf.text @student.github_url, align: :right, size: 14, font: "Helvetica"

        pdf.text @student.short_bio, size: 20, font: "Helvetica", color: "660033", align: :center


        send_data pdf.render, type: "application/pdf", disposition:"inline"
      end
    end
  end
end



