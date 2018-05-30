# -*- encoding : utf-8 -*-
class GroupsController < ApplicationController
  # Führe den Login- und Accept-check vom user nicht für einen Probanden aus
  before_action :set_user
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :is_allowed

  # GET /groups
  # GET /groups.json
  #anzeigen der indexseite für die Probandengruppe(Standard)
  def index
    @groups = @user.groups
  end

  # GET /groups/1
  # GET /groups/1.json
  #anzeigen der Seite füer eine Probandengruppe (Standard)
  def show
  end

  # GET /groups/new
  #Erzeugen eines neuen Probanden(Standard)
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  #verändern einer Gruppe(Standard)
  def edit
  end

  # POST /groups
  # POST /groups.json
  #Erstellen + Speichenr einer Probandengruppe
  def create
    #erhalten der bezeichnung für die gruppe
    @groups = @user.groups
    newName = @user.id.to_s + group_params[:name]
    #erstellen der gruppe
    @group = @user.groups.build(name:newName, archive:group_params[:archive])
    @group.demo = false
    #führe die Dateien aus je nachdem, ob die gruppe abgespeichert wurde
    respond_to do |format|
      if @group.save
        format.js
      else
        format.js {render :new}
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  #updaten einer Gruppe
  def update
    respond_to do |format|
      #funktioniert update
      if @group.update(group_params)
        format.js
        format.html {
          redirect_to user_groups_path(@user)
        }
        #update fehlgeschlagen
      else
        format.js {
        @group.reload
        render :edit
        }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  #zerstören einer probandengruppe(Standard)
  def destroy
    unless @group.demo
      @group.destroy
    end
    respond_to do |format|
      format.html { redirect_to user_groups_url(@user), notice: 'Probandengruppe wurde gelöscht.' }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :archive)
    end

    #überprüfen ob eine Nutzer die Berechtigungen besitzt die aktionen auszuführen
    def is_allowed
      unless !@login_user.nil? && @login_user.hasCapability?("admin") || !@login_user.nil? && (params.has_key?(:user_id) && (@login_user.id == params[:user_id].to_i))
        redirect_to '/mainapp'
      end
    end
end
