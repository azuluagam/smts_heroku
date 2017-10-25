class ConcursosController < ApplicationController
  include SesionesHelper
  before_action :correct_user,   only: :destroy

  def show
    concurso = Aws.get_concurso(params[:id], current_user.id)
    puts concurso
    '''
    @concurso = Concurso.find(params[:id])
    @video = @concurso.videos.build  
    @videos = @concurso.videos.paginate(page: params[:page])
    .paginate(:page => params[:page], :per_page => 2)
    .order(created_at: :asc)
    '''
  end

  def create
    @concurso = Concurso.new(concurso_params)
    concurso_id = DateTime.now.to_time.to_i
    nombre  = concurso_params['nombre']
    fecha_inicio = concurso_params['fechaInicio']
    fecha_fin = concurso_params['fechaFin']
    descripcion = concurso_params['descripcion']
    usuario_id = current_user.id

    aws_params = Hash.new
    aws_params[:concurso_id] = concurso_id
    aws_params[:usuario_id] = usuario_id
    aws_params[:custom_fields]    = {
        'nombre'    => nombre,
        'fecha_inicio'   => fecha_inicio,
        'fecha_fin' => fecha_fin,
        'descripcion' => descripcion,
        'imagen' => @concurso.imagen.file.filename
    }
    @concurso.save
    if Aws.save_concurso_to_db(aws_params)
      flash[:success] = "Concurso Creado!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/inicio'
    end
  end

  def destroy
    puts @concurso.id
    '''
    Aws.eliminar_concurso(@concurso.id, current_user.id)
    @concurso.destroy
    flash[:success] = "Concurso Eliminado!"
    redirect_to request.referrer || root_url
    '''
  end

  def edit
    concurso = Aws.get_concurso(params[:id], current_user.id)
    puts concurso
    #@concurso = Concurso.find(params[:id])
  end

  def update #wtf?
    @concurso = Concurso.find(params[:id])
    if @concurso.update_attributes(concurso_params)
      flash[:success] = "Concurso Actualizado"
      redirect_to @concurso
      # Handle a successful update.
    else
      render 'edit'
    end
  end



  private

    def concurso_params
      params.require(:concurso).permit(:nombre, :fechaInicio, :fechaFin, :descripcion, :imagen)
    end

    def correct_user
      @concurso = current_user.concursos.find_by(id: params[:id])
      redirect_to root_url if @concurso.nil?
    end
end
