# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# Runs the following command every minute. This will execute convert.unix.sh
every '5 * * * *' do
	require "./"+ File.dirname(__FILE__) + "/environment.rb"
  Video.where(state: false).each do |video|
    path = video.opath
    output = "/vagrant/public/uploads/terminated/#{Time.now.getutc.to_f.to_s.delete('.')}.mp4"
    _command = `ffmpeg -i /vagrant/public/#{path} -f mp4 -vcodec h264 -acodec libfaac #{output} -y`
    video.state = true
    video.ppath = output
    video.save
    ConfMailer.converted_video(video).deliver_later
  end
end
