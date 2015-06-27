get '/' do
  'Welcome to api sinatra app!'
end

get '/api/tasks' do
  Task.all.to_json
end

get '/api/tasks/:id' do
  task = Task.get(params[:id])
 
  task.to_json if task
end

post '/api/tasks' do
  body = JSON.parse request.body.read
  task = Task.create(
    title:        body['title'],
    completed:    body['completed'],
    description:  body['description']
  )

  status 201
  task.to_json 
end

put '/api/tasks/:id' do
  body = JSON.parse request.body.read
  task = Task.get(params[:id])
  if task.nil?
    halt(404)
  end
  halt 500 unless Task.update(
    title:        body['title'],
    completed:    body['completed'],
    description:  body['description']
    )
  task.to_json
end

delete '/api/tasks/:id' do
  task = Task.get(params[:id])
  if task.nil?
      halt 404
  end
  halt 500 unless task.destroy
end
