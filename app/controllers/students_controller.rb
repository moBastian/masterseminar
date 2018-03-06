# -*- encoding : utf-8 -*-
class StudentsController < ApplicationController
  before_action :set_user
  before_action :set_group
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :is_allowed

  # GET /students
  # GET /students.json
  def index
    respond_to do |format|
      format.js {}
      format.html {}
      @students = Student.where(:group_id => @group.id)
      format.pdf {
        render pdf: "Zugangsdaten der Probandengruppe #{@group.name}",
        template: "students/index.pdf.erb"
      }
      format.text {
        puts(params[:email]=="allInGroup")
        if params.has_key?(:email) && params[:email]=="allInGroup"
          Student.where(:group_id => @group.id).where.not(:email => "").each do |s|
            puts(s.email)
            puts(s.login)
            StudentMailer.notifyAll(s.email,s.login).deliver_later
          end
          head :ok
        else
          render 'index', :formats => [:js], content_type: 'text/javascript'
        end
      }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    if params.has_key?(:email) && params[:email]=="allInGroup"
    else
      @results = @student.getResults
    end
    if params.has_key?(:test)
      @results = {params[:test].to_i => @results[params[:test].to_i]}
    end
    respond_to do |format|
      format.js {}
      format.pdf { 
        render pdf: @student.name, template: "students/show.pdf.erb"
        }
      format.text {
        if params.has_key?(:email)
          emailArray = params[:email].split("/")
          if(emailArray[1]=="true")
            @student.email = emailArray[0]
            @student.save
          end
          session[:extraData][0] = true
          StudentMailer.edited(emailArray[0], @student.login).deliver_later
          head :ok
        end
      }
    end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit

  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new
    if student_params.has_key?(:file)
      begin
        success = true
        Student.import(student_params[:file], @group)
        flash.now[:notice] = "Schülerdaten erfolgreich importiert."
      rescue
        success = false
        flash.now[:notice] = "Fehler beim Importieren der Schülerdaten!"
      end
    else
      @student = @group.students.new(student_params)
      success = @student.save
      unless success
        @student.destroy
        @group.reload
      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to user_group_students_path(@user, @group), notice: flash.now[:notice] }
        format.js {
          @student = Student.new
        }
      else
        format.js { render :new }
        format.html { redirect_to user_group_students_path(@user, @group), notice: flash.now[:notice] }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html{
          render :nothing => true, :status => 200, :content_type => 'text/html'
        }
      else
        format.js { render :edit }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      if params.has_key?(:email) && params[:email]=="allInGroup"
      else
        @student = Student.find(params[:id])
      end
    end


    def set_user
      @user = User.find(params[:user_id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :login, :birthdate, :email, :gender, :specific_needs, :first_accept, :migration, :file, :points , :played_questions,
                                      :achievement =>{:a1 =>[], :a2=>[], :a3=>[], :a4=>[], :a5=>[], :a6=>[], :a7=>[], :a8=>[], :a9=>[], :a10=>[], :a11=>[],
                                                      :a12=>[], :a13=>[], :a14=>[], :a15=>[], :a16=>[], :a17=>[], :a18=>[], :a19=>[], :a20=>[], :a21=>[], :a22=>[],
                                                      :a23=>[], :a24=>[], :a25=>[], :a26=>[], :a27=>[], :a28=>[], :a29=>[], :a30=>[]})
    end

    def is_allowed
      unless !@login_user.nil? && @login_user.hasCapability?("admin") || !@login_user.nil? && (params.has_key?(:user_id) && (@login_user.id == params[:user_id].to_i)) || !@login_student.nil? && @login_student.id = @student.id
        redirect_to '/mainap'
      end
    end
end
