require 'hammer_cli_foreman/smart_class_parameter'

module HammerCLIForeman

  class PuppetClass < HammerCLIForeman::Command

    resource :puppetclasses

    class ListCommand < HammerCLIForeman::ListCommand

      output do
        field :id, _("Id")
        field :name, _("Name")
      end

      def retrieve_data
        self.class.unhash_classes(super)
      end

      def self.unhash_classes(classes)
        clss = classes.first.inject([]) { |list, (pp_module, pp_module_classes)| list + pp_module_classes }

        HammerCLI::Output::RecordCollection.new(clss, :meta => classes.meta)

      end

      build_options
    end


    class InfoCommand < HammerCLIForeman::InfoCommand
      #FIXME: show environments, hostgroups, variables and parameters
      output ListCommand.output_definition do
        collection :lookup_keys, _("Smart variables") do
          from :lookup_key do
            field :key, _("Parameter")
            field :default_value, _("Default value")
          end
        end
      end

      build_options
    end


    class SCParamsCommand < HammerCLIForeman::SmartClassParametersBriefList

      option ['--id', '--name'], 'PUPPET_CLASS_ID', _('puppet class id/name'),
              :attribute_name => :puppetclass_id, :required => true
    end


    autoload_subcommands
  end

end

HammerCLI::MainCommand.subcommand 'puppet-class', _("Search puppet modules."), HammerCLIForeman::PuppetClass

