  

 

local LocalPlayer = game.Players.LocalPlayer;
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);

return function(p1) -- Line: 4
    -- upvalues: LocalPlayer (copy), Stands (copy)
    if LocalPlayer:FindFirstChild("NoCooldowns") then
        return;
    end;

    local Character = LocalPlayer.Character;
    local CDFrame = LocalPlayer.PlayerGui.Core.CooldownGui.CDFrame;
    local u2 = CDFrame.Template:Clone();
    u2.Name = p1[1];
    u2.topBar.Lab.Text = p1[1];
    u2.topBar.Typ.Text = Stands[LocalPlayer.Data.Ability.Value];
    local Progress = u2.pBar.Progress;
    Progress.Size = UDim2.new(1, 0, 1, 0);
    local v3 = game:GetService("TweenService"):Create(Progress, TweenInfo.new(p1[2], Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 1, 0)
    });
    u2.Visible = true;

    for _, descendant in pairs(u2:GetDescendants()) do
        descendant.Visible = true;
    end;

    v3:Play();
    u2.Parent = CDFrame;
    game:GetService("Debris"):AddItem(u2, p1[2]);
    local v4 = Character.Humanoid.Died:Connect(function() -- Line: 23
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    wait(p1[2]);
    v4:Disconnect();
end;