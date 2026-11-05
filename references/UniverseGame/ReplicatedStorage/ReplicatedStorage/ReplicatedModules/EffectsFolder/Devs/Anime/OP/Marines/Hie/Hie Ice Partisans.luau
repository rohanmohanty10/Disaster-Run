  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), RunService (copy), TweenService (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local Folder = v2.Folder;
    local CanMarkGround = v2.CanMarkGround;
    local u3 = AssetHandler.GetAbilityData(Character);
    local u4 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });
    local u5 = CFrame.Angles(0, 0, -1.5707963267948966);
    Folder.ChildAdded:Connect(function(u6) -- Line: 29
        -- upvalues: AssetHandler (ref), u3 (copy), u5 (copy), ParticleHandler (ref), u4 (copy), RunService (ref), TweenService (ref), EffectsHandler (ref), CanMarkGround (copy)
        local u7 = AssetHandler.CloneAsset("Models/Partisan", u3);
        u7.CFrame = u6.CFrame * u5;
        ParticleHandler.Unusualify(u7, {
            IncludeParts = true,
            IncludeTextures = true,
            HSVData = u4
        });
        u7.Parent = workspace.Effects;

        for _, descendant in u7:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and not descendant.Parent:IsA("Attachment") then
                descendant.LockedToPart = false;
                descendant:Emit(descendant:GetAttribute("EmitCount") or 5);

                if descendant:GetAttribute("Aura") then
                    descendant.Enabled = true;
                end;
            end;
        end;

        local u8 = nil;
        u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 52
            -- upvalues: u6 (copy), u7 (copy), u8 (ref), TweenService (ref), ParticleHandler (ref), EffectsHandler (ref), u3 (ref), u4 (ref), CanMarkGround (ref), u5 (ref)
            if u6:IsDescendantOf(game) and u7:IsDescendantOf(game) then
                u7.CFrame = u7.CFrame:Lerp(u6.CFrame * u5, (math.clamp(p9 * 20, 0, 1)));

                return;
            end;

            u8:Disconnect();
            u8 = nil;

            if u7:IsDescendantOf(game) then
                task.delay(5, u7.Destroy, u7);
                TweenService:Create(u7, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                TweenService:Create(u7.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                ParticleHandler.EnableAllParticles(u7, false);
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Particles/Partisan/Impact",
                    AutoSerialize = true,
                    Origin = u6.CFrame,
                    AbilityName = u3.AbilityName,
                    SkinName = u3.SkinName,
                    HSVShift = u4
                });

                if CanMarkGround then
                    local v10 = RaycastParams.new();
                    v10.FilterType = Enum.RaycastFilterType.Include;
                    v10.FilterDescendantsInstances = { workspace.Map };
                    local v11 = workspace:Raycast(u7.Position, u6.CFrame.LookVector * 4, v10);

                    if v11 then
                        EffectsHandler.CallEffect("Emit Particle V3", {
                            Path = "Particles/Partisan/Mark",
                            AutoSerialize = true,
                            Origin = CFrame.new(v11.Position, v11.Position + v11.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0),
                            AbilityName = u3.AbilityName,
                            SkinName = u3.SkinName,
                            HSVShift = u4
                        });
                    end;
                end;
            end;
        end);
    end);
end;