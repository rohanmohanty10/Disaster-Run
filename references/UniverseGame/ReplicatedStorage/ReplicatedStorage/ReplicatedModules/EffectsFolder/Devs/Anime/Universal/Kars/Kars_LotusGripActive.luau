  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3) -- Line: 11
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), RunService (copy), TweenService (copy), EffectsHandler (copy)
    local u4 = p3 or {};
    local v5 = u4.TrailPath or "Particles/LotusGrip/Trail";
    local u6 = u4.BeamPath or "Particles/LotusGrip/SpeedBeams";
    local v7 = u4.AbilityName or "Kars";

    if not p1 then
        return;
    end;

    if p2 then
        local Folder = Instance.new("Folder");
        Folder.Name = "Lotus Grip FX";
        Folder.Parent = p1;
        local _ = p1.HumanoidRootPart;
        local Torso = p1.Torso;
        local u8 = AssetHandler.GetAbilityData(p1);
        u8.Name = v7;
        local u9 = 0;
        local u10 = {};
        local u11 = 12.566370614359172;

        for i = 1, 4 do
            local v12 = u9 + i / 4 * 6.283185307179586;
            local v13 = AssetHandler.CloneAsset(v5, u8);
            v13.CFrame = CFrame.new(Torso.Position) * CFrame.new(math.cos(v12) * 15, 0, -math.sin(v12) * 15);
            v13.Parent = Folder;
            table.insert(u10, v13);
        end;

        local u14 = ParticleHandler.GetUnusualHSVData({
            Character = p1
        });

        if u14 ~= nil then
            for _, v in u10 do
                ParticleHandler.HSVShiftModel({ v }, u14);
                ParticleHandler.Unusualify(v, {
                    HSVData = u14
                });
            end;
        end;

        local u15 = nil;
        local u16 = os.clock();
        local u17 = nil;
        u17 = RunService.RenderStepped:Connect(function(p18) -- Line: 64
            -- upvalues: Folder (copy), u17 (ref), u4 (ref), u11 (ref), u16 (copy), u9 (ref), u10 (copy), TweenService (ref), Torso (copy)
            if not Folder:IsDescendantOf(game) then
                u17:Disconnect();
                u17 = nil;

                return;
            end;

            if not u4.BypassRPSUpdate then
                local v19 = 3.141592653589793 * (os.clock() - u16) * 2.5;
                u11 = math.min(v19, 20);
            end;

            u9 = u9 + u11 * p18 % 6.283185307179586;

            for i, v in u10 do
                local v20 = u9 + i / #u10 * 6.283185307179586;
                TweenService:Create(v, TweenInfo.new(p18, Enum.EasingStyle.Linear), {
                    CFrame = CFrame.new(Torso.Position) * CFrame.new(math.cos(v20) * 15, 0, -math.sin(v20) * 15)
                }):Play();
            end;
        end);
        task.delay(0.4, function() -- Line: 94
            -- upvalues: u15 (ref), AssetHandler (ref), u6 (copy), u8 (copy), u14 (copy), ParticleHandler (ref), Folder (copy), Torso (copy), EffectsHandler (ref)
            u15 = AssetHandler.CloneAsset(u6, u8);

            if u14 ~= nil then
                ParticleHandler.Unusualify(u15, {
                    HSVData = u14
                });
            end;

            u15.Parent = Folder;
            ParticleHandler.AttachTo(u15.PrimaryPart, {
                Part = Torso,
                Offset = CFrame.Angles(0, 0, 1.5707963267948966)
            });
            EffectsHandler.CallEffect("FadeBeams", u15, {
                FadeIn = true,
                Time = 1
            });
        end);
    else
        local v21 = p1:FindFirstChild("Lotus Grip FX");

        if v21 then
            task.delay(ParticleHandler.EnableAllParticles(v21, false), v21.Destroy, v21);
        end;
    end;
end;