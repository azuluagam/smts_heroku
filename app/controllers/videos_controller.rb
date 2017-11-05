class VideosController < ApplicationController
  include SesionesHelper
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = [] # Video.where(estado: false)
    #.paginate(:page => params[:page], :per_page => 50)
    #.order(created_at: :asc)
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
  end

  # GET /videos/new
  def new
    concursos = []
    items = Aws.get_concursos
    items.each { |item|
      info = item['concurso_info']
     puts info['descripcion']
     puts item['concurso_info']
     puts item['concurso_id']
     puts item
      @concurso
     concurso = Hash.new
     concurso[:nombre] = info['nombre']
     concurso[:fechaInicio] = info['fecha_inicio']
     concurso[:fechaFin] = info['fecha_fin']
     concurso[:descripcion] = info['descripcion']
     concurso[:id] = Integer(item['concurso_id'])
     puts concurso
     @concurso = Concurso.new(concurso)
     concursos.push(@concurso)
    }
    @concursos = concursos
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    puts @video.video_source.file
    respond_to do |format|
      if  @video.save
        uploader = VideoUploader.new
        uploader.store!(@video.video_source.file)
        sqs = Aws::SQS::Client.new(region: 'us-east-2')
        body = video_id.to_s + '-' + concurso_id.to_s + '-' +@video.video_source.file.filename
        sqs.send_message(queue_url: 'https://sqs.us-east-2.amazonaws.com/893543758111/smts-videos-queue', message_body: body)
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:nombre, :apellido, :email, :titulo, :descripcion, :video_source, :concurso_id)
    end
end
