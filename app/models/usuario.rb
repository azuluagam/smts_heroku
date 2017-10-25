class Usuario
  include Dynamoid::Document
  table :name => :usuarios, :key => :usuario_id, :read_capacity => 5, :write_capacity => 5

  field :nombre
  field :apellido
  field :email
  field :password_digest
  field :admin, :boolean

  has_many :concursos

  #before_save { self.email = email.downcase }
  #validates :nombre, presence: true, length: { maximum: 50 }
  #validates :apellido, presence: true, length: { maximum: 50 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  #has_secure_password
  #validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

 
  def feed
    items = Aws.get_concursos_por_usuario(id)
    items.each { |item|
        info = item['concurso_info']
        concurso = Hash.new
        concurso[:nombre] = info['nombre']
        concurso[:fechaInicio] = info['fecha_inicio']
        concurso[:fechaFin] = info['fecha_fin']
        concurso[:descripcion] = info['descripcion']
        concurso[:imagen] = info['imagen']
        concurso[:id] = Integer(item['concurso_id'])
        concurso[:usuario_id] = id
        puts concurso
        concurso = Concurso.build(concurso[:id], concurso[:nombre], concurso[:imagen], concurso[:fechaInicio], concurso[:fechaFin], concurso[:descripcion], concurso[:usuario_id])
        concursos.push(concurso)
    }
    @concursos = concursos
    #Concurso.where("usuario_id = ?", id)
  end

  def Usuario.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
