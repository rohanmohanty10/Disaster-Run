  

 

return function(u1) -- Line: 1
    local u2 = u1.Knit.GetService("PlayerDataService");
    script.Parent.MouseButton1Click:Connect(function() -- Line: 3
        -- upvalues: u2 (copy)
        u2:DisablePVPSafe();
    end);
    u1.Player:GetAttributeChangedSignal("PVPSafe"):Connect(function() -- Line: 7
        -- upvalues: u1 (copy)
        local Parent = script.Parent;
        local v3;

        if type(u1.Player:GetAttribute("PVPSafe")) == "number" then
            v3 = u1.Player:GetAttribute("PVPSafe") >= os.time();
        else
            v3 = false;
        end;

        Parent.Visible = v3;
    end);
    local Parent = script.Parent;
    local v4;

    if type(u1.Player:GetAttribute("PVPSafe")) == "number" then
        v4 = u1.Player:GetAttribute("PVPSafe") >= os.time();
    else
        v4 = false;
    end;

    Parent.Visible = v4;
end;