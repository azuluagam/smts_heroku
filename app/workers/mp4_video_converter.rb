class Mp4VideoConverter
  include Sidekiq::Worker

  def perform(video_id)
    video = Video.find(video_id)
    path = video.video_source
    output = "/vagrant/public/uploads/terminated/#{Time.now.getutc.to_f.to_s.delete('.')}.mp4"
    _command = `ffmpeg -i /vagrant/public/#{path} -f mp4 -vcodec h264 -acodec libfaac #{output} -y`
    video.estado = true
    video.video_out = output
    video.save
    ConfMailer.converted_video(video).deliver_later
  end

end
