class Usuario
  include Dynamoid::Document
  table :name => :usuarios, :key => :id, :read_capacity => 5, :write_capacity => 5

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
    @concursos = Concurso.all
    @cfinals = Array.new
    @concursos.each { |c| s = c.usuario_ids
      s.each do |n|
        if n == id
          @cfinals.push(c)
        end
      end
    }    
    @concursos = @cfinals
    #Concurso.where("usuario_id = ?", id)
  end

  def Usuario.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
