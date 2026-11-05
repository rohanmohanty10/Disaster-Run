  

 

return function(p1) -- Line: 1
    local _ = script.Parent;
    local _ = p1.FusionComponents.GameplayButton;
    local u2 = p1.Util.Tooltip.GetFromParent(p1.UI:FindFirstChild("Screen"));
    local u3 = {
        Party = {
            Title = "Party Member List",
            Description = "Show/hide party member list"
        },
        Emote = {
            Title = "Emote List",
            Description = "Show/hide emote list"
        },
        StandChanger = {
            Title = "Stand Changer",
            Description = "Show/hide stand changer"
        },
        TimeToggle = {
            Title = "Time Toggle",
            Description = "Switch between day/night lighting"
        },
        Quote = {
            Title = "Quote / Move List",
            Description = "Show/hide quote/move list"
        },
        CameraMode = {
            Title = "Camera Mode Toggle",
            Description = "Switch between different camera modes"
        },
        Rewards = {
            Title = "Open Rewards Menu",
            Description = "Opens the playtime rewards menu"
        },
        Phone = {
            Title = "Smart Assistant",
            Description = "Request various convenient functions"
        },
        PVPSafe = {
            Title = "Disable PVP Safe",
            Description = "Turns off PVP Safe"
        },
        Backpack = {
            Title = "Backpack",
            Description = "Toggles the backpack UI"
        },
        PVPApologize = {
            Title = "PvP Apology",
            Description = "Request a PvP apology to cancel the combat/PvP tag"
        }
    };

    for _, child in script.Parent:GetChildren() do
        if child:IsA("TextButton") then
            child.MouseEnter:Connect(function() -- Line: 64
                -- upvalues: u3 (copy), child (copy), u2 (copy)
                local v4 = u3[child.Name];

                if not v4 then
                    return;
                end;

                u2:SetTitle(v4.Title);
                u2:SetText(v4.Description);
                u2:Show();
            end);
            child.MouseLeave:Connect(function() -- Line: 72
                -- upvalues: u2 (copy)
                u2:Hide();
            end);
        end;
    end;
end;