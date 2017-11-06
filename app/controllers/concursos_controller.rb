class ConcursosController < ApplicationController
  include SesionesHelper
  before_action :correct_user,   only: :destroy

  def show
    @concurso = Concurso.find(params[:id])
    @video = Video.new
    @videos = Video.all
    @vfinals = Array.new
    @videos.each { |v| s = v.concurso_ids
    s.each do |n|
      if n == @concurso.id
        @vfinals.push(v)
      end
    end
    }
    @videos = @vfinals
    #@videos = @concurso.videos #.paginate(page: params[:page])
    #.paginate(:page => params[:page], :per_page => 2)
    #.order(created_at: :asc)

  end

  def create
    @concurso = Concurso.new(:nombre => concurso_params[:nombre], :imagen => concurso_params[:imagen].original_filename, :url => nil, :fechaInicio => concurso_params[:fechaInicio], :fechaFin => concurso_params[:fechaFin], :descripcion => concurso_params[:descripcion])
    @concurso.usuario = current_user
    puts "fuck3"
    #File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    #  file.write(uploaded_io.read)
    #end
    img = concurso_params[:imagen]
    puts img
    if @concurso.save
      uploader = ImagenUploader.new
      uploader.store!(img)
      flash[:success] = "Concurso Creado!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/inicio'
    end
  end

  def destroy
    @concurso.delete
    flash[:success] = "Concurso Eliminado!"
    redirect_to request.referrer || root_url
  end

  def edit
    @concurso = Concurso.find(params[:id])
  end

  def update #wtf?
    puts "actualizar"
    @concurso = Concurso.find(params[:id])
    if @concurso.update_attributes(:nombre => concurso_params[:nombre], :imagen => concurso_params[:imagen].original_filename, :fechaInicio => concurso_params[:fechaInicio], :fechaFin => concurso_params[:fechaFin], :descripcion => concurso_params[:descripcion])
      uploader = ImagenUploader.new
      uploader.store!(concurso_params[:imagen])
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
      @concurso = Concurso.find(params[:id])
      redirect_to root_url if @concurso.nil?
    end
end
