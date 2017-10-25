class UsuariosController < ApplicationController
  include SesionesHelper
 # before_action :logged_in?, only: [:index, :edit, :update, :destroy]
  before_action :logged_in_usuario, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user,   only:  [:edit, :update]
  before_action :admin_user, only: :destroy
  def show
    @usuario = Usuario.find(params[:usuario_id])
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

      concursos.push(concurso)
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
    puts usuario_params
    puts "crear usuarios"
    @usuario0 = Usuario.new(:nombre => "cero", :apellido => "cero", :email => "cero", :password_digest => "cero", :admin => false)
    @usuario0.save

    @usuario1 = Usuario.new(:nombre => "uno", :apellido => "uno", :email => "uno", :password_digest => "uno", :admin => true)
    @usuario1.save

    @usuario3 = Usuario.new(:nombre => "tres", :apellido => "tres", :email => "tres", :password_digest => "tres", :admin => false)
    @usuario3.save

    puts "crear concursos"
    @concurso0 = Concurso.new(:nombre => "cero", :imagen => "cero", :url => "cero", :fechaInicio => "cero", :fechaFin => "cero", :descripcion => "cero")
    @concurso0.usuario = @usuario0
    @concurso0.save

    @concurso01 = Concurso.new(:nombre => "cero1", :imagen => "cero1", :url => "cero1", :fechaInicio => "cero1", :fechaFin => "cero1", :descripcion => "cero1")
    @concurso01.usuario = @usuario0
    @concurso01.save

    @concurso1 = Concurso.new(:nombre => "uno", :imagen => "uno", :url => "uno", :fechaInicio => "uno", :fechaFin => "uno", :descripcion => "uno")
    @concurso1.usuario = @usuario1
    @concurso1.save

    @concurso11 = Concurso.new(:nombre => "uno1", :imagen => "uno1", :url => "uno1", :fechaInicio => "uno1", :fechaFin => "uno1", :descripcion => "uno1")
    @concurso11.usuario = @usuario1
    @concurso11.save

    @concurso3 = Concurso.new(:nombre => "tres", :imagen => "tres", :url => "tres", :fechaInicio => "tres", :fechaFin => "tres", :descripcion => "tres")
    @concurso3.usuario = @usuario3
    @concurso3.save

    puts "crear videos"
    @video0 = Video.new(:nombre => "cero", :apellido => "cero", :email => "cero", :titulo => "cero", :descripcion => "cero", :video_source => "cero")
    @video0.concurso = @concurso0
    @video0.save

    @video1 = Video.new(:nombre => "uno", :apellido => "uno", :email => "uno", :titulo => "uno", :descripcion => "uno", :video_source => "uno")
    @video31concurso = @concurso1
    @video1.save

    @video3 = Video.new(:nombre => "tres", :apellido => "tres", :email => "tres", :titulo => "tres", :descripcion => "tres", :video_source => "tres")
    @video3.concurso = @concurso3
    @video3.save

    @video33 = Video.new(:nombre => "tres3", :apellido => "tres3", :email => "tres3", :titulo => "tres3", :descripcion => "tres3", :video_source => "tres3")
    @video33.concurso = @concurso3
    @video33.save

    uId = @usuario0.usuario_id
    cId = @concurso1.concurso_id
    vId = @video3.video

    puts "pedir usuario -------------------------------------------------"
    @usuario = Usuario.find(uId)
    puts @usuario
    puts @usuario.email

    puts "pedir concurso --------------------------------------------------"
    @concurso = Concurso.find(cId)
    puts @concurso
    puts @concurso.created_at

    puts "pedir todos los concursos ------------------------------------"
    @allC = Concurso.all
    puts @allC.length

    puts "pedir video ------------------------------------------------------"
    @video = Video.find(vId)
    puts @video
    puts @video.email

    puts "eliminar video -------------------------------------------"
    @video1.delete

    #Toca hacer update desde otro metodo (usando aws.rb)
    #puts "actualizar video ------------------------------------------"
    #@video33.update({:nombre => "tres333"})

    puts "filtar concursos por u -----------------------------------------"
    puts @usuario1.usuario_id
    @concursos = Concurso.all
    @cfinals = Array.new
    @concursos.each { |c| s = c.usuario_ids
      s.each do |n|
        if n == @usuario1.usuario_id
          @cfinals.push(c)
        end
      end
    }

    puts @cfinals.length
    puts @concursos.length

    create = usuarios
    if @usuario.save
      puts @usuario.usuario_id
      log_in @usuario
      flash[:success] = "Bienvenido a SmartTools!"
      redirect_to action: "show", id: @usuario.usuario_id
      #redirect_to @usuario, id: @usuario.usuario_id
      #redirect_to controller: 'usuarios', action: 'show', id: @usuario.usuario_id
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
