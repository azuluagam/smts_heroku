class Concurso
  include Dynamoid::Document
  table :name => :concursos, :key => :id, :read_capacity => 5, :write_capacity => 5
  #mount_uploader :imagen, PictureUploader

  field :nombre
  field :imagen
  field :url
  field :fechaInicio
  field :fechaFin
  field :descripcion

  belongs_to :usuario
  has_many :videos

  #include ActiveModel::Validations
  #validates :usuario_id, presence: true
  #validates :descripcion, presence: true, length: { maximum: 1000 }

  '''
  def initialize(id, nombre, imagen, fechaInicio, fechaFin, descripcion, usuario)
      @id = id
      @nombre = nombre
	  @imagen = imagen
	  @fechaInicio = fechaInicio
	  @fechaFin = fechaFin
	  @descripcion = descripcion
	  @usuario = usuario
   end
   '''
end
