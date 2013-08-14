require "i18n"

module VagrantPlugins
  module VCloud
    module Action
      class PowerOn
        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("vagrant_vcloud::action::power_on")
        end

        def call(env)
          @env = env


          cfg = env[:machine].provider_config
          cnx = cfg.vcloud_cnx.driver
          vmName = env[:machine].name

	      @logger.info("Starting VM [#{vmName}]")
	      env[:ui].info("Starting VM [#{vmName}]")
	      poweronVM = cnx.poweron_vm(env[:machine].id)
	      cnx.wait_task_completion(poweronVM)


          @app.call(env)
        end
      end
    end
  end
end


