if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not command -q ssh-add
    return
end

if not __ssh_agent_is_started
    __ssh_agent_start
end
