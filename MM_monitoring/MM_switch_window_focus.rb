#! /usr/bin/ruby

# Switch focus to broswer windows with Kibana

def run
	while 1
		find_kibana_browser_windows.each do |window|
			sleep 30 
			`wmctrl -ia #{window}` unless File.exist?('/home/pi/Desktop/disable')
		end
	end
end

private

def get_opened_windows
	`wmctrl -l`
end

def find_kibana_browser_windows
	windows = get_opened_windows

	windows.each_line.map do |window|
		get_window_identity_code(window) if kibana_window?(window) 
	end.compact
end

def get_window_identity_code(window)
	window.match(/^([^\s]+)/)
end

def kibana_window?(window)
	window.include?('Kibana')
end

# Give time for browsers to spawn up
sleep 300

run
