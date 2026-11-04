  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    p1.Char:SetAttribute("flashColor", Color3.fromRGB(47, 193, 255));
    p1.Char:SetAttribute("flashTimestamp", workspace:GetServerTimeNow());
    local u2 = ReplicatedStorage.Assets.UI.Pass:Clone();
    u2.Parent = game.Players.LocalPlayer.PlayerGui;
    u2.Adornee = p1.Char.PrimaryPart;
    u2.Enabled = true;
    u2.Bar.Size = UDim2.new(0, 0, 0, 0);
    task.delay(2, function() -- Line: 17
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    local v3 = TweenService:Create(u2.Bar, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Size = UDim2.new(10, 0, 1, 0)
    });
    v3:Play();
    Debris:AddItem(v3, 0.25);
    task.delay(1.5, function() -- Line: 27
        -- upvalues: TweenService (ref), u2 (copy), Debris (ref)
        local v4 = TweenService:Create(u2.Bar, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 0)
        });
        v4:Play();
        Debris:AddItem(v4, 0.5);
    end);
end;