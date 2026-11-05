  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local _ = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

function RandSign()
    return math.random(0, 2) == 1 and -1 or 1;
end;

return function(p2, p3) -- Line: 18
    -- upvalues: Players (copy), u1 (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v4 = Players:GetPlayerFromCharacter(p2);
    local HumanoidRootPart = p2.HumanoidRootPart;
    local v5 = nil;
    local v6 = RandSign();
    local v7 = RandSign();
    local v8 = 0;

    if v4 and v4.Data.Skin:GetAttribute("UnusualHueId") then
        v8 = v8 + v4.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    while true do
        v6 = v6 * -1;
        v7 = v7 * -1;
        local v9 = u1:NextNumber(0, 3.141592653589793);
        local Position = HumanoidRootPart.Position;
        local v10 = math.cos(v9) * u1:NextNumber(13, 16) * v6;
        local v11 = u1:NextNumber(-5, 10);
        local v12 = math.sin(v9) * u1:NextNumber(13, 16) * v7;
        local v13 = Position + Vector3.new(v10, v11, v12);
        local v14 = AssetHandler.GetAsset("Particles/LovelyLegwork/Heart", p3):Clone();
        v14.CFrame = CFrame.new(v13, HumanoidRootPart.Position) * CFrame.Angles(0, 1.5707963267948966, 0);
        v14.Parent = workspace.Effects;

        if v8 > 0 then
            ParticleHandler.HSVShiftParticles(v14, {
                HueShift = v8
            });
            v14.Color = ParticleHandler.HSVShift(v14.Color, {
                HueShift = v8
            });
        end;

        local v15 = ParticleHandler.GetMaxLifetime(v14);
        task.delay(v15, v14.Destroy, v14);
        ParticleHandler.Emit(v14, ParticleHandler.GenerateEmitInfo(v14));
        TweenService:Create(v14, TweenInfo.new(v15 / 1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();

        if v5 then
            local v16 = AssetHandler.GetAsset("Particles/LovelyLegwork/Beam", p3):Clone();
            v16.Size = Vector3.new(0.135, (v5.Position - v14.Position).Magnitude * 0.8, 0.135);
            v16.CFrame = CFrame.new(v5.Position:Lerp(v14.Position, 0.5), v14.Position) * CFrame.Angles(-1.5707963267948966, 0, 0);
            v16.Parent = workspace.Effects;

            if v8 > 0 then
                ParticleHandler.HSVShiftParticles(v16, {
                    HueShift = v8
                });
            end;

            ParticleHandler.DestroyEmit(v16);
            ParticleHandler.Emit(v16, ParticleHandler.GenerateEmitInfo(v16));
        end;

        task.wait(u1:NextNumber(0.1, 0.15));

        if not (p2:IsDescendantOf(game) and p2:GetAttribute("LovelyLegwork")) then
            return;
        end;

        v5 = v14;
    end;
end;