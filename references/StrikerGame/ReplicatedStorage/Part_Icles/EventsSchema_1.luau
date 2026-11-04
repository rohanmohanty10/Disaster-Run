 
 

local TypeRegistry = require(script.Parent.TypeRegistry);
local HitFilter = require(script.Parent.HitFilter);
local u1 = {};
local u2 = { "OnEmit", "OnDeath", "OnDestruction", "OnHit" };
u1.EVENT_NAMES = u2;
u1.EVENTS_FOLDER_NAME = "Events";
local u3 = {
    AtPosition = true,
    AtSource = true,
    AtTarget = true,
    AtCFrame = true
};
u1.EMIT_MODES = u3;
u1.EMIT_MODE_HINTS = {
    AtPosition = "Spawns where the event happened (emit, death or hit point).",
    AtSource = "Spawns at the source emitter\'s current position.",
    AtTarget = "Spawns at the target\'s own authored placement.",
    AtCFrame = "Spawns at the event position and rotation."
};
local u4 = {
    Off = true,
    Kill = true,
    Stop = true,
    Bounce = true
};
u1.COLLISION_MODES = u4;

function u1.clampChainDepth(p5) -- Line: 33
    local v6 = tonumber(p5);

    if not v6 then
        return 4;
    end;

    local math_floor_ret = math.floor(v6);

    return math.clamp(math_floor_ret, 1, 32);
end;

function u1.safeEmitMode(p7) -- Line: 39
    -- upvalues: u3 (copy)
    return (type(p7) ~= "string" or not u3[p7]) and "AtPosition" or p7;
end;

function u1.safeCollisionMode(p8) -- Line: 44
    -- upvalues: u4 (copy)
    return (type(p8) ~= "string" or not u4[p8]) and "Off" or p8;
end;

function u1.clampUnit(p9, p10, p11, p12) -- Line: 49
    local v13 = tonumber(p9);

    if not v13 then
        return p12;
    end;

    if v13 < p10 then
        return p10;
    end;

    if p11 < v13 then
        return p11;
    end;

    return v13;
end;

local u14 = {
    Part = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    Beam = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Attachment = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    Model = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    PointLight = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Sound = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Highlight = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    TrailEmitter = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Atmosphere = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Blur = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Bloom = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    ColorCorrection = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    ImageLabel = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Lightning = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    CameraShake = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Rocks = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    Rope = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Distortion = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    }
};
local u15 = {
    Enabled = false,
    EmitMode = "AtPosition",
    ScriptEnabled = false,
    ChainDepthLimit = 4,
    Collision = "Off",
    Bounciness = 0.7,
    Friction = 0.2,
    Spin = 0.5,
    HitCheckInterval = 0
};

local function getConfig(p16) -- Line: 209
    -- upvalues: TypeRegistry (copy)
    if not p16 then
        return nil;
    end;

    local TypeFor = TypeRegistry.getTypeFor(p16);

    if TypeFor and not TypeFor.directAccess then
        return TypeRegistry.getConfig(p16);
    end;

    return nil;
end;

local function getTypeName(p17) -- Line: 216
    -- upvalues: TypeRegistry (copy)
    local _, v18 = TypeRegistry.getTypeFor(p17);

    return v18;
end;

function u1.read(p19) -- Line: 223
    -- upvalues: TypeRegistry (copy)
    local v20;

    if p19 then
        local TypeFor = TypeRegistry.getTypeFor(p19);

        if TypeFor and not TypeFor.directAccess then
            v20 = TypeRegistry.getConfig(p19);
        else
            v20 = nil;
        end;
    else
        v20 = nil;
    end;

    if not v20 then
        return nil;
    end;

    local Events = v20:FindFirstChild("Events");

    if Events and Events:IsA("Folder") then
        return Events;
    end;

    return nil;
end;

function u1.isValidForItem(p21, p22) -- Line: 234
    -- upvalues: TypeRegistry (copy), u1 (copy)
    local _, v23 = TypeRegistry.getTypeFor(p21);

    if v23 then
        return u1.isValidForTypeName(v23, p22);
    end;

    return false;
