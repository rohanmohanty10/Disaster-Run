  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local CombatService = require(ReplicatedRoot.Services.CombatService);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
Petal("Util");
Petal("New");
local v2 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = v2.Rng;
local u3 = {};
local u19 = {
    Striker = function(u4, u5) -- Line: 41
        -- upvalues: u3 (copy), Trove (copy), Fusion (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), CombatService (copy)
        if u4 and u4.Parent then
            if u3[u4] then
                return u3[u4];
            end;

            local u6 = {
                Trove = Trove.new()
            };
            u6.Trove:AttachToInstance(u4);
            u6.Targets = {};
            u6.Looping = false;
            local u7 = Fusion.Value(u4.Position);
            local u8 = Fusion.Spring(u7, 35, 0.6);
            u6.Trove:Connect(u4:GetPropertyChangedSignal("Position"), function() -- Line: 54
                -- upvalues: u7 (ref), u4 (copy)
                u7:set(u4.Position);
            end);
            local u9 = AssetHandler.CloneAsset("Particles/Manifest/Construct", AssetHandler.GetAbilityData(u5.Character));
            local Construct = u9.Construct;
            Construct.Position = u7:get();
            ParticleHandler.Unusualify(Construct, {
                IncludeParts = true,
                Character = u5.Character
            });
            Fusion.Hydrate(Construct)({
                Anchored = true,
                CanCollide = false,
                Position = u8
            });
            u9.Parent = workspace.Effects;
            u6.Object = Construct;

            function u6.Destroy(p10) -- Line: 73
                -- upvalues: EffectsHandler (ref), Construct (ref), u5 (copy), u6 (copy), u9 (copy), u3 (ref), u4 (copy), u7 (ref), u8 (ref)
                if p10.Destroyed then
                    return;
                end;

                p10.Destroyed = true;
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Particles/Convergence/OrbDestroy",
                    AutoSerialize = true,
                    Scale = 1.6,
                    ScaleLifetime = 1,
                    BypassRenderCap = true,
                    Origin = CFrame.new(Construct.Position),
                    Character = u5.Character
                });

                if u6.Trove then
                    u6.Trove:Destroy();
                end;

                if u9 then
                    u9:Destroy();
                end;

                if u3[u4] and u3[u4] == u6 then
                    table.clear(u6);
                    table.freeze(u6);
                    u3[u4] = nil;
                    Construct = nil;
                    u7 = nil;
                    u8 = nil;
                    print("Destroyed construct");
                end;
            end;

            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/Manifest/ConstructSummon",
                AutoSerialize = true,
                Scale = 0.9,
                ScaleLifetime = 1,
                Origin = CFrame.new(Construct.Position),
                Character = u5.Character
            });
            EffectsHandler.CallEffect("Play Sound At", {
                Object = CombatService.FetchSound(u5.Character, "Construct 1 Ambience"),
                AttachTo = Construct
            });
            u3[u4] = u6;
            u6.Trove:Add(u6);

            return u6;
        end;
    end,

    Stationary = function(u11, u12) -- Line: 126
        -- upvalues: u3 (copy), Trove (copy), Fusion (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), CombatService (copy)
        if u11 and u11.Parent then
            if u3[u11] then
                return u3[u11];
            end;

            local u13 = {
                Trove = Trove.new()
            };
            u13.Trove:AttachToInstance(u11);
            u13.Targets = {};
            u13.Looping = false;
            local u14 = Fusion.Spring(Fusion.Value(0), 10, 0.6);
            local u15 = AssetHandler.CloneAsset("Particles/Manifest/Construct2", AssetHandler.GetAbilityData(u12.Character));
            local Construct2 = u15.Construct2;
            Construct2.Position = u11.Position;
            ParticleHandler.Unusualify(Construct2, {
                IncludeParts = true,
                Character = u12.Character
            });
            Fusion.Hydrate(Construct2)({
                Anchored = true,
                CanCollide = false
            });
            u15.Parent = workspace.Effects;
            local TriJoint = Construct2:FindFirstChild("TriJoint");

            if TriJoint then
                local HaloJoint = Construct2:FindFirstChild("HaloJoint");
                local C1 = TriJoint.C1;
                Fusion.Hydrate(TriJoint)({
                    C1 = Fusion.Computed(function() -- Line: 156
                        -- upvalues: C1 (copy), u14 (ref)
                        return C1 * (u14 and CFrame.new(0, 0, u14:get()) or CFrame.identity);
                    end)
                });
                local C12 = HaloJoint.C1;
                Fusion.Hydrate(HaloJoint)({
                    C1 = Fusion.Computed(function() -- Line: 163
                        -- upvalues: C12 (copy), u14 (ref)
                        return C12 * (u14 and CFrame.new(0, 0, u14:get() * 0.8) or CFrame.identity);
                    end)
                });
            end;

            u13.Object = Construct2;
            u13.MotorSpring = u14;

            function u13.Action(p16, p17) -- Line: 172
                -- upvalues: EffectsHandler (ref), Construct2 (ref), u12 (copy), u14 (ref), CombatService (ref)
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Particles/Manifest/BeamShoot",
                    AutoSerialize = true,
                    Scale = 1.15,
                    ScaleLifetime = 1,
                    BypassRenderCap = true,
                    Origin = CFrame.new(Construct2.Position) * CFrame.Angles(1.5707963267948966, 0, 0),
                    Character = u12.Character
                });

                if u14 then
                    u14:addVelocity(1.25);
                end;

                EffectsHandler.CallEffect("Play Sound At", {
                    Object = CombatService.FetchSound(u12.Character, "Construct 2 Shoot"),
                    AttachTo = Construct2
                });
                task.wait(p17.Delay or 0.3);
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Particles/Manifest/BeamStrike",
                    AutoSerialize = true,
                    Scale = 1,
                    ScaleLifetime = 1,
                    BypassRenderCap = true,
                    Origin = CFrame.new(p17.AttackPosition),
                    Character = u12.Character
                });
                EffectsHandler.CallEffect("Play Sound At", {
                    Object = CombatService.FetchSound(u12.Character, "Construct 2 Shoot Impact"),
                    Origin = CFrame.new(p17.AttackPosition)
                });
            end;

            function u13.Destroy(p18) -- Line: 210
                -- upvalues: EffectsHandler (ref), u13 (copy), u12 (copy), u15 (copy), u3 (ref), u11 (copy), Construct2 (ref), u14 (ref)
                if p18.Destroyed then
                    return;
                end;

                p18.Destroyed = true;
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Particles/Convergence/OrbDestroy",
                    AutoSerialize = true,
                    Scale = 1.5,
                    ScaleLifetime = 1,
                    BypassRenderCap = true,
                    Origin = CFrame.new(u13.Object.Position),
                    Character = u12.Character
                });

                if u13.Trove then
                    u13.Trove:Destroy();
                end;

                if u15 then
                    u15:Destroy();
                end;

                if u3[u11] and u3[u11] == u13 then
                    table.clear(u13);
                    table.freeze(u13);
                    u3[u11] = nil;
                    Construct2 = nil;
                    u14 = nil;
                    print("Destroyed construct");
                end;
            end;

            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/Manifest/ConstructSummon",
                AutoSerialize = true,
                Scale = 0.9,
                ScaleLifetime = 1,
                Origin = CFrame.new(Construct2.Position),
                Character = u12.Character
            });
            EffectsHandler.CallEffect("Play Sound At", {
                Object = CombatService.FetchSound(u12.Character, "Construct 2 Ambience"),
                AttachTo = Construct2
            });
            u3[u11] = u13;
            u13.Trove:Add(u13);

            return u13;
        end;
    end
};

