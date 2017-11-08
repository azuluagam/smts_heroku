class ConfMailer < ApplicationMailer
  default from: 'smarttoolsg5@gmail.com'

  def converted_video(video)
  	@video = video
  	mail(to: @video.email, subject: 'Video convertido')
  end
end
