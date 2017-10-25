module Aws
  require 'date'
  # An init method to be used for initialisation when the rails application start
  def self.init
    @@dynamo_table = false
    @@dynamo_db = false
    @@aws_access = Rails.application.config.aws_access
    unless @@aws_access.nil?
      @@dynamo_db = Aws::DynamoDB::Client.new(
          access_key_id: @@aws_access[:access_key_id],
          secret_access_key: @@aws_access[:secret_access_key],
          region: @@aws_access[:region]
      )
    end
  end

  def self.save_concurso_to_db(params)
    if @@dynamo_db.nil?
      return
    end
    resp = @@dynamo_db.put_item({
        item: {
            "concurso_id" => params[:concurso_id],
            "usuario_id" => params[:usuario_id],
            "concurso_info" => params[:custom_fields],
        },
        table_name: "concursos",
        :expected => {
            "concurso_id" => { :comparison_operator => "NULL" }
        }
    })
  end

  def self.get_concurso(concursoId, usuarioId)
    response = @@dynamo_db.get_item({
      key: {
        "concursoId" => {
          n: concursoId, 
        }, 
        "usuarioId" => {
          n: usuarioId, 
        }, 
      }, 
      table_name: 'concursos', 
    })
    # Returns an array of items:
    return response.items
  end

  def self.get_concursos_por_usuario(usuarioId)
    response = @@dynamo_db.query({
       table_name: 'concursos',
       index_name: 'usuario_index',
       select: 'ALL_PROJECTED_ATTRIBUTES',
       key_condition_expression: 'usuario_id = :usuario_id',
       expression_attribute_values: {
           ':usuario_id' => usuarioId
       }
    })
    # Returns an array of items:
    return response.items
  end

  def self.get_concursos
    response = @@dynamo_db.scan(table_name: 'concursos')
    return response.items
  end

  def self.actualizar_concurso(concursoId, usuarioId, customFields)
    puts customFields
    response = @@dynamo_db.get_item({
      expression_attribute_names: {
        "#AT" => "AlbumTitle", 
        "#Y" => "Year", 
      }, 
      expression_attribute_values: {
        ":t" => {
          s: "Louder Than Ever", 
        }, 
        ":y" => {
          n: "2015", 
        }, 
      },
      key: {
        "concursoId" => {
          n: concursoId, 
        }, 
        "usuarioId" => {
          n: usuarioId, 
        }, 
      },
      return_values: "ALL_NEW", 
      table_name: 'concursos',
      update_expression: "SET #Y = :y, #AT = :t", 
    })
    # Returns an array of items:
    return response.items
  end

  def self.eliminar_concurso(concursoId, usuarioId)
    response = @@dynamo_db.delete_item({
      key: {
        "concursoId" => {
          n: concursoId, 
        }, 
        "usuarioId" => {
          n: usuarioId, 
        }, 
      }, 
      table_name: 'concursos', 
    })
    # Returns an array of items:
    return response.items
  end

  def self.save_video_to_db(params)
    puts params
    if @@dynamo_db.nil?
      return
    end
    resp = @@dynamo_db.put_item({
        item: {
            "video_id" => params[:video_id],
            "concurso_id" => Integer(params[:concurso_id]),
            "video_info" => params[:custom_fields],
        },
        table_name: "videos",
        :expected => {
            "video_id" => { :comparison_operator => "NULL" }
        }
    })
  end

  def self.get_video(videoId, concursoId)
    response = @@dynamo_db.get_item({
      key: {
        "videoId" => {
          n: videoId, 
        }, 
        "concursoId" => {
          n: concursoId, 
        }, 
      }, 
      table_name: 'videos', 
    })
    # Returns an array of items:
    return response.items
  end

  def self.get_videos_por_concurso(concursoId)
    response = @@dynamo_db.query({
       table_name: 'videos',
       index_name: 'concurso_index',
       select: 'ALL_PROJECTED_ATTRIBUTES',
       key_condition_expression: 'concurso_id = :concurso_id',
       expression_attribute_values: {
           ':concurso_id' => concursoId
       }
    })
    # Returns an array of items:
    return response.items
  end

  def self.actualizar_video(videoId, concursoId, customFields)
    puts customFields
    response = @@dynamo_db.get_item({
      expression_attribute_names: {
        "#AT" => "AlbumTitle", 
        "#Y" => "Year", 
      }, 
      expression_attribute_values: {
        ":t" => {
          s: "Louder Than Ever", 
        }, 
        ":y" => {
          n: "2015", 
        }, 
      },
      key: {
        "videoId" => {
          n: videoId, 
        }, 
        "concursoId" => {
          n: concursoId, 
        }, 
      },
      return_values: "ALL_NEW", 
      table_name: 'videos',
      update_expression: "SET #Y = :y, #AT = :t", 
    })
    # Returns an array of items:
    return response.items
  end

  def self.eliminar_video(videoId, concursoId)
    response = @@dynamo_db.delete_item({
      key: {
        "videoId" => {
          n: videoId, 
        }, 
        "concursoId" => {
          n: concursoId, 
        }, 
      }, 
      table_name: 'videos', 
    })
    # Returns an array of items:
    return response.items
  end

end
