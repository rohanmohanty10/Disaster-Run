  

 

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
local v2 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local Rng = v2.Rng;
local _ = Fusion.New;
local u3 = {};

local function Quad(p4, p5, p6, p7) -- Line: 65
    return (1 - p7) ^ 2 * p4 + 2 * (1 - p7) * p7 * p5 + p7 ^ 2 * p6;
end;

local function CreateEntry(u8) -- Line: 69
    -- upvalues: u3 (copy), Trove (copy)
    if u8 and u8.Parent then
        if u3[u8] then
            return u3[u8];
        end;

        local u9 = {
            Trove = Trove.new()
        };
        u9.Trove:AttachToInstance(u8);
        u9.Character = u8;
        u9.Orbs = {};
        u9.Looping = false;

        function u9.Destroy(p10) -- Line: 80
            -- upvalues: u9 (copy), u3 (ref), u8 (copy)
            if u9.Trove then
                u9.Trove:Destroy();
            end;

            if u3[u8] and u3[u8] == u9 then
                table.clear(u9);
                table.freeze(u9);
                u3[u8] = nil;
                print("Destroyed cache entry");
            end;
        end;

        u3[u8] = u9;

        return u9;
    end;
end;

local function CreateOrb(p11, p12, u13) -- Line: 97
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), CombatService (copy)
    if not (p11.Orbs and p11.Orbs[p12]) then
        local Character = p11.Character;
        AssetHandler.GetAbilityData(Character);
        local u14 = AssetHandler.CloneAsset(`Particles/Convergence/{u13.True and "ConvergenceOrbTrue" or "ConvergenceOrb"}`, AssetHandler.GetAbilityData(p11.Character));

        if not u13.True then
            ParticleHandler.Unusualify(u14, {
                IncludeParts = true,
                HSVData = u13.HSVData
            });

            if u13.HSVData and u13.HSVData.Chroma then
                ParticleHandler.Chromaify(u14, {
                    Character = Character
                });
            end;
        end;

        u14.Size = Vector3.new(1.28875, 1.44125, 1.22625) * u13.Factor;
        u14.TrailAttach1.Position = Vector3.new(1, 0, 0) * -u14.Size.X / 3;
        u14.TrailAttach2.Position = Vector3.new(1, 0, 0) * u14.Size.X / 3;
        u14.Parent = workspace.Effects;
        ParticleHandler.ScaleParticle(u14, u13.Factor * 0.5);
        task.defer(function() -- Line: 137
            -- upvalues: EffectsHandler (ref), u14 (ref), Character (ref), u13 (copy), CombatService (ref)
            task.wait();
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/Convergence/OrbSummon",
                AutoSerialize = true,
                Origin = u14.CFrame,
                Character = Character,
                Scale = u13.Factor * 0.8
            });
            EffectsHandler.CallEffect("Play Sound At", {
                Object = CombatService.FetchSound(Character, "Convergence Orb Ambience"),
                AttachTo = u14
            });
        end);
        local u15 = {
            Object = u14,
            Info = u13,
            Locked = false
        };

        function u15.Destroy(u16) -- Line: 158
            -- upvalues: EffectsHandler (ref), Character (ref), u13 (copy), u14 (ref), u15 (copy)
            task.spawn(function() -- Line: 159
                -- upvalues: EffectsHandler (ref), u16 (copy), Character (ref), u13 (ref)
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Particles/Convergence/OrbDestroy",
                    AutoSerialize = true,
                    Origin = u16.Object.CFrame,
                    Character = Character,
                    Scale = u13.Factor * 1
                });
            end);
            u14:Destroy();
            u14 = nil;
            Character = nil;
            u15.Object = nil;
        end;

        p11.Trove:Add(function() -- Line: 175
            -- upvalues: u15 (copy)
            if not u15.Locked then
                u15:Destroy();
            end;
        end);
        p11.Orbs[p12] = u15;

        return u15;
    end;

    warn("Orb already created");
end;

local function ShootOrb(p17, p18, p19) -- Line: 186
    -- upvalues: Rng (copy)
    if p17.Orbs and not p17.Orbs[p18] then
        warn("No orb for", p18);

        return;
    end;

    local Target = p19.Target;
    local Duration = p19.Duration;
    local _ = p17.Character;
    local u20 = p17.Orbs[p18];
    p17.Orbs[p18] = nil;
    u20.Locked = true;
    task.spawn(function() -- Line: 201
        -- upvalues: Target (copy), u20 (copy), Rng (ref), Duration (copy)
        local HumanoidRootPart = Target.HumanoidRootPart;
        local Position = u20.Object.Position;
        local v21 = HumanoidRootPart and (vector.magnitude(Position - HumanoidRootPart.Position) or 5) or 5;
        local v22 = Rng(-v21 / 5, v21 / 5);
        local v23 = 0;

        while v23 < Duration do
            v23 = v23 + task.wait();

            if not (Target and (Target.Parent and (HumanoidRootPart and HumanoidRootPart.Parent))) then
                break;
            end;

            local v24 = Position:Lerp(HumanoidRootPart.Position, 0.5) + Vector3.new(v22, 10, 0);
            local v25 = v23 / Duration;
            u20.Object.Position = (1 - v25) ^ 2 * Position + 2 * (1 - v25) * v25 * v24 + v25 ^ 2 * HumanoidRootPart.Position;
        end;

        u20:Destroy();
    end);

    if not next(p17.Orbs) then
        p17:Destroy();
    end;
end;

return function(p26, p27) -- Line: 229
    -- upvalues: u3 (copy), CreateEntry (copy), CreateOrb (copy), ShootOrb (copy)
    if typeof(p27) == "boolean" and p27 == false then
        if u3[p26] then
            u3[p26]:Destroy();
        end;

        return;
    end;

    debug.setmemorycategory("Delta Convergence Orb");

    if p27.Instruction == 1 then
        CreateOrb(CreateEntry(p26), p27.Id, p27.Info);
    else
        ShootOrb(CreateEntry(p26), p27.Id, p27.Info);
    end;

    if u3[p26] and (#u3[p26].Orbs > 0 and u3[p26].Looping == false) then
        u3[p26].Looping = true;
        local v28 = 0;

        while p26 and (p26.Parent and (u3[p26] and u3[p26].Looping)) do
            v28 = v28 + task.wait();

            if not u3[p26] then
                break;
            end;

            for i, v in u3[p26].Orbs do
                local v29 = (i - 1) * 3.141592653589793 * 2 / 3;
                local v30 = os.clock() * 2 * (i / 2);

                if v.Object then
                    local Object = v.Object;
                    local new = CFrame.new;
                    local Position = p26.HumanoidRootPart.Position;
                    local v31 = math.cos(v30) * 5;
                    local v32 = math.cos(v29 + v30) * 3 + 1;
                    local v33 = math.sin(v30) * 5;
                    Object.CFrame = new(Position + Vector3.new(v31, v32, v33)) * CFrame.Angles(v28, 0, v28 / 2);
                end;
            end;
        end;

        print("Destroyed");
    end;
end;