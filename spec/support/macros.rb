def user_token(user)
  post user_session_url, params: { user: { email: user.email, password: user.password } }
  response.header['Authorization']
end

def header_params(args = {})
  { 'Authorization': args[:token], 'Accept': 'Application/json', 'HTTP_ACCEPT_LANGUAGE': args[:locale] || 'en' }
end

def json
  result = JSON.parse(response.body)
  result.is_a?(Array) ? result : HashWithIndifferentAccess.new(result)
end

def formatted_timestamp(time)
  time.strftime('%Y%m%d %H%M')
end

def formatted_date(date)
  date.strftime('%d/%m/%Y')
end

def image_upload
  fixture_file_upload(Rails.root.join('public', 'default', 'default.jpg'), 'image/jpg')
end

def load_task(task)
  Rails.application.load_tasks
  Rake::Task[task].execute
end
