class StaticPagesController < ApplicationController
  include SesionesHelper
  
  def inicio
    if logged_in?
      @concurso  = Concurso.new(1, "tet", nil, "15/05/2017", "17/05/2017", "hola", 101) #current_user.concursos.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end 
  end

  def nosotros
  end

  def ingresar
  end

  def contacto
  end
end
