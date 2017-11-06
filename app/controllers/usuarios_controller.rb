class UsuariosController < ApplicationController
  include SesionesHelper
 # before_action :logged_in?, only: [:index, :edit, :update, :destroy]
  before_action :logged_in_usuario, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user,   only:  [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @usuario = Usuario.find(params[:usuario_id].to_s)
    @concursos = Concurso.all
    @cfinals = Array.new
    puts @usuario
    @concursos.each { |c| s = c.usuario_ids
      s.each do |n|
        if n == @usuario.id
          @cfinals.push(c)
        end
      end
    }    
    @concursos = @cfinals
  end

  def index
    @usuarios = Usuario.all
  end

  def new
    @usuario = Usuario.new 
  end

  def create
    @usuario = Usuario.new(:nombre => usuario_params[:nombre], :apellido => usuario_params[:apellido], :email => usuario_params[:email], :password_digest => usuario_params[:password], :admin => false)
    if @usuario.save
      puts @usuario.id
      log_in @usuario
      flash[:success] = "Bienvenido a SmartTools!"
      redirect_to @usuario
    else
      render 'new'
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(:nombre => usuario_params[:nombre], :apellido => usuario_params[:apellido], :email => usuario_params[:email], :password_digest => usuario_params[:password])
      flash[:success] = "Perfil Actualizado"
      redirect_to @usuario
      # Handle a successful update.
    else
      render 'edit'
    end
  end
 
  def destroy
    Usuario.find(params[:id]).delete
    flash[:success] = "Usuario Eliminado"
    redirect_to usuarios_url
  end


  private

  def usuario_params
      params.require(:usuario).permit(:nombre, :apellido, :email, :password, :password_confirmation)
  end

  # Before filters
    def logged_in_usuario
      unless logged_in?
        store_location
        flash[:danger] = "Por favor ingrese a la aplicación."
        redirect_to ingreso_url
      end
    end


  # Confirms the correct user.
  def correct_user
      @usuario = Usuario.find(params[:id])
      redirect_to(root_url) unless current_user?(@usuario)
  end

    # Confirms an admin user.
  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end



end
