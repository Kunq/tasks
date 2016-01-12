require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  before do
  	@task = Task.create :task => 'Go to bed'
  end


  describe "GET /tasks" do
  	it "display some tasks" do
  		visit tasks_path
  		page.should have_content 'Go to bed'
  	end

  	it "creates a new task" do
  		visit tasks_path
  		fill_in 'Task', :with => 'go to work'

  		click_button 'Create Task'

  		current_path.should == tasks_path
  		page.should have_content 'go to work'
  	end

  end

  describe "PUT /tasks" do
  	it "edits a task" do
  		visit tasks_path
  		click_link 'Edit'

  		current_path.should == edit_task_path(@task)
  		#page.should have_content 'Go to bed'
  		find_field('Task').value.should == 'Go to bed'

  		fill_in 'Task', :with => 'update task'
  		click_button 'Update Task'

  		current_path.should == tasks_path

  		page.should have_content 'update task'
  	end

  	it "should not update an empty task" do
  		visit tasks_path
  		click_link 'Edit'

  		fill_in 'Task', :with => ''
  		click_button 'Update Task'

  		current_path.should == edit_task_path(@task)
  		page.should have_content 'There was an error updating your task.'
  	end
  end

  describe "DELETE /tasks" do
	  it "should delete a task" do
		  visit tasks_path
		  find("#task_#{@task.id}").click_link 'Delete'
		  page.should have_content 'Task has been deleted'
		  page.should have_no_content 'Go to bed'

	  end

  end
end
