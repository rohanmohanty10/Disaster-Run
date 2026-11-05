  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 10
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.KnitPath.Trove);
end);
local u2 = {
    BrickColor.new("Really red").Color,
    BrickColor.new("Maroon").Color,
    BrickColor.new("Really red").Color,
    BrickColor.new("Dark indigo").Color,
    BrickColor.new("Bright violet").Color,
    BrickColor.new("Hot pink").Color,
    BrickColor.new("Smoky grey").Color
};

return function(p3, p4, p5) -- Line: 24
    -- upvalues: AssetHandler (copy), u2 (copy), EffectsHandler (copy), TweenService (copy)
    local v6;

    if p3 then
        v6 = p3:FindFirstChild("Torso");
    else
        v6 = p3;
    end;

    if not v6 then
        return;
    end;

    local u7 = AssetHandler.CloneAsset("Models/HeavenKanji", {
        AbilityName = "Uber Oni"
    });
    local Letter = u7.Letter;
    u7.Parent = workspace.Effects;
    local v8 = p3:GetScale();
    u7:ScaleTo(v8);
    Letter.CFrame = v6.CFrame * CFrame.new(0.2 * v8, 0, 0.65 * v8) * CFrame.Angles(0, 1.5707963267948966, 0);
    Letter.Anchored = false;
    u7.Weld.Part0 = v6;
    u7.Highlight.Enabled = true;
    u7.Highlight.Adornee = Letter;
    u7.Highlight.DepthMode = Enum.HighlightDepthMode[p5 and "AlwaysOnTop" or "Occluded"];
    Letter.Color = Color3.new(0.25, 0.25, 0.25);
    local v9 = os.clock();
    local v10 = 1;

    repeat
        local v11 = v10 % #u2;
        u7.Highlight.FillColor = u2[v11 == 0 and (#u2 or v11) or v11];
        local v12, v13, v14 = u7.Highlight.FillColor:ToHSV();
        u7.Highlight.OutlineColor = Color3.fromHSV(v12, math.min(v13 - 0.1, 0), (math.min(v14 - 0.15, 0)));
        Letter.CFrame = Letter.CFrame * CFrame.new(0, 0.013333333333333334, 0);
        Letter.Size = Letter.Size * 1.00125;
        v10 = v10 + 1;
        EffectsHandler.Wait(0.02);
    until not u7 or (not p3 or (not v6 or (not p3.Parent or (not v6.Parent or p4 <= os.clock() - v9))));

    if u7 and p3 then
        u7.Highlight.FillColor = BrickColor.new("Persimmon").Color;
        u7.Highlight.OutlineColor = Color3.new();
        Letter.Color = Color3.new(1, 1, 1);
        u7.Weld:Destroy();
        Letter.Anchored = true;
        local v15 = TweenService:Create(Letter, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(Letter.Size.X / 2, Letter.Size.Y * 2.5, Letter.Size.Z / 2),
            Position = Letter.Position + Vector3.new(0, Letter.Size.Y * 1.5, 0),
            Color = Color3.new()
        });
        v15:Play();
        v15.Completed:Once(function() -- Line: 73
            -- upvalues: u7 (copy)
            if u7 then
                u7:Destroy();
            end;
        end);
    end;
end;