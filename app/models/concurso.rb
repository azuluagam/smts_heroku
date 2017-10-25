class Concurso < ApplicationRecord
  #belongs_to :usuario
  #has_many :videos, dependent: :destroy 
  #mount_uploader :imagen, PictureUploader
  include ActiveModel::Validations
  validates :usuario_id, presence: true
  validates :descripcion, presence: true, length: { maximum: 1000 }

  def initialize(id, nombre, imagen, fechaInicio, fechaFin, descripcion, usuario)
      @id = id
      @nombre = nombre
	  @imagen = imagen
	  @fechaInicio = fechaInicio
	  @fechaFin = fechaFin
	  @descripcion = descripcion
	  @usuario = usuario
   end
   
end
