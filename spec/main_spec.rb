require 'spec_helper.rb'

describe 'API' do
  it "Start page ok" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Welcome to api sinatra app!')
  end

  context 'tasks' do
    let!(:task1) { Task.create(title: 'Task#1') }
    let!(:task2) { Task.create(title: 'Task#2') }

    it "GET /api/tasks" do
      get "/api/tasks"
      expect(last_response).to be_ok
      info = JSON::parse(last_response.body)
      expect(info.size).to eq(2)
      expect(info[0]['title']).to eq(task1.title)
      expect(info[1]['title']).to eq(task2.title)
    end


    it "GET /api/tasks/:id" do
      # task = Task.first(title: 'Task#1')
      get "api/tasks/#{task1.id}"
      expect(last_response.body).to include_json(
        id: task1.id,
        title: task1.title
      )
    end

    it "POST /api/tasks" do
      count = Task.count
      params = {  'title' => 'title1',
                  'completed' => true,
                  'description' => 'description1' }
      post "api/tasks", params.to_json
      expect(Task.count).to eq(count + 1)
      expect(last_response.body).to include_json(params)
    end
  end
end