end;

function u1.isValidForTypeName(p24, p25) -- Line: 244
    -- upvalues: u14 (copy)
    local v26 = u14[p24];

    return v26 and v26[p25] == true and true or false;
end;

function u1.emitCapabilityReason(p27) -- Line: 252
    -- upvalues: u1 (copy)
    if not p27 then
        return "no target";
    end;

    if p27:IsA("Folder") then
        for _, child in ipairs(p27:GetChildren()) do
            if u1.emitCapabilityReason(child) == nil then
                return nil;
            end;
        end;

        return "the folder holds nothing with a position";
    end;

    if p27:GetAttribute("Transformed") and (p27:GetAttribute("EmissionMode") or "Emit") == "Animate" then
        return "Animate-mode targets animate their own instance";
    end;

    if p27:IsA("BasePart") or (p27:IsA("Attachment") or (p27:IsA("Model") or p27:IsA("ParticleEmitter"))) then
        return nil;
    end;

    return p27.ClassName .. " has no position to move";
end;

function u1.emitCapability(p28) -- Line: 269
    -- upvalues: u1 (copy)
    return u1.emitCapabilityReason(p28) == nil;
end;

function u1.readEvent(p29, p30) -- Line: 274
    -- upvalues: u1 (copy)
    local v31 = u1.read(p29);

    if not v31 then
        return nil;
    end;

    local v32 = v31:FindFirstChild(p30);

    if v32 and v32:IsA("Configuration") then
        return v32;
    end;

    return nil;
end;

function u1.readEnabled(p33) -- Line: 302
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    local v34 = u1.read(p33);

    if not v34 then
        return nil;
    end;

    local v35 = nil;

    for _, v in ipairs(u2) do
        if u1.isValidForItem(p33, v) then
            local v36 = v34:FindFirstChild(v);

            if v36 and (v36:IsA("Configuration") and (v36:GetAttribute("Enabled") == true and not v36:GetAttribute("ImportedUntrusted"))) then
                local EmitTarget = v36:FindFirstChild("EmitTarget");
                local v37 = v36:GetAttribute("ScriptEnabled") == true;
                local v38;

                if v37 then
                    v38 = v36:FindFirstChild("Module") or nil;
                else
                    v38 = nil;
                end;

                if v38 and not v38:IsA("ModuleScript") then
                    v38 = nil;
                end;

                v35 = v35 or {};
                local v39 = {
                    Enabled = true,
                    EventName = v
                };
                local Attribute = v36:GetAttribute("EmitMode");
                v39.EmitMode = (type(Attribute) ~= "string" or not u3[Attribute]) and "AtPosition" or Attribute;
                v39.ScriptEnabled = v37;
                local Attribute2 = v36:GetAttribute("ChainDepthLimit");
                local v40 = tonumber(Attribute2);
                local v41;

                if v40 then
                    local math_floor_ret = math.floor(v40);
                    v41 = math.clamp(math_floor_ret, 1, 32);
                else
                    v41 = 4;
                end;

                v39.ChainDepthLimit = v41;
                v39.EmitTarget = EmitTarget and (EmitTarget:IsA("ObjectValue") and EmitTarget.Value) or nil;
                v39.Module = v38;
                local Attribute3 = v36:GetAttribute("Collision");
                v39.Collision = (type(Attribute3) ~= "string" or not u4[Attribute3]) and "Off" or Attribute3;
                local Attribute4 = v36:GetAttribute("Bounciness");
                local v42 = tonumber(Attribute4);
                v39.Bounciness = not v42 and 0.7 or (v42 < 0 and 0 or (v42 > 1 and 1 or v42));
                local Attribute5 = v36:GetAttribute("Friction");
                local v43 = tonumber(Attribute5);
                v39.Friction = not v43 and 0.2 or (v43 < 0 and 0 or (v43 > 1 and 1 or v43));
                local Attribute6 = v36:GetAttribute("Spin");
                local v44 = tonumber(Attribute6);
                v39.Spin = not v44 and 0.5 or (v44 < 0 and 0 or (v44 > 2 and 2 or v44));
                local Attribute7 = v36:GetAttribute("HitCheckInterval");
                local v45 = tonumber(Attribute7);
                v39.HitCheckInterval = not v45 and 0 or (v45 < 0 and 0 or (v45 > 0.5 and 0.5 or v45));
                v35[v] = v39;
            end;
        end;
    end;

    return v35;
