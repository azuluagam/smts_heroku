class SesionesController < ApplicationController
  include SesionesHelper
  def new
  end

  def create
    puts params[:session][:email].downcase
    usuario = Usuario.where(:email => params[:session][:email].downcase).all
    puts usuario[0].id
    puts usuario[0]
    #Usuario.find_by(email: params[:session][:email].downcase)
    if usuario[0] #&& usuario[0].authenticate(params[:session][:password])
      log_in usuario[0]
      #params[:session][:remember_me] == '1' ? remember(usuario) : forget(usuario)
      redirect_back_or usuario[0]
      #redirect_to usuario[0]
      #redirect_to controller: 'usuarios', action: 'show', id: usuario[0].usuario_id
      # Log the user in and redirect to the user's show page.
    else
       flash.now[:danger] = 'Email o contraseña incorrecta'
       render 'new'
    end
  end


  def destroy
    log_out
    redirect_to ingresar_path
  end
end
