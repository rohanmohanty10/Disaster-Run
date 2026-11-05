  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.KnitPath.Promise);
require(PathShortcuts.KnitPath.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local u1 = Random.new();

return function(p2) -- Line: 17
    -- upvalues: u1 (copy), ParticleHandler (copy), SoundGroups (copy), TweenService (copy), EffectsHandler (copy)
    local Fireball = p2.Fireball;
    local Hit = p2.Hit;
    local Origin = p2.Origin;
    local Size = p2.Size;
    local UpVector = p2.UpVector;
    local EasingStyle = p2.EasingStyle;
    local EasingDirection = p2.EasingDirection;
    local Time = p2.Time;
    local TimeOffset = p2.TimeOffset;
    local Scale = p2.Scale;
    local Player = p2.Player;

    for _ = 1, p2.Amount do
        task.spawn(function() -- Line: 32
            -- upvalues: TimeOffset (copy), u1 (ref), Origin (copy), Size (copy), UpVector (copy), Fireball (copy), Player (copy), ParticleHandler (ref), SoundGroups (ref), Scale (copy), Time (copy), EasingStyle (copy), EasingDirection (copy), TweenService (ref), Hit (copy), EffectsHandler (ref)
            if TimeOffset then
                task.wait(u1:NextNumber(TimeOffset[1], TimeOffset[2]));
            end;

            local v3 = Origin * CFrame.new(u1:NextNumber(-Size.X / 2, Size.X / 2), 0, u1:NextNumber(-Size.Z / 2, Size.Z / 2));
            local v4 = RaycastParams.new();
            v4.FilterDescendantsInstances = { workspace.Map };
            v4.FilterType = Enum.RaycastFilterType.Include;
            local v5 = workspace:Raycast(v3.Position, Vector3.new(0, -100, 0), v4);

            if not (v5 and v5.Position) then
                return;
            end;

            local u6 = CFrame.new(v5.Position);

            if not u6 then
                return;
            end;

            local v7 = u1:NextNumber(UpVector[1], UpVector[2]);
            local u8 = Fireball:Clone();
            u8.Parent = workspace.Effects;
            u8.CFrame = u6 * CFrame.new(0, v7, 0);
            local u9 = 0;

            if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
                u9 = u9 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
            end;

            if u9 > 0 then
                ParticleHandler.HSVShiftParticles(u8, {
                    HueShift = u9
                });
            end;

            local Sound = u8:FindFirstChild("Sound");
            SoundGroups:AssignSoundTag(Sound);
            local u10 = u1:NextNumber(Scale[1], Scale[2]);
            ParticleHandler.ScaleParticle(u8, u10);
            local v11 = TweenService:Create(u8, TweenInfo.new(u1:NextNumber(Time[1], Time[2]), EasingStyle, EasingDirection), {
                CFrame = u6
            });
            v11:Play();
            v11.Completed:Connect(function() -- Line: 88
                -- upvalues: Sound (copy), Hit (ref), u6 (ref), u9 (ref), ParticleHandler (ref), u10 (copy), EffectsHandler (ref), u8 (copy)
                if Sound then
                    Sound:Play();
                end;

                local v12 = Hit:Clone();
                v12.Parent = workspace.Effects;
                v12.CFrame = u6;

                if u9 > 0 then
                    ParticleHandler.HSVShiftParticles(v12, {
                        HueShift = u9
                    });
                end;

                local v13 = 0.2 * u10;
                ParticleHandler.ScaleParticle(v12, v13);
                local v14 = ParticleHandler.GenerateEmitInfo(v12);
                ParticleHandler.Emit(v12, v14);
                ParticleHandler.DestroyEmit(v12);
                EffectsHandler.CallEffect("Rock Debris", {
                    Lifetime = 1.25,
                    Size = Vector3.new(1.35, 1.35, 1.35),
                    Origin = u6 * CFrame.new(0, 1.5, 0),
                    Radius = v13 * 5,
                    Amount = v13 * 5
                });
                local v15 = ParticleHandler.EnableParticle(u8, false);

                if Sound then
                    v15 = math.max(v15, Sound.TimeLength);
                end;

                task.delay(v15, u8.Destroy, u8);
            end);
        end);
    end;
end;