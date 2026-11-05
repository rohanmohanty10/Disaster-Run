  

 

local Log = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Log");
local _ = game.Players.LocalPlayer.PlayerGui;
local Parent = script.Parent;
local u1 = {};
local u2 = false;
local u3 = {
    Error = Color3.fromRGB(255, 135, 135),
    Warn = Color3.fromRGB(255, 188, 53)
};

local function AddRemainingLogs() -- Line: 15
    -- upvalues: u2 (ref), u1 (copy), u3 (copy), Parent (copy)
    u2 = false;

    for i, v in u1 do
        if v.Frame == nil then
            local v4 = v.Color or u3[v.Type];
            local v5 = Parent.Frame.ErrorLog.Template:Clone();
            v5.Error.Text = v.Message;
            v5.Error.TextColor3 = v4;
            v5.Count.TextColor3 = v4;
            v5.Visible = true;
            v5.Parent = Parent.Frame.ErrorLog;
            v.Frame = v5;
        end;

        v.Frame.Count.Text = `(x{v.Count})`;
        v.Frame.LayoutOrder = 500 - i;
    end;
end;

Log.OnClientEvent:Connect(function(p6) -- Line: 33
    -- upvalues: u1 (copy), Parent (copy), u2 (ref), AddRemainingLogs (copy)
    local v7 = u1[#u1];
    local v8 = tostring(p6.Message);

    if v7 and (v7.Message == v8 and v7.Type == p6.Type) then
        v7.Count = v7.Count + 1;

        if Parent.Enabled then
            v7.Frame.Count.Text = `(x{v7.Count})`;

            return;
        end;

        u2 = true;

        return;
    end;

    if #u1 >= 500 then
        local v9 = table.remove(u1, 1);

        if v9.Frame then
            v9.Frame:Destroy();
        end;
    end;

    table.insert(u1, {
        Count = 1,
        Message = v8,
        Type = p6.Type or "Error",
        Color = p6.Color
    });

    if Parent.Enabled then
        AddRemainingLogs();

        return;
    end;

    u2 = true;
end);
game:GetService("UserInputService").InputBegan:Connect(function(p10, p11) -- Line: 64
    -- upvalues: Parent (copy), u2 (ref), AddRemainingLogs (copy)
    if not p11 and p10.KeyCode.Name == "Minus" then
        local v12 = not Parent.Enabled;

        if u2 and v12 then
            AddRemainingLogs();
        end;

        Parent.Enabled = v12;
    end;
end);