end;

function u1.ensure(p46) -- Line: 344
    -- upvalues: TypeRegistry (copy)
    local v47;

    if p46 then
        local TypeFor = TypeRegistry.getTypeFor(p46);

        if TypeFor and not TypeFor.directAccess then
            v47 = TypeRegistry.getConfig(p46);
        else
            v47 = nil;
        end;
    else
        v47 = nil;
    end;

    if not v47 then
        return nil;
    end;

    local Events = v47:FindFirstChild("Events");

    if Events and Events:IsA("Folder") then
        return Events;
    end;

    if Events then
        Events.Parent = nil;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "Events";
    Folder.Parent = v47;

    return Folder;
end;

function u1.ensureEvent(p48, p49) -- Line: 361
    -- upvalues: u1 (copy), u15 (copy)
    if not u1.isValidForItem(p48, p49) then
        return nil;
    end;

    local v50 = u1.ensure(p48);

    if not v50 then
        return nil;
    end;

    local v51 = v50:FindFirstChild(p49);

    if v51 and v51:IsA("Configuration") then
        return v51;
    end;

    if v51 then
        v51.Parent = nil;
    end;

    local Configuration = Instance.new("Configuration");
    Configuration.Name = p49;

    for i, v in pairs(u15) do
        Configuration:SetAttribute(i, v);
    end;

    local ObjectValue = Instance.new("ObjectValue");
    ObjectValue.Name = "EmitTarget";
    ObjectValue.Value = nil;
    ObjectValue.Parent = Configuration;
    local ModuleScript = Instance.new("ModuleScript");
    ModuleScript.Name = "Module";
    ModuleScript.Source = "--[[\n\tPart-Icles event script.\n\n\tThis function runs once every time this event happens to ONE particle.\n\t`payload` describes that particle and gives you functions to change it.\n\tThe script only runs while the event\'s \"Script\" toggle is on. Errors show in\n\tthe Output window and never stop the effect.\n\tKeep the last three lines: the file must return a function that takes `payload`.\n]]\n\n-- WHEN DOES THIS RUN?\n--   OnEmit         the particle was just created\n--   OnHit          the particle touched something (Part / Attachment / Model / Lightning / Rocks emitters only)\n--   OnDeath        the particle\'s lifetime ran out, or something killed it\n--   OnDestruction  the particle is removed for good (after its Linger time, if it has one)\n\n-- QUICK EXAMPLE  (OnDeath: spawn a second effect only if the particle lived longer than a second)\n--   return function(payload)\n--       if payload.Age > 1 then\n--           payload.Emit(workspace.Sparks, \"AtPosition\")\n--       end\n--   end\n\n-- ============================================================================\n--  THINGS YOU CAN READ  (plain values; changing them does nothing)\n-- ============================================================================\n--   In every event\n--     payload.Source            the emitter you set up in the plugin (the original)\n--     payload.Particle          the copy flying around right now (nil for Camera Shake / Distortion)\n--     payload.WorldPosition     where the particle is, as a Vector3 (nil for screen effects)\n--     payload.WorldCFrame       the same with rotation, as a CFrame (nil for screen effects)\n--     payload.LifeTime          how many seconds the particle is set to live\n--     payload.LifeProgress      0 = just born, 1 = about to die\n--     payload.TimeRemaining     seconds left before it dies on its own\n--     payload.StartTime         os.clock() at the moment it was created\n--     payload.SpeedMultiplier   current speed scale (1 = normal; bounces lower it)\n--     payload.ChainDepth        0 normally; 1, 2, ... when this particle was itself spawned by an event\n--     payload.RenderTemplate    old name for payload.Particle\n--\n--   OnEmit only\n--     payload.EmitPosition      same as WorldPosition\n--     payload.EmitIndex         which particle of the burst this is (1 = first)\n--     payload.EmitCount         how many particles the burst made (nil for a single emit)\n--\n--   OnHit only\n--     payload.HitInstance       the part it touched (payload.Other is the same thing)\n--     payload.HitPosition       the exact contact point (Vector3)\n--     payload.HitNormal         the direction the surface faces at that point (Vector3, length 1)\n--\n--   OnDeath only\n--     payload.DeathPosition     same as WorldPosition\n--     payload.Age               how many seconds it really lived (less than LifeTime when killed early)\n--\n--   OnDestruction only\n--     payload.DeathPosition     same as WorldPosition\n--     payload.LingerElapsed     seconds spent in Linger before removal (0 without Linger)\n\n-- ============================================================================\n--  THINGS YOU CAN DO  (functions; they change this one particle only)\n-- ============================================================================\n--   Spawn and end\n--     payload.Emit(target, mode)      fire another emitter from here. target = an emitter, a Folder or a\n--                                     Model of emitters. mode = \"AtPosition\" | \"AtSource\" | \"AtTarget\" |\n--                                     \"AtCFrame\"; leave it out to use this event\'s Mode dropdown\n--     payload.Kill()                  remove the particle now (OnDeath does not fire for it)\n--     payload.Resurrect()             cancel a Kill made earlier in this same script\n--\n--   Look\n--     payload.SetColor(color3)        set the colour and stop the Color graph from changing it\n--     payload.SetTransparency(0..1)   set the transparency and stop the Transparency graph\n--     payload.SetSize(size)           set the size and stop the Size graph (Vector3; UDim2 for ImageLabel)\n--     payload.SetSkipColor(true)      stop only the graph, keep the current value (false resumes it)\n--     payload.SetSkipTransparency(true)\n--     payload.SetSkipSize(true)       Parts only\n--\n--   Time\n--     payload.SetLifetime(seconds)    new total lifetime, counted from birth (a tiny value = dies next frame)\n--     payload.Pause(seconds)          freeze the particle for that long, then continue\n--     payload.FreezeTime(true)        freeze until you call FreezeTime(false)\n--\n--   Motion\n--     payload.Teleport(cframe)        move the particle there (Part / Attachment / Model only)\n--     payload.SetVelocity(vector3)    fly in that direction at that speed; SetVelocity(nil) restores the authored speed\n--     payload.SetSpeedMultiplier(n)   scale the speed (2 = twice as fast, 0.5 = half)\n--     payload.AddImpulse(vector3)     give it a push (added to its velocity)\n--     payload.AddSpin(vector3)        make it tumble (spin speed per axis)\n\n-- GOOD TO KNOW\n--   * The script has its own thread: task.wait() and loops are fine, but after a wait the\n--     particle may already be gone.\n--   * payload.Source.Parent is nil when the emitter was deleted mid-flight; check it first.\n--   * In Animate mode, payload.Particle IS the original RenderTemplate: what you change stays changed.\n\nreturn function(payload)\n\t-- your code here\nend\n";
    ModuleScript.Parent = Configuration;
    Configuration.Parent = v50;

    return Configuration;
