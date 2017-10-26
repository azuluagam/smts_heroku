class StaticPagesController < ApplicationController
  require 'will_paginate/array'
  include SesionesHelper
  
  def inicio
    if logged_in?
      @concursos = Concurso.all
      @cfinals = Array.new
      @concursos.each { |c| s = c.usuario_ids
        s.each do |n|
          if n == current_user.usuario_id
            @cfinals.push(c)
          end
        end
      }    
      @concursos = @cfinals
      current_user.concursos = @concursos
      @concurso  = @concursos #current_user.concursos.build
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
