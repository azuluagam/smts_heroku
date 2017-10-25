class UsuariosController < ApplicationController
  include SesionesHelper
 # before_action :logged_in?, only: [:index, :edit, :update, :destroy]
  before_action :logged_in_usuario, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user,   only:  [:edit, :update]
  before_action :admin_user, only: :destroy
  def show
    @usuario = Usuario.find(params[:id])
    puts 'showAct'
    puts @usuario.id
    concursos = []
    items = Aws.get_concursos_por_usuario(@usuario.id)
    items.each { |item|
        info = item['concurso_info']
        concurso = Hash.new
        concurso[:nombre] = info['nombre']
        concurso[:fechaInicio] = info['fecha_inicio']
        concurso[:fechaFin] = info['fecha_fin']
        concurso[:descripcion] = info['descripcion']
        concurso[:imagen] = info['imagen']
        concurso[:id] = Integer(item['concurso_id'])
        concurso[:usuario_id] = @usuario.id
        puts concurso
        @concurso = Concurso.new(concurso)
        puts @concurso
        concursos.push(@concurso)
    }
    @concursos = concursos
  end

  def index
    #@usuarios = Usuario.all
    @usuarios = Usuario.paginate(page: params[:page])
  end

  def new
    @usuario = Usuario.new 
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
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
    if @usuario.update_attributes(usuario_params)
      flash[:success] = "Perfil Actualizado"
      redirect_to @usuario
      # Handle a successful update.
    else
      render 'edit'
    end
  end
 
  def destroy
    Usuario.find(params[:id]).destroy
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
