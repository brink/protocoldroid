module ApiLogger

  def log_request
    unless Haiku.config.env.test?
      Grape::API.logger.info "#{request.ip} #{env['REQUEST_METHOD']} #{env['PATH_INFO']}?#{env['QUERY_STRING']} #{env['rack.request.form_hash'] ? env['rack.request.form_hash'].to_json : ''}"
    end
  end
end
