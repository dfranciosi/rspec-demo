require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  fixtures :tasks

  #
  # GET /tasks
  #

  test "{ :controller => 'tasks', :action => 'index' } is routed correctly" do
    assert_routing '/tasks', { :controller => 'tasks', :action => 'index' }
  end

  test "GET 'tasks' is recognized correctly" do
    assert_recognizes({ :controller => 'tasks', :action => 'index' }, { :path => 'tasks' })
  end

  test "tasks_path generates '/tasks'" do
    assert_equal '/tasks', tasks_path
  end

  test 'TasksController handling GET /tasks is a success' do
    get :index

    assert_response :success
  end

  test 'TasksController handling GET /tasks renders the tasks/index template' do
    get :index

    assert_template 'tasks/index'
  end

  test 'TasksController handling GET /tasks assigns all tasks for the view' do
    get :index

    assert_equal [tasks(:one)], assigns(:tasks)
  end

  test 'TasksController handling GET /tasks renders a list of tasks' do
    get :index

    assert_select 'ul.tasks > li', 1
  end

  test 'TasksController handling GET /tasks renders links to the tasks' do
    get :index

    assert_select 'ul.tasks > li > a[href=?]', task_path(tasks(:one))
  end

  test 'TasksController handling GET /tasks renders a link to tasks/new' do
    get :index

    assert_select 'a[href=?]', new_task_path
  end

  #
  # GET /tasks/new
  #

  test "{ :controller => 'tasks', :action => 'new' } is routed correctly" do
    assert_routing '/tasks/new', { :controller => 'tasks', :action => 'new' }
  end

  test "GET 'tasks/new' is recognized correctly" do
    assert_recognizes({ :controller => 'tasks', :action => 'new' }, { :path => 'tasks/new' })
  end

  test "new_task_path generates '/tasks/new'" do
    assert_equal '/tasks/new', new_task_path
  end

  test 'TasksController handling GET /tasks/new is a success' do
    get :new

    assert_response :success
  end

  test 'TasksController handling GET /tasks/new renders the tasks/new template' do
    get :new

    assert_template 'tasks/new'
  end

  test 'TasksController handling GET /tasks/new assigns a new task for the view' do
    get :new

    assert_not_nil assigns(:task)
    assert_kind_of Task, assigns(:task)
    assert assigns(:task).new_record?
  end

  test 'TasksController handling GET /tasks/new renders a form for the task' do
    get :new

    assert_select 'form[method="post"][action=?]', tasks_path do
      assert_select 'input#task_title[type="text"][name=?]', 'task[title]'
      assert_select 'input[type="submit"]'
    end
  end

  test 'TasksController handling GET /tasks/new renders a link to tasks_path' do
    get :show, :id => 1

    assert_select 'a[href=?]', tasks_path
  end

  #
  # POST /tasks
  #

  test "{ :controller => 'tasks', :action => 'create' } is routed correctly" do
    assert_routing({ :path => '/tasks', :method => 'post' }, { :controller => 'tasks', :action => 'create' })
  end

  test "POST 'tasks' is recognized correctly" do
    assert_recognizes({ :controller => 'tasks', :action => 'create' }, { :path => 'tasks', :method => 'post' })
  end

  test 'TasksController handling POST /tasks redirects to tasks_url when all required attributes are set' do
    post :create, :task => { :title => 'title' }

    assert_redirected_to tasks_url
  end

  test 'TasksController handling POST /tasks sets a flash notice when all required attributes are set' do
    post :create, :task => { :title => 'title' }

    assert_not_nil flash[:notice]
  end

  test 'TasksController handling POST /tasks renders template tasks/new when not all required attributes are set' do
    post :create, :task => { :title => '' }

    assert_template 'tasks/new'
  end

  test 'TasksController handling POST /tasks changes Task.count' do
    assert_difference('Task.count') do
      post :create, :task => { :title => 'title'}
    end
  end

  #
  # GET /tasks/:id
  #

  test "{ :controller => 'tasks', :action => 'index', :id => '1' } is routed correctly" do
    assert_routing '/tasks/1', { :controller => 'tasks', :action => 'show', :id => '1' }
  end

  test "GET 'tasks/1' is recognized correctly" do
    assert_recognizes({ :controller => 'tasks', :action => 'show', :id => '1' }, { :path => 'tasks/1' })
  end

  test "task_path(1) generates '/tasks/1'" do
    assert_equal '/tasks/1', task_path(1)
  end

  test 'TasksController handling GET /tasks/:id is a success' do
    get :show, :id => 1

    assert_response :success
  end

  test 'TasksController handling GET /tasks/:id renders the tasks/show template' do
    get :show, :id => 1

    assert_template 'tasks/show'
  end

  test 'TasksController handling GET /tasks/:id assigns the task for the view' do
    get :show, :id => 1

    assert_equal tasks(:one), assigns(:task)
  end

  test "TasksController handling GET /tasks/:id renders the task's title" do
    get :show, :id => 1

    assert_select 'h1', /#{tasks(:one).title}/m
  end

  test "TasksController handling GET /tasks/:id renders a link to finish the task" do
    get :show, :id => 1

    assert_select "a[href=?]", finish_task_path(tasks(:one))
  end

  test 'TasksController handling GET /tasks/:id renders a link to tasks_path' do
    get :show, :id => 1

    assert_select 'a[href=?]', tasks_path
  end

  #
  # PUT /tasks/:id/finish
  #

  test "{ :controller => 'tasks', :action => 'finish', :id => '1' } is routed correctly" do
    assert_routing({ :path => '/tasks/1/finish', :method => 'put' }, { :controller => 'tasks', :action => 'finish', :id => '1' })
  end

  test "PUT 'tasks/1/finish' is recognized correctly" do
    assert_recognizes({ :controller => 'tasks', :action => 'finish', :id => '1' }, { :path => 'tasks/1/finish', :method => 'put' })
  end

  test "finish_task_path generates '/tasks/1/finish'" do
    assert_equal '/tasks/1/finish', finish_task_path(1)
  end

  test 'TasksController handling PUT /tasks/:id/finish redirects to tasks_url' do
    put :finish, :id => 1

    assert_redirected_to tasks_url
  end

  test 'TasksController handling PUT /tasks/:id/finish sets a flash notice' do
    put :finish, :id => 1

    assert_not_nil flash[:notice]
  end

  def teardown
    Task.destroy_all
  end

end
