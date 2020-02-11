module Renderer
  def create_form(form, model, _id)
    if form.create
      resource = form.send(model)
      cache_render (resource.class.name + 'Serializer').constantize, resource
    else
      invalid_resource(form.send(model))
    end
  end

  def update_form(form, model, id)
    if form.update(id)
      resource = form.send(model)
      cache_render (resource.class.name + 'Serializer').constantize, resource
    else
      invalid_resource(form.send(model))
    end
  end

  def file_download(file_path, file_name, file_type)
    send_file(
      file_path,
      type: file_type,
      disposition: 'attachment',
      file_name: file_name,
      x_sendfile: true
    )
  end

  def method_missing(method_sym, *args, &block)
    if method_sym.to_s =~ /^(.*)_form$/
      action, model =  Regexp.last_match(1).split('_', 2)
      send("#{action}_form", *args, model, params[:id])
    else
      super
    end
  end

  def respond_to_missing?(method, *)
    super
  end
end
