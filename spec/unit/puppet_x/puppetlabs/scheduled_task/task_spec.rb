require 'spec_helper'
require 'puppet_x/puppetlabs/scheduled_task/task'

describe PuppetX::PuppetLabs::ScheduledTask::Task do

  let(:UserId)     {'vagrant'}
  let(:Principal)  {UserId}
  let(:Definition) {Principal}
  let(:_task)      {@{}}

  describe "with account with password" do

    before(:each) do
      folder = double('folder')
      folder.stub(:GetTask).and_return(_task)
      service = double('service')
      service.stub(:GetFolder).and_return(folder)
      allow(PuppetX::PuppetLabs::ScheduledTask::Task).to receive(:task_service).and_return(service)
      task = PuppetX::PuppetLabs::ScheduledTask::Task.new('test')
    end

    it "should set the password instance variable" do

      task.set_account_information('vagrant','vagrant')
      password = task.instance_variable_get('@task_password')
      expect(password).to eq('vagrant')
    end
  end
end