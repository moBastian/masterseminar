# -*- encoding : utf-8 -*-
class MeasurementsController < ApplicationController
  #Führe diese methoden vor jeder aktion aus
      #führe diese methode nur vor show, edit, updat eund destroy aus
  before_action :set_measurement, only: [:show, :edit, :update, :destroy]
  before_action :set_assessment
  before_action :set_user
  before_action :set_group
  before_action :is_allowed

  # GET /measurements
  # GET /measurements.json
  #Erhalten aller Messzeitpunkte + laden der Indexseite(Standard)
  def index
    @measurements = Measurement.all
  end

  # GET /measurements/1
  # GET /measurements/1.json
  #Anzeigen eines Messzeitpunktes(Standard)
  def show
  end

  # GET /measurements/new
  #Erzeugen eines Messzeitpunktes(Standard)
  def new
    @measurement = @assessment.measurements.new
  end

  # GET /measurements/1/edit
  #Editieren eines Messzeitpunktes(Standard)
  def edit
  end

  # POST /measurements
  # POST /measurements.json
  #Erzeugen eines neuen Messzeitpunktes
  def create
    @measurement = @assessment.measurements.new(measurement_params)

    respond_to do |format|
      if @measurement.save
        format.js
      else
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /measurements/1
  # PATCH/PUT /measurements/1.json
  #Updaten eines Messzeitpunktes
  def update
    respond_to do |format|
      if @measurement.update(measurement_params)
        format.js { render :index }
      else
        format.js { render :edit }
      end
    end
  end

  # DELETE /measurements/1
  # DELETE /measurements/1.json
  #Zerstören eines Messzeitpunktes
  def destroy
    @measurement.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measurement
      @measurement = Measurement.find(params[:id])
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
    def measurement_params
      params.require(:measurement).permit(:date)
    end

  #darf der nutzer die Methoden/Funktionen ausführen
    def is_allowed
      unless !@login_user.nil? && @login_user.hasCapability?("admin") || !@login_user.nil? && (params.has_key?(:user_id) && (@login_user.id == params[:user_id].to_i))
        redirect_to '/mainapp'
      end
    end
end
