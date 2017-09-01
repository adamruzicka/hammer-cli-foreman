module HammerCLIForeman
  module SSHKeyCommons
    def self.included(base)
      base.option "--user_id", "USER_ID", _("ID of the user to add the SSH Key to")
    end

    def request_params
      params = super
      params["user_id"] = option_user_id
      params
    end
  end

  class SSHKeys < HammerCLIForeman::Command
    resource :ssh_keys
    command_name "ssh-keys"
    desc _("Manage SSH Keys sources.")

    class ListCommand < HammerCLIForeman::ListCommand
      include SSHKeyCommons

      output do
        field :id, _("Id")
        field :name, _("Name")
        field :fingerprint, _("Fingerprint")
        field :length, _("Length")
        field :created_at, _("Created at"), Fields::Date
      end

      build_options
    end

    class CreateCommand < HammerCLIForeman::CreateCommand
      include SSHKeyCommons

      def self.command_name
        "add"
      end

      success_message _("SSH Key [%{name}] added")
      failure_message _("Could not add SSH Key")

      build_options
    end

    class DeleteCommand < HammerCLIForeman::DeleteCommand
      include SSHKeyCommons

      success_message _("SSH Key [%{name}] deleted")
      failure_message _("Could not delete the SSH Key")

      build_options
    end
  end
end
