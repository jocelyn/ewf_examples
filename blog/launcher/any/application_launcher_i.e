note
	description: "[
			Specific application launcher

			DO NOT EDIT THIS CLASS

			you can customize APPLICATION_LAUNCHER
		]"
	date: "$Date: 2015-06-16 19:59:14 -0300 (ma. 16 de jun. de 2015) $"
	revision: "$Revision: 97479 $"

deferred class
	APPLICATION_LAUNCHER_I [G -> WSF_EXECUTION create make end]

inherit

	SHARED_EXECUTION_ENVIRONMENT

feature -- Execution

	launch ( opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
		do
				launch_libfcgi (opts)
		end

feature {NONE} -- Access

	launcher_nature: detachable READABLE_STRING_8
			-- Initialize the launcher nature
			-- either cgi, libfcgi, or nino.
			--| We could extend with more connector if needed.
			--| and we could use WSF_DEFAULT_SERVICE_LAUNCHER to configure this at compilation time.
		local
			p: PATH
			ext: detachable READABLE_STRING_32
		do
			create p.make_from_string (execution_environment.arguments.command_name)
			if attached p.entry as l_entry then
				ext := l_entry.extension
			end
			if ext /= Void then
				if ext.same_string (nature_nino) then
					Result := nature_nino
				end
				if ext.same_string (nature_cgi) then
					Result := nature_cgi
				end
				if ext.same_string (nature_libfcgi) or else ext.same_string ("fcgi") then
					Result := nature_libfcgi
				end
			end
		end

feature {NONE} -- nino		

	nature_nino: STRING = "nino"

	launch_nino (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_NINO_SERVICE_LAUNCHER [G]
		do
			create launcher.make_and_launch (opts)
		end

feature {NONE} -- cgi

	nature_cgi: STRING = "cgi"

	launch_cgi ( opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_CGI_SERVICE_LAUNCHER [G]
		do
			create launcher.make_and_launch (opts)
		end

feature {NONE} -- libfcgi

	nature_libfcgi: STRING = "libfcgi"

	launch_libfcgi (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_LIBFCGI_SERVICE_LAUNCHER [G]
		do
			create launcher.make_and_launch (opts)
		end


end


