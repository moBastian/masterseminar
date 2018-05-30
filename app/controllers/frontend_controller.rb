# -*- encoding : utf-8 -*-
class FrontendController < ApplicationController
# Führe den Login- und Accept-check vom user nicht für einen Probanden aus
  skip_before_action :check_login, :check_accept

  #Führe den Login- und Akzeptanzcheck für die Probanden aus
  before_action :check_student, except: [:welcome, :login]
  before_action :check_accept_student, except: [:welcome, :login, :accept, :logout]

  layout 'plainStudent'

  #laden der Startseite für Probanden
  def welcome
    if params.has_key?(:page)
      render params[:page], :layout => 'bareStudent'
    else
      render 'welcome', layout: 'bareStudent'
    end
  end

  #Login eines Probanden
  def login
    #Suchen des Probanden oder seiner Gruppe anhand des eingegebenen Codes
    s = Student.find_by_login(params[:login])
    g = Group.find_by_name(params[:login])
    #Wenn der Proband gefunden wurde
    if s != nil
      #belegen der Variablen, beschreiben des Seessionhash, hochzählen seiner Loginvariablen, weiterleiten zur Frontendseite
      if s.group.name=="1quiz"||s.group.name=="1Test"
        redirect_to root_url, notice: "Die Studie wurde beendet. Hiermit bedanken wir uns nochmal herzlich für deine Teilnahme :)"
        return
      end
      @student = s
      session[:student_id] = s.id
      session[:user_id] = nil
      @login_user = nil
      @student.login_times = s.login_times + 1
      @student.save
      redirect_to '/frontend'
    #Wenn die Gruppe gefunden wurde
    elsif g != nil
      if g.name=="1quiz"||g.name=="1Test"
        redirect_to root_url, notice: "Die Studie wurde beendet. Wir wollen uns trotzdem herzlich für dein Interesse bedanken :)"
        return
      end
      #belegen der Variablen, Erstellen des Probanden und initialisieren (übergeben der Ip und des Browserhash, da beides clientseitig), Login von 0 auf 1 zählen,
      #weiterleiten zur Frontendseite
      @group = g
      puts(params[:ip])
      s = Student.prepare_new_student(@group, params[:ip], params[:fingerprint])
      @student = s
      session[:student_id] = s.id
      session[:user_id] = nil
      @login_user = nil
      @student.login_times = s.login_times + 1
      @student.save
      redirect_to '/frontend'
    #Beides wurde nicht gefunden (existiert also nicht/Code falsch)
    else
      redirect_to root_url, notice: "Der Code ist falsch! Bitte prüfe genau, ob du alles richtig eingegeben hast."
    end
  end

  #Logout des Probaden
  def logout
    if(!session[:student_id].nil?)
      #leeren der Seesionvariablen und der instanzvariablen
      session[:student_id] = nil
      @login_student = nil
    end
    redirect_to root_url
  end

  #Rendern der unterschiedlichen Seiten je nach Gruppe
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


  #starten eines Testablaufes
  def start
    #belgen der nötigen Instanzvariablen und erzeugen eines Messzeitpunktes
    @assessment = Assessment.find(params[:id])
    @measurement = @assessment.measurements.build(date: Time.new + 3600, stuId: @student.id)
    @measurement.save
    @measurement.prepare_test(@student)
    @test = @assessment.test
    @result = @student.getCurrentResult(@measurement.id)
    #laden der Seite für einen Testablauf
    render "results/tests/Generisch", layout: 'empty'
  end

  #Einverständniserklärung der Probanden laden/abfragen
  def accept
    #Spezeille abfragen. Relevanz:Rankinggruppe
    #Username vergeben
    if(!Student.where(name:params[:username]).blank?&&params[:username]!=""&&params.has_key?(:username)||!Fakename.where(name:params[:username]).blank?&&params[:username]!=""&&params.has_key?(:username))
      #Daten vom Steckblatt beim Probanden abspeichern
      @login_student.gender = params[:gender]
      @login_student.age = params[:age]
      @login_student.email = params[:email]
      @login_student.save
      @student = @login_student
      #neuladen der seite und Fehler zeigen
      flash.now[:notice] = 'Username bereits vergeben!'
      render "frontend/_secondPage"
    else
      #username ist ok (bei allen außer Ranking immer leer)
      if(params.has_key?(:username))
        #speichern des selber angegebenen usernamen
        @login_student.name = params[:username]
      else
        #auswürfeln eines fakenamen, wenn keine mehr vorhanden:
        #zurückgreifen auf die Kombination aus user+ ID des Probanden
        #->Passiert aktuell ab 700 Probanden
        fakename = Fakename.all
        if fakename.empty?
          @login_student.name = "user" + @login_student.id.to_s
        else
          fakename = fakename.sample
          Fakename.find(fakename.id).delete
          @login_student.name = fakename.name
        end


      end
      #SPeichern der angegebenen Daten vom Steckblatt
      @login_student.gender = params[:gender]
      @login_student.age = params[:age]
      @login_student.email = params[:email]
      @login_student.first_accept = DateTime.now
      @login_student.save
      #laden der Frontendseite(Übersichtsseite)
      redirect_to '/frontend'
    end
  end

  private
  #Überprüfen, ob eine Proband angemeldet ist und ggf. belegen von isntanzvariablen
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

  #überprüfen, ob die Einverständniserklärung akzeptiert wurde
  def check_accept_student
    if !@login_student.nil? && @login_student.first_accept.nil?
      render 'frontend/accept', layout: 'empty'
    end
  end
end
