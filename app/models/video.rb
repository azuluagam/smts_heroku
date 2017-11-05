class Video
  include Dynamoid::Document
  table :name => :videos, :key => :id, :read_capacity => 5, :write_capacity => 5
  #mount_uploader :video_source, VideoUploader # Tells rails to use this uploader for this model.

  field :nombre
  field :apellido
  field :email
  field :titulo
  field :descripcion
  field :video_source
  field :estado, :boolean, {default: false}

  belongs_to :concurso
  #after_create :run_workers
  #include ActiveModel::Validations
  #validates :nombre, presence: true
  #validates :apellido, presence: true
  #validates :email, presence: true
  #validates :titulo, presence: true
  #validates :descripcion, presence: true
  #validates :convirtiendo, :presence => false
  #validates :estado, :presence => false
  #validates :concurso_id, :presence => true

  private

  def run_workers
    Mp4VideoConverter.perform_async(self.id)
  end
end
