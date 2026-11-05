  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(u2) -- Line: 8
    -- upvalues: u1 (copy), RunService (copy), EffectsHandler (copy)
    if not u2 then
        return;
    end;

    local u3 = {};

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("Bone") then
            u3[descendant] = {
                Speed = Vector3.new(10, 10, 10),
                Original = descendant.Transform,
                TimeOffset = math.random() * 3.141592653589793 * 2,
                Amplitude = Vector3.new(1, 1, 1) * u1:NextNumber(0.2, 0.35)
            };
        end;
    end;

    local function WaveOffset(p4, p5, p6, p7) -- Line: 24
        return math.sin(p4 * p6 + p5) * p7;
    end;

    local u8 = os.clock();
    local u9 = nil;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 30
        -- upvalues: u2 (copy), u9 (ref), u3 (copy), u8 (ref), EffectsHandler (ref), u1 (ref)
        if u2 and (u2.Parent and u2.Transparency ~= 1) then
            for i, v in u3 do
                local v11 = tick();
                local X = v.Amplitude.X;
                local v12 = math.sin(v11 * v.Speed.X + v.TimeOffset) * X;
                local v13 = tick();
                local Y = v.Amplitude.Y;
                local v14 = math.sin(v13 * v.Speed.Y + (v.TimeOffset + 1)) * Y;
                local v15 = tick();
                local Z = v.Amplitude.Z;
                local v16 = math.sin(v15 * v.Speed.Z + (v.TimeOffset + 2)) * Z;
                local v17 = Vector3.new(v12, v14, v16);
                i.Transform = v.Original * CFrame.new(v17);
            end;

            if os.clock() - u8 >= 0.04 then
                u8 = os.clock();
                local v18 = EffectsHandler.CallEffect("Bubble Distortion", {
                    Time = 0.1,
                    Origin = u2.CFrame,
                    StartSize = u2.Size,
                    EndSize = u2.Size * u1:NextNumber(1.15, 1.5),
                    Transparency = u1:NextNumber(5, 10)
                });
                v18.Anchored = false;
                v18.Massless = true;
                local Weld = Instance.new("Weld");
                Weld.Part0 = v18;
                Weld.Part1 = u2;
                Weld.Parent = v18;
            end;

            return;
        end;

        u9:Disconnect();
        u9 = nil;
    end);
end;