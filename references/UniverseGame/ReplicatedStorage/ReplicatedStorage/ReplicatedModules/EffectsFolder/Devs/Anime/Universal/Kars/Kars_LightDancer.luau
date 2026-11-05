  

 

local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local TweenService = game:GetService("TweenService");
require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 6
    -- upvalues: ParticleHandler (copy), TweenService (copy)
    local v2;

    if p1 then
        v2 = p1:FindFirstChild("Blades");
    else
        v2 = p1;
    end;

    if not v2 then
        return;
    end;

    local v3 = { Color3.fromRGB(255, 102, 204), Color3.fromRGB(128, 187, 219) };
    local v4 = ParticleHandler.GetUnusualHSVData({
        Character = p1
    });

    if v4 ~= nil then
        for i, v in v3 do
            v3[i] = ParticleHandler.HSVShift(v, v4);
        end;
    end;

    local v5 = Random.new();

    while true do
        task.wait(0.15);

        if p1:GetAttribute("BoneBlades") then
            for i = 1, 2 do
                local v6 = v2[(i == 1 and "Left" or "Right") .. "Blade"];
                local u7 = Instance.fromExisting(v6.Handle.Blade);
                u7.Color = v3[math.random(1, 2)];
                u7.Material = Enum.Material.Neon;
                u7.Anchored = false;
                u7.CastShadow = false;
                u7.Transparency = 0.5;
                u7.Parent = workspace.Effects;
                u7.Size = u7.Size * v5:NextNumber(1.03, 1.075);
                u7.CFrame = v6.Handle.Blade.CFrame;
                local ManualWeld = Instance.new("ManualWeld");
                ManualWeld.Part0 = u7;
                ManualWeld.Part1 = v6.Handle.Blade;
                ManualWeld.C0 = ManualWeld.Part0.CFrame:ToObjectSpace(ManualWeld.Part1.CFrame);
                ManualWeld.Parent = ManualWeld.Part0;
                local v8 = TweenService:Create(u7, TweenInfo.new(0.185, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1,
                    Size = u7.Size * v5:NextNumber(1.01, 1.035)
                });
                v8.Completed:Connect(function() -- Line: 55
                    -- upvalues: u7 (copy)
                    u7:Destroy();
                end);
                v8:Play();
            end;
        end;

        if not (p1:IsDescendantOf(game) and p1:GetAttribute("LightDancer")) then
            return;
        end;
    end;
end;