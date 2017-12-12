# -*- encoding : utf-8 -*-
class FrontendController < ApplicationController

  skip_before_action :check_login, :check_accept

  before_action :check_student, except: [:welcome, :login]

  layout 'plain'

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
      redirect_to '/frontend'
    elsif g != nil
      @group = g
      s = Student.prepare_new_student(@group)
      puts(s.login)
      @student = s
      session[:student_id] = s.id
      session[:user_id] = nil
      @login_user = nil
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
  # #TODO-A: Das sollte dann evtl. Measurements index übernehmen! Ggf. umbennen
  def index
    @assessments = @student.get_open_assessments
    if @student.group_type == 0
      render 'zeros'
    elsif @student.group_type == 1
      render 'ones'
    elsif @student.group_type == 2
      render 'twos'
    elsif @student.group_type == 3
      render 'threes'
    elsif @student.group_type == 4
      render 'fours'
    else
      render 'fives'
    end
  end

  #start Test
  def start

    @assessment = Assessment.find(params[:id])
    @measurement = @assessment.measurements.build(date: Time.new, stuId: @student.id)
    @measurement.save
    @measurement.prepare_test(@student)
    @test = @assessment.test
    @result = @student.getCurrentResult(@measurement.id)
    if (@test.student_access) #...ggf mehr Tests

      render "results/tests/#{@test.view_info}"
    else
      redirect_to '/schueler'
    end
  end

  private

  def check_student
    if session[:student_id].nil?
      redirect_to root_url, notice: "Bitte einloggen!"
    else
      @student = Student.find(session[:student_id])
    end
  end
end