end;

function u1.setEnabled(p52, p53, p54) -- Line: 388
    -- upvalues: u1 (copy)
    if p54 then
        local v55 = u1.ensureEvent(p52, p53);

        if not v55 then
            return nil;
        end;

        v55:SetAttribute("Enabled", true);

        return v55;
    end;

    local v56 = u1.readEvent(p52, p53);

    if not v56 then
        return nil;
    end;

    v56:SetAttribute("Enabled", false);

    return v56;
end;

function u1.trustEvent(p57, p58) -- Line: 411
    -- upvalues: u1 (copy)
    local v59 = u1.readEvent(p57, p58);

    if not v59 then
        return false;
    end;

    if not v59:GetAttribute("ImportedUntrusted") then
        return false;
    end;

    v59:SetAttribute("ImportedUntrusted", nil);

    return true;
end;

function u1.trustAllEvents(p60) -- Line: 425
    -- upvalues: u1 (copy)
    local v61 = u1.read(p60);

    if not v61 then
        return false;
    end;

    local v62 = false;

    for _, child in ipairs(v61:GetChildren()) do
        if child:IsA("Configuration") and child:GetAttribute("ImportedUntrusted") then
            child:SetAttribute("ImportedUntrusted", nil);
            v62 = true;
        end;
    end;

    return v62;
