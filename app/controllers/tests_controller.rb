# -*- encoding : utf-8 -*-
class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  before_action :is_allowed, only: [:edit, :update, :destroy]

  # GET /tests
  #Erhalten aller Test und anzeigen auf der index.html.erb
  def index
    @tests = Test.all
    respond_to do |format|
      format.html {}
    end
  end
 
  # GET /tests/1/edit
  #Bearbeiten der Informationen für einen Test
  def edit
  end

  # GET /tests/1.xml
  #Anzeigen eines Tests
  def show
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  #Zerstören eines Tests
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, notice: 'Test wurde gelöscht.' }
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  #Updaten eines Tests
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.js
      else
        format.js { render :edit }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_test
    @test = Test.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def test_params
    params.require(:test).permit(:name, :info, :shortinfo, :subject, :construct)
  end

  #überprüfen ob eine Nutzer die Berechtigungen besitzt die aktionen auszuführen
  def is_allowed
    unless !@login_user.nil? && @login_user.hasCapability?("test")
      redirect_to '/mainapp'
    end
  end
end
