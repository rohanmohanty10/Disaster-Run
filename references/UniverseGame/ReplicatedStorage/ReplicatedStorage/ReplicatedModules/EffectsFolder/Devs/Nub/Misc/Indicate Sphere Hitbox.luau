  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 5
    -- upvalues: Trove (copy), u1 (copy), TweenService (copy)
    local StartSize = p2.StartSize;
    local EndSize = p2.EndSize;
    local Time = p2.Time;
    local Offset = p2.Offset;
    local Character = p2.Character;
    local Part = p2.Part;

    if not (Part and Part:IsDescendantOf(workspace)) then
        return;
    end;

    if not (Character and Character:IsDescendantOf(workspace)) then
        return;
    end;

    if typeof(Offset) ~= "CFrame" or (type(StartSize) ~= "vector" or (type(EndSize) ~= "vector" or type(Time) ~= "number")) then
        return;
    end;

    local u3 = Trove.new();
    local v4 = u3:Clone(u1.Locke.Sphere);
    u3:Connect(Character:GetAttributeChangedSignal("Hitbox"), function() -- Line: 19
        -- upvalues: Character (copy), u3 (copy)
        if not Character:GetAttribute("Hitbox") then
            u3:Destroy();
        end;
    end);
    v4.Size = StartSize;
    v4.CFrame = Part.CFrame * Offset;
    v4.Color = Color3.new(1, 0, 0);
    v4.Transparency = 0.5;
    v4.Anchored = true;
    v4.Parent = workspace.Effects;
    local v5 = TweenService:Create(v4, TweenInfo.new(Time, Enum.EasingStyle.Linear), {
        Size = EndSize
    });
    v5:Play();
    v5.Completed:Connect(function() -- Line: 32
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;