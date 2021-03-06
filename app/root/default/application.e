note
	description: "Summary description for {APPLICATION}."
	author: ""
	date: "$Date: 2013-06-12 08:55:42 -0300 (mié 12 de jun de 2013) $"
	revision: "$Revision: 36 $"

class
	APPLICATION

inherit
	APP_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			set_service_option ("port", 9090)
--			set_service_option ("verbose", True)
--			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file_and_defaults ("server.ini", service_options)
			Precursor
		end

feature {NONE} -- Launcher

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_DEFAULT_SERVICE_LAUNCHER [APP_SERVICE_EXECUTION]
		do
			create launcher.make_and_launch (opts)
		end

end
