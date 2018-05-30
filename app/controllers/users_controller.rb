# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :is_allowed, except: [:show]

  # GET /users
  # GET /users.json
  #Erhalten aller Nutzer und anzeigen auf der index.html.erb
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  #Anzeigen eines speziellen Nutzers
    #wenn die Berechtigungen nicht existieren zurück zur Hauptseite
  def show
    respond_to do |format|
      format.html {
        if @login_user.nil? || (!@login_user.hasCapability?("user") && (@user.id != @login_user.id))
          redirect_to '/mainapp'
        end
      }
    end
  end

  # GET /users/new
  #Einen neuen Nutzer anlegen
  def new
    @user = User.new
  end

  # GET /users/1/edit
  #Bearbeiten eines Nutzers
  def edit
  end

  # POST /users
  # POST /users.json
  #Erzeugen eines Nutzers
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Benutzer wurde angelegt.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  #Updaten eines Nutzers
  def update
    respond_to do |format|
        if @user.update(user_params)
          format.html {
            #Zurück auf die Seite des Nutzers, wenn ich es nicht selber bin (nur Admin)
            if @login_user.id != @user.id
              redirect_to users_path
            else
              #Zurück auf meine Seite
              redirect_to @user
            end
          }
        else
          format.html { render :edit }
        end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  #zerstören eines Nutzers (nur Admin)
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Benutzer wurde gelöscht.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :account_type, :state)
    end

  #überprüfen ob eine Nutzer die Berechtigungen besitzt die aktionen auszuführen
  def is_allowed
    unless !@login_user.nil? && @login_user.hasCapability?("user") ||!@login_user.nil? && (params.has_key?(:id) && (@login_user.id == params[:id].to_i))
      redirect_to '/mainapp'
    end
  end

end
