# -*- encoding : utf-8 -*-
class FrontendController < ApplicationController

  skip_before_action :check_login, :check_accept

  before_action :check_student, except: [:welcome, :login]
  before_action :check_accept_student, except: [:welcome, :login, :accept, :logout]

  layout 'plainStudent'

  def welcome
    if params.has_key?(:page)
      render params[:page], :layout => 'bareStudent'
    else
      render 'welcome', layout: 'bareStudent'
    end
  end

  #Check logincode and redirect to next page
  def login
    s = Student.find_by_login(params[:login])
    g = Group.find_by_name(params[:login])
    if s != nil
      @student = s
      session[:student_id] = s.id
      session[:user_id] = nil
      @login_user = nil
      @student.login_times = s.login_times + 1
      @student.save

      redirect_to '/frontend'
    elsif g != nil
      @group = g
      puts("hallo")
      puts(params[:ip])
      puts("du")
      s = Student.prepare_new_student(@group, params[:ip], params[:fingerprint])
      @student = s
      session[:student_id] = s.id
      session[:user_id] = nil
      @login_user = nil
      @student.login_times = s.login_times + 1
      @student.save

      redirect_to '/frontend'
    else
      redirect_to root_url, notice: "Der Code ist falsch! Bitte prüfe genau, ob du alles richtig eingegeben hast."
    end
  end

  #Logout student
  def logout
    if(!session[:student_id].nil?)

      session[:student_id] = nil
      @login_student = nil
    end
    redirect_to root_url
  end

  #get all available measurements
  def index
    @assessments = @student.get_open_assessments
    if @student.group_type == 0 || @student.group_type == 1
      render 'control_and_feedback_group'
    elsif @student.group_type == 2 || @student.group_type == 4
      render 'badges_group'
    else
      render 'ranking_group'
    end
  end


  #start Test
  def start

    @assessment = Assessment.find(params[:id])
    @measurement = @assessment.measurements.build(date: Time.new + 3600, stuId: @student.id)
    @measurement.save
    @measurement.prepare_test(@student)
    @test = @assessment.test
    @result = @student.getCurrentResult(@measurement.id)
    if (@test.student_access) #...ggf mehr Tests
      render "results/tests/#{@test.view_info}", layout: 'empty'
    else
      redirect_to '/schueler'
    end
  end
  def accept
    if(!Student.where(name:params[:username]).blank?&&params[:username]!=""&&params.has_key?(:username)||!Fakename.where(name:params[:username]).blank?&&params[:username]!=""&&params.has_key?(:username))
      @login_student.gender = params[:gender]
      @login_student.age = params[:age]
      @login_student.email = params[:email]
      @login_student.save
      @student = @login_student
      flash.now[:notice] = 'Username bereits vergeben!'
      render "frontend/_secondPage"
    else
      if(params.has_key?(:username))
        @login_student.name = params[:username]
      else
        fakename = Fakename.all
        if fakename.empty?
          @login_student.name = "user" + @login_student.id.to_s
        else
          fakename = fakename.sample
          Fakename.find(fakename.id).delete
          @login_student.name = fakename.name
        end


      end
      @login_student.gender = params[:gender]
      @login_student.age = params[:age]
      @login_student.email = params[:email]
      @login_student.first_accept = DateTime.now
      @login_student.save
      redirect_to '/frontend'
    end
  end

  private

  def check_student
    if session[:student_id].nil?
      redirect_to root_url, notice: "Bitte einloggen!"
    else
      @student = Student.find(session[:student_id])
      @login_student = Student.find(session[:student_id])
      @group = @student.group
      @user =@student.group.user

    end
  end

  def check_accept_student
    if !@login_student.nil? && @login_student.first_accept.nil?
      render 'frontend/accept', layout: 'empty'
    end
  end
end
