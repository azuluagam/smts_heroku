json.extract! video, :id, :nombre, :apellido, :email, :titulo, :descripcion, :video_source, :video_out, :estado, :convirtiendo, :created_at, :updated_at
json.url video_url(video, format: :json)
