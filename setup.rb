require "./shell"

module Setup
    $gitshell = Shell::Script.new("git", "init")
    $branch = "master"

    def git_init
        puts "Initializing Git repository"
        $gitshell.reset("git", "init")
        $gitshell.execute
        puts "Completed!"
    end

    def git_checkout(branch)
        $gitshell.reset("git", "checkout", branch)
        $gitshell.execute
        $branch = branch
    end

    def git_commit_all
        $gitshell.reset("git", "add", ".")
        $gitshell.execute
        $gitshell.reset("git", "commit")
        $gitshell.execute
        put "Successfully commit to #{$branch}"
    end

end
