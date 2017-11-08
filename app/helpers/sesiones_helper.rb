module SesionesHelper

    # Logs in the given user.
  def log_in(usuario)
    puts usuario.id
    session[:usuario_id] = usuario.id
  end
  
  # Remembers a user in a persistent session.
  def remember(usuario)
    usuario.remember
    cookies.permanent.signed[:usuario_id] = usuario.id
    cookies.permanent[:remember_token] = usuario.remember_token
  end
  

  # Returns true if the given user is the current user.
  def current_user?(usuario)
    usuario == current_user
  end

  # Returns the current logged-in user (if any).
  def current_user
    if session[:usuario_id].to_s.strip.empty?
      @current_user = nil
    else
      @current_user ||= Usuario.find(session[:usuario_id].to_s)
    end    
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end




  def log_out
    session.delete(:usuario_id)
    @current_user = nil
  end
end
