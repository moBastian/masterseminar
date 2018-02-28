# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_login, except: [:welcome, :login, :signup]
  before_action :check_accept, except: [:welcome, :login, :signup, :accept, :static, :logout]

  def login
    u = User.find_by_email(params[:email])
    if u != nil
      if u.authenticate(params[:password])
        session[:user_id] = u.id
        session[:student_id] = nil
        session[:extraData] = nil
        @login_student = nil
        @login_user = u
        news = News.new_items(u)
        u.last_login = Time.now
        u.save
        if u.complete?
          redirect_to user_groups_path(u), notice: news.empty? ? "Eingeloggt als #{u.email}" : news.join("<br/><br/>")
        else
          redirect_to edit_user_path(u), notice: "Eingeloggt als #{u.email} <br/> Bitte vervollständigen Sie noch Ihre persönlichen Daten, Sie helfen uns damit bei der wissenschaftlichen Begleitung von Levumi!" +  (news.empty? ? "" : "<br/>" + news.join("<br/><br/>"))
        end
      else
        redirect_to '/mainapp', notice: 'Benutzername oder Passwort falsch!'
      end
    else
      redirect_to '/mainapp', notice: 'Benutzername oder Passwort falsch!'
    end
  end

  def logout
    if(!session[:user_id].nil?)
      session[:user_id] = nil
      @login_user = nil
    end
    redirect_to '/mainapp'
  end

  def welcome
    if params.has_key?(:page)
      render params[:page], :layout => 'bare'
    else
      render 'welcome', :layout => 'bare'
    end
  end

  def signup
    password = Digest::SHA1.hexdigest(rand(36**8).to_s(36))[1..6]
    @user = User.new(email: params[:email], name: params[:name], account_type: params[:account_type], password: password, password_confirmation: password)
    if @user.save
      UserMailer.registered(@user.email, @user.name, password).deliver_later
      render 'registered', layout: 'bare'
    else
      error = ''
      unless @user.errors['name'].blank?
        error = "Name darf nicht leer sein!"
      end
      unless @user.errors['email'].blank?
        error = 'E-Mail Adresse ungültig oder bereits registriert!'
      end
      flash['notice'] = error
      render 'signup', layout: 'bare'
    end
  end

  def accept
    @login_user.tcaccept = DateTime.now
    @login_user.save
    redirect_to edit_user_path(@login_user), notice: 'Viel Spaß bei der Benutzung von Quizmos! <br/> Bitte vervollständigen Sie noch Ihre persönlichen Daten, Sie helfen uns damit bei der wissenschaftlichen Begleitung von Quizmos!'
  end

  def static
    render params[:page]
  end

  def export
    unless !@login_user.nil? && @login_user.hasCapability?('export')
      redirect_to '/mainapp'
    end
    @tests = Test.all
    @users = User.all
  end

  private
  #check if user is logged in
  def check_login
    if session[:user_id].nil? && session[:student_id].nil?
      redirect_to '/mainapp', notice: 'Bitte einloggen!'
    elsif !session[:student_id].nil?
      @login_student = Student.find(session[:student_id])
     else
      @login_user = User.find(session[:user_id])
    end
  end

  #check if user accepted the letter of agreement
  def check_accept
    if !@login_user.nil? && @login_user.tcaccept.nil?
      render 'accept'
    end
  end

end
