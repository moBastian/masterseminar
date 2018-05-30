# -*- encoding : utf-8 -*-
class AssessmentsController < ApplicationController
  #führe die Methden/Funktionen immer aus bevor eine andere Methode/Funktion ausgeführt wird
  before_action :set_assessment, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_group
  before_action :is_allowed

  # GET /assessments
  # GET /assessments.json
  #Laden der Indexseite der assessments(Standardfunktion)
  def index
    @assessments = Assessment.all
  end

  # GET /assessments/1
  # GET /assessments/1.json
  #laden der showseite für ein assessment
  def show
    respond_to do |format|
      format.html
      format.js
      #Erzeugen eines PDfs
      format.pdf do 
        render pdf: @group.name + "-" + @assessment.test.name, template: "assessments/show.pdf.erb", orientation: "landscape"
      end
    end
  end

  # GET /assessments/new
  #laden der new-Seite für assessements
  def new
    @assessment = Assessment.new
    existing = @group.assessments.map{|x| x.test}
    @tests = Test.all.order(:subject, :construct, :name) -existing
  end

  # GET /assessments/1/edit
  #Laden der editseite
  def edit
  end

  # POST /assessments
  # POST /assessments.json
  #Erzeugen eines Assessements
  def create
    @assessment = nil?
    unless params[:test].nil?
      test = params[:test].to_i
      if Test.find(test)
        #Verknüpfung schaffen Assesment/Test
        @assessment = @group.assessments.build(:test_id => test)
        @assessment.save
      end
    end
    @assessments = Assessment.all
    render :index
  end

  # PATCH/PUT /assessments/1
  # PATCH/PUT /assessments/1.json
  #assessment updaten(Standardfunktion)
  def update
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  #assessment zerstören(Standardfunktion)
  def destroy
    @assessment.destroy
    respond_to do |format|
      format.html { redirect_to user_group_path(@user, @group) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assessment_params
      params[:assessment]
    end

    #darf der nutzer die Methoden/Funktionen ausführen
    def is_allowed
      unless !@login_user.nil? && @login_user.hasCapability?("admin") || !@login_user.nil? && (params.has_key?(:user_id) && (@login_user.id == params[:user_id].to_i))
        redirect_to '/mainapp'
      end
    end
end