end;

function u1.stampImportedUntrusted(p63) -- Line: 447
    -- upvalues: u1 (copy)
    local v64 = u1.read(p63);

    if not v64 then
        return false;
    end;

    local v65 = false;

    for _, child in ipairs(v64:GetChildren()) do
        if child:IsA("Configuration") then
            child:SetAttribute("ImportedUntrusted", true);
            child:SetAttribute("Enabled", false);
            v65 = true;
        end;
    end;

    return v65;
end;

function u1.deleteEvent(p66, p67) -- Line: 464
    -- upvalues: u1 (copy)
    local v68 = u1.readEvent(p66, p67);

    if not v68 then
        return false;
    end;

    v68.Parent = nil;
    local v69 = u1.read(p66);

    if v69 and #v69:GetChildren() == 0 then
        v69.Parent = nil;
    end;

    return true;
end;

function u1.sanitize(p70) -- Line: 483
    -- upvalues: u1 (copy), u2 (copy), u15 (copy), u3 (copy), u4 (copy), HitFilter (copy)
    local v71 = u1.read(p70);

    if not v71 then
        return false;
    end;

    local v72 = {};
    local v73 = false;

    for _, v in ipairs(u2) do
        v72[v] = true;
    end;

    for _, child in ipairs(v71:GetChildren()) do
        if child:IsA("Configuration") and v72[child.Name] then
            if u1.isValidForItem(p70, child.Name) then
                local v74 = child;

                for i, v in pairs(u15) do
                    if v74:GetAttribute(i) == nil then
                        v74:SetAttribute(i, v);
                        v73 = true;
                    end;
                end;

                local Attribute = v74:GetAttribute("ChainDepthLimit");
                local v75 = tonumber(Attribute);
                local v76;

                if v75 then
                    local math_floor_ret = math.floor(v75);
                    v76 = math.clamp(math_floor_ret, 1, 32);
                else
                    v76 = 4;
                end;

                if Attribute ~= v76 then
                    v74:SetAttribute("ChainDepthLimit", v76);
                    v73 = true;
                end;

                local Attribute2 = v74:GetAttribute("EmitMode");
                local v77 = (type(Attribute2) ~= "string" or not u3[Attribute2]) and "AtPosition" or Attribute2;

                if Attribute2 ~= v77 then
                    v74:SetAttribute("EmitMode", v77);
                    v73 = true;
                end;

                local Attribute3 = v74:GetAttribute("Collision");
                local v78 = (type(Attribute3) ~= "string" or not u4[Attribute3]) and "Off" or Attribute3;

                if Attribute3 ~= v78 then
                    v74:SetAttribute("Collision", v78);
                    v73 = true;
                end;

                for _, v in ipairs({ {
                        name = "Bounciness",
                        lo = 0,
                        hi = 1,
                        default = 0.7
                    }, {
                        name = "Friction",
                        lo = 0,
                        hi = 1,
                        default = 0.2
                    }, {
                        name = "Spin",
                        lo = 0,
                        hi = 2,
                        default = 0.5
                    }, {
                        name = "HitCheckInterval",
                        lo = 0,
                        hi = 0.5,
                        default = 0
                    } }) do
                    local Attribute4 = v74:GetAttribute(v.name);
                    local lo = v.lo;
                    local hi = v.hi;
                    local default = v.default;
                    local v79 = tonumber(Attribute4);

                    if v79 then
                        if v79 < lo then
                            v79 = lo;
                        elseif hi < v79 then
                            v79 = hi;
                        end;
                    else
                        v79 = default;
                    end;

                    if Attribute4 ~= v79 then
                        v74:SetAttribute(v.name, v79);
                        v73 = true;
                    end;
                end;

                v73 = HitFilter.migrateFromEvent(p70, v74) and true or v73;
                local EmitTarget = v74:FindFirstChild("EmitTarget");

                if not (EmitTarget and EmitTarget:IsA("ObjectValue")) then
                    if EmitTarget then
                        EmitTarget.Parent = nil;
                    end;

                    local ObjectValue = Instance.new("ObjectValue");
                    ObjectValue.Name = "EmitTarget";
                    ObjectValue.Parent = v74;
                    v73 = true;
                end;

                local Module = v74:FindFirstChild("Module");

                if not (Module and Module:IsA("ModuleScript")) then
                    if Module then
                        Module.Parent = nil;
                    end;

                    local ModuleScript = Instance.new("ModuleScript");
                    ModuleScript.Name = "Module";
                    ModuleScript.Source = "--[[\n\tPart-Icles event script.\n\n\tThis function runs once every time this event happens to ONE particle.\n\t`payload` describes that particle and gives you functions to change it.\n\tThe script only runs while the event\'s \"Script\" toggle is on. Errors show in\n\tthe Output window and never stop the effect.\n\tKeep the last three lines: the file must return a function that takes `payload`.\n]]\n\n-- WHEN DOES THIS RUN?\n--   OnEmit         the particle was just created\n--   OnHit          the particle touched something (Part / Attachment / Model / Lightning / Rocks emitters only)\n--   OnDeath        the particle\'s lifetime ran out, or something killed it\n--   OnDestruction  the particle is removed for good (after its Linger time, if it has one)\n\n-- QUICK EXAMPLE  (OnDeath: spawn a second effect only if the particle lived longer than a second)\n--   return function(payload)\n--       if payload.Age > 1 then\n--           payload.Emit(workspace.Sparks, \"AtPosition\")\n--       end\n--   end\n\n-- ============================================================================\n--  THINGS YOU CAN READ  (plain values; changing them does nothing)\n-- ============================================================================\n--   In every event\n--     payload.Source            the emitter you set up in the plugin (the original)\n--     payload.Particle          the copy flying around right now (nil for Camera Shake / Distortion)\n--     payload.WorldPosition     where the particle is, as a Vector3 (nil for screen effects)\n--     payload.WorldCFrame       the same with rotation, as a CFrame (nil for screen effects)\n--     payload.LifeTime          how many seconds the particle is set to live\n--     payload.LifeProgress      0 = just born, 1 = about to die\n--     payload.TimeRemaining     seconds left before it dies on its own\n--     payload.StartTime         os.clock() at the moment it was created\n--     payload.SpeedMultiplier   current speed scale (1 = normal; bounces lower it)\n--     payload.ChainDepth        0 normally; 1, 2, ... when this particle was itself spawned by an event\n--     payload.RenderTemplate    old name for payload.Particle\n--\n--   OnEmit only\n--     payload.EmitPosition      same as WorldPosition\n--     payload.EmitIndex         which particle of the burst this is (1 = first)\n--     payload.EmitCount         how many particles the burst made (nil for a single emit)\n--\n--   OnHit only\n--     payload.HitInstance       the part it touched (payload.Other is the same thing)\n--     payload.HitPosition       the exact contact point (Vector3)\n--     payload.HitNormal         the direction the surface faces at that point (Vector3, length 1)\n--\n--   OnDeath only\n--     payload.DeathPosition     same as WorldPosition\n--     payload.Age               how many seconds it really lived (less than LifeTime when killed early)\n--\n--   OnDestruction only\n--     payload.DeathPosition     same as WorldPosition\n--     payload.LingerElapsed     seconds spent in Linger before removal (0 without Linger)\n\n-- ============================================================================\n--  THINGS YOU CAN DO  (functions; they change this one particle only)\n-- ============================================================================\n--   Spawn and end\n--     payload.Emit(target, mode)      fire another emitter from here. target = an emitter, a Folder or a\n--                                     Model of emitters. mode = \"AtPosition\" | \"AtSource\" | \"AtTarget\" |\n--                                     \"AtCFrame\"; leave it out to use this event\'s Mode dropdown\n--     payload.Kill()                  remove the particle now (OnDeath does not fire for it)\n--     payload.Resurrect()             cancel a Kill made earlier in this same script\n--\n--   Look\n--     payload.SetColor(color3)        set the colour and stop the Color graph from changing it\n--     payload.SetTransparency(0..1)   set the transparency and stop the Transparency graph\n--     payload.SetSize(size)           set the size and stop the Size graph (Vector3; UDim2 for ImageLabel)\n--     payload.SetSkipColor(true)      stop only the graph, keep the current value (false resumes it)\n--     payload.SetSkipTransparency(true)\n--     payload.SetSkipSize(true)       Parts only\n--\n--   Time\n--     payload.SetLifetime(seconds)    new total lifetime, counted from birth (a tiny value = dies next frame)\n--     payload.Pause(seconds)          freeze the particle for that long, then continue\n--     payload.FreezeTime(true)        freeze until you call FreezeTime(false)\n--\n--   Motion\n--     payload.Teleport(cframe)        move the particle there (Part / Attachment / Model only)\n--     payload.SetVelocity(vector3)    fly in that direction at that speed; SetVelocity(nil) restores the authored speed\n--     payload.SetSpeedMultiplier(n)   scale the speed (2 = twice as fast, 0.5 = half)\n--     payload.AddImpulse(vector3)     give it a push (added to its velocity)\n--     payload.AddSpin(vector3)        make it tumble (spin speed per axis)\n\n-- GOOD TO KNOW\n--   * The script has its own thread: task.wait() and loops are fine, but after a wait the\n--     particle may already be gone.\n--   * payload.Source.Parent is nil when the emitter was deleted mid-flight; check it first.\n--   * In Animate mode, payload.Particle IS the original RenderTemplate: what you change stays changed.\n\nreturn function(payload)\n\t-- your code here\nend\n";
                    ModuleScript.Parent = v74;
                    v73 = true;
                end;

                for _, child2 in ipairs(v74:GetChildren()) do
                    if child2.Name == "_CompiledEventModule" then
                        child2.Parent = nil;
                        v73 = true;
                    end;
                end;
            else
                child.Parent = nil;
                v73 = true;
            end;
        else
            child.Parent = nil;
            v73 = true;
        end;
    end;

    if #v71:GetChildren() == 0 then
        v71.Parent = nil;
        v73 = true;
    end;

    return v73;
