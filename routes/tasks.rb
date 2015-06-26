get '/' do
  'rspec-api-rest-example'
end

get '/api/tasks' do
  Task.all.to_json
end

get '/api/tasks/:id' do
  t = Task.get(params[:id])
  if t.nil?
    halt 404
  end
  t.to_json
end

post '/api/tasks' do
  body = JSON.parse request.body.read
  t = Task.create(
    title:        body['title'],
    completed:    body['completed'],
    description:  body['description']
  )

  status 201
  t.to_json 
end

put '/api/tasks/:id' do
  body = JSON.parse request.body.read
  t = Task.get(params[:id])
  if t.nil?
    halt(404)
  end
  halt 500 unless Task.update(
    title:        body['title'],
    completed:    body['completed'],
    description:  body['description']
    )
  t.to_json
end

delete '/api/tasks/:id' do
  t = Task.get(params[:id])
  if t.nil?
      halt 404
  end
  halt 500 unless t.destroy
end
