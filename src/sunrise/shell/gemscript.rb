require "sunrise/shell"

module Setup
    $gemshell = Shell::Script.new("gem", "install")

    def gem_install(gem)
        puts "Initializing Gems"
        $gemshell.reset("gem", "install", gem)
        $gemshell.execute
        puts "Completed!, #{gem}  now installed"
    end

end