end;

function u1.snapshot(p80) -- Line: 598
    -- upvalues: u1 (copy), u2 (copy)
    local v81 = u1.read(p80);

    if not v81 then
        return nil;
    end;

    local v82 = nil;

    for _, v in ipairs(u2) do
        local v83 = v81:FindFirstChild(v);

        if v83 and v83:IsA("Configuration") then
            v82 = v82 or {};
            local v84 = {
                Enabled = v83:GetAttribute("Enabled"),
                EmitMode = v83:GetAttribute("EmitMode"),
                ScriptEnabled = v83:GetAttribute("ScriptEnabled"),
                ChainDepthLimit = v83:GetAttribute("ChainDepthLimit"),
                Collision = v83:GetAttribute("Collision"),
                Bounciness = v83:GetAttribute("Bounciness"),
                Friction = v83:GetAttribute("Friction"),
                Spin = v83:GetAttribute("Spin"),
                HitCheckInterval = v83:GetAttribute("HitCheckInterval"),
                ImportedUntrusted = v83:GetAttribute("ImportedUntrusted") == true
            };
            local EmitTarget = v83:FindFirstChild("EmitTarget");

            if EmitTarget and EmitTarget:IsA("ObjectValue") then
                v84.EmitTargetPresent = true;
                v84.EmitTargetValue = EmitTarget.Value;
                v84.EmitTargetPath = EmitTarget.Value and EmitTarget.Value:GetFullName() or nil;
            end;

            local Module = v83:FindFirstChild("Module");

            if Module and Module:IsA("ModuleScript") then
                v84.ModuleSource = Module.Source;
            end;

            v82[v] = v84;
        end;
    end;

    return v82;
