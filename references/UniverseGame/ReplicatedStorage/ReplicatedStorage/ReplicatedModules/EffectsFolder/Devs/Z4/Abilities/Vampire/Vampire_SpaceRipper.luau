  

 

local TweenService = game:GetService("TweenService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

return function(p2, p3, p4) -- Line: 18
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy), u1 (copy)
    local Head = p2:FindFirstChild("Head");
    local identity = CFrame.identity;
    local v5 = Trove.new();
    v5:AttachToInstance(p2);
    local u6 = {};

    for i = 1, 2 do
        local v7 = CFrame.new(i == 2 and -0.15 or 0.15, 0.2, -0.5);
        u6[i] = AssetHandler.CloneAsset("Particles/SpaceRipper/Beam", p3);
        ParticleHandler.Unusualify(u6[i], {
            HSVData = p4
        });
        u6[i].Parent = workspace.Effects;
        u6["Ashes_" .. i] = AssetHandler.CloneAsset("Particles/SpaceRipper/Ashes", p3);
        ParticleHandler.Unusualify(u6["Ashes_" .. i], {
            HSVData = p4
        });
        u6["Ashes_" .. i].Parent = workspace.Effects;
        u6["Weld_" .. i] = v5:Add(ParticleHandler.AttachTo(u6[i], {
            MakePartP0 = true,
            Part = p2:FindFirstChild("Head"),
            Offset = v7
        }));
        ParticleHandler.EnableParticleBeams(u6[i], true);
        ParticleHandler.EnableParticle(u6[i].Effect, true);
        ParticleHandler.EnableParticle(u6[i].Attachment2.Star, true);
        v5:Add(function() -- Line: 56
            -- upvalues: u6 (copy), i (copy), TweenService (ref), ParticleHandler (ref)
            if u6["Weld_" .. i] then
                u6["Weld_" .. i]:Destroy();
            end;

            if u6[i]:IsDescendantOf(game) then
                u6[i].Anchored = true;
                local v8 = next;
                local v9, v10 = u6[i]:GetDescendants();

                for _, v in v8, v9, v10 do
                    if v:IsA("Beam") then
                        TweenService:Create(v, TweenInfo.new(0.3), {
                            Width0 = 0,
                            Width1 = 0
                        }):Play();
                    end;
                end;

                ParticleHandler.EnableParticle(u6[i], false);
                ParticleHandler.DestroyEmit(u6[i]);
            end;

            ParticleHandler.EnableAllParticles(u6["Ashes_" .. i], false);
            ParticleHandler.DestroyEmit(u6["Ashes_" .. i]);
        end);
    end;

    while p2.Parent and p2:GetAttribute("SpaceRipper") do
        for i = 1, 2 do
            local v11 = u6[i];
            local v12 = u6["Ashes_" .. i];
            local v13 = workspace:Raycast(Head.Position, Head.CFrame.LookVector * 100, u1);

            if v13 then
                v11.Attachment2.CFrame = CFrame.new(0, 0, -(Head.Position - v13.Position).Magnitude) * CFrame.Angles(0, 1.5707963267948966, 0);
                v12.CFrame = CFrame.new(v13.Position, v13.Position + v13.Normal) * CFrame.Angles(0, -1.5707963267948966, 0);
                ParticleHandler.EnableAllParticles(v12, true);
                identity = v12.CFrame;
            else
                ParticleHandler.EnableAllParticles(v12, false);
                v12.CFrame = identity;
            end;
        end;

        task.wait();
    end;

    v5:Destroy();
end;