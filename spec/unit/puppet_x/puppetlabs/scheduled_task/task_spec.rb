require 'spec_helper'
require 'puppet_x/puppetlabs/scheduled_task/task'

describe PuppetX::PuppetLabs::ScheduledTask::Task do
  describe "with account with password" do

    before(:each) do
      @password = "blah_#{rand(999)}"
      principal = double('principal')
      principal.stub(:UserId).and_return('vagrant')
      principal.stub(:UserId=).with(anything)
      principal.stub(:LogonType=).with(anything)
      principal.stub(:RunLevel=).with(anything)

      definition = double('definition')
      definition.stub(:Principal).and_return(principal)

      _task = double('_task')
      _task.stub(:Definition).and_return(definition)

      folder = double('folder')
      folder.stub(:GetTask).and_return(_task)

      service = double('service')
      service.stub(:GetFolder).and_return(folder)

      allow(PuppetX::PuppetLabs::ScheduledTask::Task).to receive(:task_service).and_return(service)

      @task = PuppetX::PuppetLabs::ScheduledTask::Task.new('test')
    end

    it "should set the password instance variable" do
      @task.set_account_information('vagrant',@password)
      password = @task.instance_variable_get('@task_password')
      expect(password).to eq(@password)
    end
  end
end
