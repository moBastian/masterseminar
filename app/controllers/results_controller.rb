# -*- encoding : utf-8 -*-
class ResultsController < ApplicationController
  before_action :set_measurement
  before_action :set_assessment
  before_action :set_user
  before_action :set_group
  before_action :set_result, only: :update
  before_action :is_allowed

  # GET /results
  # GET /results.json
  #Erhalten aller Ergebnisse + Anzeigen dieser per index.html.erb
  def index
    @results = Result.all
  end

  # GET /results/1
  # GET /results/1.json
  #Anzeigen eines Ergebnises
  def show
  end

  # GET /results/new
  #Erzeugen eines neuen Ergebnis
  def new
    @test = @measurement.assessment.test

    respond_to do |format|
     format.html {@format = "html"}
     format.text {@format = "plain"}
    end

    render 'new', :formats => [:js], content_type: 'text/javascript'
  end

  # GET /results/1/edit
  #Bearbeiten eines Ergebnis
  def edit
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  #Updaten eines Ergebnis
  def update
    results = result_params
    unless results.nil?
      stay = true
      #Update comes from online testing
      if results.is_a?(String)
        parts = results.split("#")
        labels = parts[0].split(",")
        unless @result.nil?
          #Gesendeten Ergebnisstring in die passende Form bringen
          @result.parse_csv(parts[1])
          @result.parse_data(labels[1, labels.length-1], parts[2, parts.length-1]) if parts.length > 2
          render nothing: true
        end
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      results = result_params
      unless results.nil?
        if results.is_a?(String)
          parts = results.split("#")
          @result = @measurement.results.find(parts[0].to_i)
        end
      end
    end

    def set_measurement
      @measurement = Measurement.find(params[:measurement_id])
    end

    def set_assessment
      @assessment = Assessment.find(params[:assessment_id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params[:results]
    end

  #darf der nutzer die Methoden/Funktionen ausführen
  def is_allowed
      #check if user is allowed
      #@result exists only before update => student can only update a result
      unless (!@login_user.nil? && @login_user.hasCapability?("admin")) || (!@login_user.nil? && params.has_key?(:user_id) &&
          (@login_user.id == params[:user_id].to_i)) ||((@login_student.id == @result.student.id) && !@login_student.nil?)
        redirect_to '/mainapp'
      end
    end
end
