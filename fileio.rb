module IO

    def IO.open(path, content="")
        begin
            launchfile = File.open(path) if File::exists?(path)
            unless launchfile
                launchfile = File.open(path, "w+")
            end
            if !content.eql?("")
                json =  JSON.pretty_generate(content)
                File.write(path, json)
            end
            launchfile
        rescue Exception => e
            raise "Error: #{e.message}"
        end
    end

    def IO.read(filename)
        begin
            content = File.read(filename)
        rescue Exception => e
            raise e.message

        end
        return content
    end

    def IO.exists(filename)
        if File::exists?(filename)
            true
        else
            false
        end
    end

    def IO.createDir(dirname)
        begin
            Dir::mkdir(dirname)
        rescue Exception => e
            raise "Error: project '#{dirname}' already exists!"
        end
    end

    def IO.existsDir(dirname)
        if Dir.exists?(dirname)
            true
        else
            false
        end
    end

end
