require File.join(File.dirname(__FILE__), "test_helper")
require File.join(File.dirname(__FILE__), "apipie_resource_mock")

require "hammer_cli_foreman/ssh_keys"

describe HammerCLIForeman::SSHKeys do
  include CommandTestHelper

  before do
    ResourceMocks.ssh_keys
  end

  context "ListCommand" do
    let(:cmd) { HammerCLIForeman::SSHKeys::ListCommand.new("", ctx) }

    context "parameters" do
      it_should_fail_with "no arguments"
      it_should_accept "user-id", ["--user_id", "1"]
    end

    context "output" do
      let(:expected_record_count) { count_records(cmd.resources) }

      with_params ["--user-id=1"] do
        it_should_print_n_records
        it_should_print_column "Name"
      end
    end
  end

  context "CreateCommand" do
    let(:cmd) { HammerCLIForeman::SSHKeys::CreateCommand.new("", ctx) }

    context "parameters" do
      it_should_accept "user-id", ["--user_id=1"]
    end
  end

  context "DeleteCommand" do
    let(:cmd) { HammerCLIForeman::SSHKeys::DeleteCommand.new("", ctx) }

    context "parameters" do
      it_should_accept "id", ["--id=1"]
    end
  end
end
