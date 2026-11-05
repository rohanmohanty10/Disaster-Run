  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2, p3) -- Line: 10
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy)
    if not (p1 and p1:IsDescendantOf(game)) then
        return;
    end;

    local v4 = {
        AbilityName = "Ope",
        SkinName = p3
    };
    local v5 = os.clock();
    local v6 = 0.8166666666666667 / p2;
    local _ = 1 / p2;
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v7 = ParticleHandler.GetUnusualHSVData({
        Character = p1
    });
    local v8 = {};
    local v9 = AssetHandler.GetAsset("Particles/Mes/ChargePart", v4):Clone();
    ParticleHandler.Unusualify(v9, {
        HSVData = v7
    });
    v9.Parent = HumanoidRootPart;
    table.insert(v8, v9);
    ParticleHandler.AttachTo(v9, {
        Part = HumanoidRootPart
    });
    local v10 = AssetHandler.GetAsset("Particles/Mes/ArmEffects", v4):Clone();
    ParticleHandler.Unusualify(v10, {
        HSVData = v7
    });
    v10.Parent = p1["Right Arm"];
    table.insert(v8, v10);
    ParticleHandler.AttachTo(v10, {
        Part = p1["Right Arm"]
    });

    for _, descendant in v10.Startup:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
        end;
    end;

    local CallEffect = EffectsHandler.CallEffect;
    local v11 = {
        Distance = 36,
        Character = p1,
        Part = HumanoidRootPart,
        Duration = v6
    };
    local v12;

    if v7 == nil then
        v12 = Color3.fromRGB(255, 12, 16);
    else
        v12 = ParticleHandler.HSVShift(Color3.fromRGB(255, 12, 16), v7);
    end;

    v11.Color = v12;
    v11.Offset = CFrame.new(0, -2.5, 0);
    CallEffect("Forward Indicator", v11);
    local v13 = 0;

    while true do
        v13 = v13 + task.wait(0.05);

        if v13 >= 0.05 then
            v13 = v13 - 0.05;

            if os.clock() - v5 <= v6 then
                EffectsHandler.CallEffect("Bezier Trails", {
                    Delay = 0.02,
                    Lifetime = 0.25,
                    Amplitude = 1.2,
                    Character = p1,
                    Trail = AssetHandler.GetAsset("Particles/Mes/BezierDark", v4),
                    Origin = (p1["Right Arm"].CFrame * CFrame.new(0, -1, 0)).Position,
                    Amount = math.random(2, 4)
                });
                task.spawn(EffectsHandler.CallEffect, "Lightning Impact", p1, Color3.fromRGB(255, 57, 60));
            end;
        end;

        if v6 < os.clock() - v5 or not p1:IsDescendantOf(game) then
            if not p1:IsDescendantOf(game) then
                return;
            end;

            for _, v in v8 do
                task.delay(ParticleHandler.EnableParticle(v, false), v.Destroy, v);
            end;

            return;
        end;
    end;
end;