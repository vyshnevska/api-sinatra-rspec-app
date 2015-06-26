require 'spec_helper.rb'

describe 'API' do
  before(:each) do
    # cleanup database
    Task.all.destroy
  end

  it "Start page ok" do
    get "/"
    expect(last_response).to be_ok
  end

  it "Start content" do
    get "/"
    expect(last_response.body).to eq('rspec-api-rest-example')
  end

  it "GET /api/tasks" do
    # create in data base
    Task.create(title: 'Task 1')
    Task.create(title: 'Task 2')

    # get REST GET request
    get "/api/tasks"
    # test 'ok' respone
    expect(last_response).to be_ok
    # parse JSON
    info = JSON::parse(last_response.body)
    expect(info.size).to eq(2)
    expect(info[0]['title']).to eq('Task 1')
    expect(info[1]['title']).to eq('Task 2')
  end


  it "GET /api/tasks/:id" do
    task = Task.create(title: 'Task 1')
    get "api/tasks/#{task.id}"
    expect(last_response.body).to include_json(
      id: task.id,
      title: task.title
    )
  end

  it "POST /api/tasks" do
    Task.count.should == 0
    params = {  'title' => 'title1',
                'completed' => true,
                'description' => 'description1' }

    post "api/tasks", params.to_json

    expect(Task.count).to eq(1)
    expect(last_response.body).to include_json(params)
  end
end