return function(p20, p21) -- Line: 262
    -- upvalues: u19 (copy), u3 (copy)
    local v22 = p21.Type or "Striker";
    local v23 = u19[v22];

    if typeof(p21) == "table" then
        v23(p20, p21);
    elseif p21 == false then
        v23(p20, p21):Destroy();
    end;

    if p21.ActionData and (u3[p20] and u3[p20].Looping) then
        local v24 = u3[p20];

        if v24.Action then
            v24.Action(v24, p21.ActionData);
        end;

        return;
    end;

    local v25 = 0;

    if u3[p20] and not u3[p20].Looping then
        u3[p20].Looping = true;
        local v26 = u3[p20];

        while p20 and p20.Parent do
            local v27 = task.wait();

            if not (next(u3) and (v26 and v26.Object)) then
                break;
            end;

            if v22 == "Striker" then
                local Object = v26.Object;
                Object.CFrame = Object.CFrame * CFrame.Angles(0, v27 * 4, 0);
            elseif v22 == "Stationary" and v26.Object.Parent then
                v26.Object.CFrame = v26.Object.CFrame:Lerp(CFrame.new(p20.Position) * CFrame.Angles(0, math.rad(v25 * 90), 0) * v26.Object.PivotOffset:Inverse(), 0.25);
                local TriJoint = v26.Object.TriJoint;
                TriJoint.C0 = TriJoint.C0 * CFrame.Angles(0, 0, (math.rad(v27 * -180)));
            end;

            v25 = v25 + v27;
        end;

        print("Ended");
    end;
end;