 

 

if script.Parent.Name == "LocationSounds" then
    local l__LocalPlayer__1 = game.Players.LocalPlayer;
    local u1 = game:GetService("ReplicatedStorage").Effects.MuteMusicSFX:Clone();
    u1.Parent = script;
    local l__Songs__2 = script:WaitForChild("Songs");
    function Mute(p2)
        -- upvalues: u1 (copy)
        local v3 = script.Parent:FindFirstChildWhichIsA("Sound");
        if p2 then
            u1.Parent = v3;
            v3.Playing = false;
        else
            u1.Parent = script;
            v3.Playing = true;
        end;
    end;
    l__LocalPlayer__1.ChildAdded:Connect(function(p4) --[[ Line: 18 ]]
        if p4.Name == "MuteMusic" then
            Mute(true);
        end;
    end);
    l__LocalPlayer__1.ChildRemoved:Connect(function(p5) --[[ Line: 24 ]]
        -- upvalues: l__LocalPlayer__1 (copy)
        if p5.Name == "MuteMusic" and not l__LocalPlayer__1:FindFirstChild("MuteMusic") then
            Mute(false);
        end;
    end);
    spawn(function() --[[ Line: 30 ]]
        -- upvalues: l__Songs__2 (copy), l__LocalPlayer__1 (copy), u1 (copy)
        while true do
            local u6 = l__Songs__2:GetChildren()[math.random(1, #l__Songs__2:GetChildren())]:Clone();
            u6.Parent = script.Parent;
            u6.Volume = u6:GetAttribute("Volume");
            if l__LocalPlayer__1:FindFirstChild("MuteMusic") then
                u1.Parent = u6;
                Mute(true);
            else
                u6:Play();
            end;
            local u7 = nil;
            u7 = u6.Ended:connect(function() --[[ Line: 45 ]]
                -- upvalues: u7 (ref), u1 (ref), u6 (copy)
                u7:Disconnect();
                u1.Parent = script;
                u6:Destroy();
            end);
            repeat
                wait(1);
            until not (u6 and u6.Parent);
        end;
    end);
end;