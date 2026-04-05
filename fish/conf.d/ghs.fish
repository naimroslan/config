function ghs -d "Switch git account between work and personal"
    switch $argv[1]
        case work
            git config --global user.name "naim-rooftop"
            git config --global user.email "naim@rooftop.my"
            git config --global user.signingkey ~/.ssh/id_ed25519.pub
            echo "Switched to work (naim-rooftop)"
        case personal
            git config --global user.name "naimroslan"
            git config --global user.email "heyitsnaim@gmail.com"
            git config --global user.signingkey ~/.ssh/id_ed25519_personal.pub
            echo "Switched to personal (naimroslan)"
        case '*'
            echo "Usage: ghs [work|personal]"
            echo ""
            echo "Current: "(git config --global user.name)" <"(git config --global user.email)">"
    end
end