end;

function u1.apply(p85, p86) -- Line: 642
    -- upvalues: u1 (copy), u3 (copy), u4 (copy)
    if not p86 then
        return false;
    end;

    local v87 = false;

    for i, v in pairs(p86) do
        if u1.isValidForItem(p85, i) then
            local v88 = u1.ensureEvent(p85, i);

            if v88 then
                if v.Enabled ~= nil then
                    v88:SetAttribute("Enabled", v.Enabled == true);
                end;

                if v.EmitMode ~= nil then
                    local EmitMode = v.EmitMode;
                    v88:SetAttribute("EmitMode", (type(EmitMode) ~= "string" or not u3[EmitMode]) and "AtPosition" or EmitMode);
                end;

                if v.ScriptEnabled ~= nil then
                    v88:SetAttribute("ScriptEnabled", v.ScriptEnabled == true);
                end;

                if v.ChainDepthLimit ~= nil then
                    local v89 = tonumber(v.ChainDepthLimit);
                    local v90;

                    if v89 then
                        local math_floor_ret = math.floor(v89);
                        v90 = math.clamp(math_floor_ret, 1, 32);
                    else
                        v90 = 4;
                    end;

                    v88:SetAttribute("ChainDepthLimit", v90);
                end;

                if v.Collision ~= nil then
                    local Collision = v.Collision;
                    v88:SetAttribute("Collision", (type(Collision) ~= "string" or not u4[Collision]) and "Off" or Collision);
                end;

                if v.Bounciness ~= nil then
                    local v91 = tonumber(v.Bounciness);
                    v88:SetAttribute("Bounciness", not v91 and 0.7 or (v91 < 0 and 0 or (v91 > 1 and 1 or v91)));
                end;

                if v.Friction ~= nil then
                    local v92 = tonumber(v.Friction);
                    v88:SetAttribute("Friction", not v92 and 0.2 or (v92 < 0 and 0 or (v92 > 1 and 1 or v92)));
                end;

                if v.Spin ~= nil then
                    local v93 = tonumber(v.Spin);
                    v88:SetAttribute("Spin", not v93 and 0.5 or (v93 < 0 and 0 or (v93 > 2 and 2 or v93)));
                end;

                if v.HitCheckInterval ~= nil then
                    local v94 = tonumber(v.HitCheckInterval);
                    v88:SetAttribute("HitCheckInterval", not v94 and 0 or (v94 < 0 and 0 or (v94 > 0.5 and 0.5 or v94)));
                end;

                if v.ImportedUntrusted == true then
                    v88:SetAttribute("ImportedUntrusted", true);
                else
                    v88:SetAttribute("ImportedUntrusted", nil);
                end;

                local EmitTarget = v88:FindFirstChild("EmitTarget");

                if EmitTarget and (EmitTarget:IsA("ObjectValue") and v.EmitTargetPresent) then
                    EmitTarget.Value = v.EmitTargetValue;
                end;

                local Module = v88:FindFirstChild("Module");

                if Module and (Module:IsA("ModuleScript") and v.ModuleSource ~= nil) then
                    Module.Source = v.ModuleSource;
                end;

                v87 = true;
            end;
        end;
    end;

    return v87;
end;

return u1;