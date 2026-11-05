  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local StoreHandler = require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
local ArmorIndicator = game.Players.LocalPlayer:WaitForChild("Settings"):WaitForChild("ArmorIndicator");
local u1 = true;
ArmorIndicator.Changed:Connect(function(p2) -- Line: 9
    -- upvalues: u1 (ref)
    u1 = p2;
end);

return function(u3) -- Line: 13
    -- upvalues: StoreHandler (copy), u1 (ref), Trove (copy)
    if type(u3.UUID) ~= "string" then
        warn("UUID NEEDED FOR HIGHLIGHT");

        return;
    end;

    local v4 = StoreHandler.GetStore("HighlightCache");
    local Object = u3.Object;

    if u3.Type == "Armor" and u1 ~= true then
        return;
    end;

    local v5 = Trove.new();
    v4[u3.UUID] = v5;
    local Highlight = Instance.new("Highlight");
    Highlight.Adornee = Object;
    Highlight.DepthMode = u3.DepthMode or "Occluded";
    Highlight.Enabled = true;
    Highlight.Parent = workspace.Effects;
    v5:Add(function() -- Line: 31
        -- upvalues: u3 (copy), Highlight (copy)
        if u3.FadeTween then
            local v6 = game.TweenService:Create(Highlight, TweenInfo.new(unpack(u3.FadeTween.TweenInfo)), u3.FadeTween.Goal);
            v6:Play();
            v6.Completed:Wait();
        end;

        Highlight:Destroy();
    end);

    for i, v in pairs(u3.Props or {}) do
        Highlight[i] = v;
    end;

    if u3.Tween then
        game.TweenService:Create(Highlight, TweenInfo.new(unpack(u3.Tween.TweenInfo)), u3.Tween.Goal):Play();
    end;
end;