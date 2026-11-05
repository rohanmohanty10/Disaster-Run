  

 

local Petal = _G.Petal;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Players = game:GetService("Players");
game:GetService("CollectionService");
local _ = Players.LocalPlayer;
Petal("New");
local u1 = Petal("Util");
local _ = u1.Tween;
local _ = Instance.new;
local _ = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;

local function TitleCase(p2) -- Line: 15
    return p2:gsub("(%l)(%w*)", function(p3, p4) -- Line: 16
        return string.upper(p3) .. p4;
    end);
end;

return function(p5, p6) -- Line: 19
    -- upvalues: Trove (copy), u1 (copy), TitleCase (copy)
    local u7 = script.Duplicate:Clone();
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(128, 196, 255);
    Highlight.OutlineColor = Color3.fromRGB(174, 210, 255);
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = u7;
    local PrimaryPart = u7.PrimaryPart;
    local HumanoidRootPart = p5.HumanoidRootPart;
    local v8 = Trove.new();
    local Lifetime = p6.Lifetime;
    local Origin = p6.Origin;
    v8:AttachToInstance(p6.Reference);
    v8:Add(function() -- Line: 37
        -- upvalues: u1 (ref), u7 (copy)
        u1.Tween(u7.Highlight, 0.25, "Quad", "InOut", {
            FillTransparency = 1,
            OutlineTransparency = 1
        });
        task.wait(0.25);
        u7:Destroy();
    end);
    local Halo = p5:FindFirstChild("Halo");
    local v9;

    if Halo then
        v9 = Halo.Inner.Color;
    else
        v9 = nil;
    end;

    u7:PivotTo(Origin);
    u7.Parent = workspace.Effects;
    task.wait();

    if v9 then
        u7.Highlight.FillColor = v9;
    end;

    for _, child in u7:GetChildren() do
        if child:IsA("BasePart") and child.Name ~= "invis" then
            local v10 = p5:FindFirstChild(TitleCase(child.Name));

            if v10 then
                if v9 then
                    child.Color = v9;
                end;

                local v11 = v10.CFrame:ToObjectSpace(HumanoidRootPart.CFrame):Inverse();
                child.Size = child.Size * 1.025;
                child.CFrame = PrimaryPart.CFrame * v11;
            end;
        end;
    end;

    u1.Tween(u7.Highlight, Lifetime, "Quad", "InOut", {
        FillTransparency = 1,
        OutlineTransparency = 1
    });
    task.wait(Lifetime);
    v8:Destroy();
end;