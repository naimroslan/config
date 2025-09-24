# SSH agent setup for Fish shell
# Simple approach: just try to add the key to any available agent

# Add SSH key if it exists (this will work with any running SSH agent)
if test -f ~/.ssh/adrian_rooftop_ed25519
    SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket ssh-add ~/.ssh/adrian_rooftop_ed25519 2>/dev/null
end
