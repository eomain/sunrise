
NEWPROJECT = [  "Enter the software version(default is '0.0.1') : ",
                "Enter main project filename(default is main.rb) : ",
                "Enter your project's description: ",
                "Enter the name's of the authors: " ]

def projectPrompt(name)
    begin
        length = NEWPROJECT.length + 1
        userdata = Array.new (length)
        userdata[0] = name

        NEWPROJECT.each_index do |i|
            print NEWPROJECT[i]
            userdata[i + 1] = STDIN.gets.chomp
        end

        time = Time.new
        date = time.strftime("%d-%m-%Y %H:%M:%S")
        userdata[length] = date
        puts
        puts "These settings can be modified later in the file 'launch.json'"

    rescue Exception => e
        puts e.message
        retry
    end

    return userdata
end
