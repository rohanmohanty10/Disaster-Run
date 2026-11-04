 
 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("@self/mod/logger");
local u2 = require("@self/mod/utility");
local u3 = require("@self/mod/attributes");
local u4 = require("@self/effects/sound");
local u5 = require("@self/effects/bezier");
local u6 = require("@self/effects/lightning");
local u7 = require("@self/effects/camera_shake");
local u8 = require("@self/effects/shockwave_ring");
local u9 = require("@self/effects/shockwave_line");
local u10 = require("@self/effects/shockwave_debris");
local u11 = require("@self/services/caches");
local u12 = require("@self/services/effects");
local u13 = require("@self/services/texture_loader");
local u14 = require("@self/services/enabled_effects");
local PLUGIN_CONTEXT = u2.PLUGIN_CONTEXT;
local SERVER_CONTEXT = u2.SERVER_CONTEXT;
local u15 = {
    scope = {},
    setup = false
};

local function IsSettingOn(p16, p17) -- Line: 118
    local v18 = false;

    if p16:FindFirstChild("setting") and (not v18 and p16.setting:FindFirstChild(p17)) then
        v18 = p16.setting:FindFirstChild(p17).Value;
    end;

    return v18;
end;

function u15.init(p19: table?) -- Line: 130
    -- upvalues: u15 (copy), SERVER_CONTEXT (copy), u2 (copy), u1 (copy), RunService (copy), PLUGIN_CONTEXT (copy), u11 (copy), u12 (copy), u13 (copy), u14 (copy), u4 (copy), u7 (copy), u5 (copy), u6 (copy), u8 (copy), u9 (copy), u10 (copy)
    if u15.setup then
        return;
    end;

    if SERVER_CONTEXT then
        task.spawn(function() -- Line: 136
            -- upvalues: u2 (ref), u1 (ref)
            local v20 = 0;

            while true do
                v20 = v20 + 1;
                local success, result = pcall(u2.setCollisionGroups, u2.COLLISION_GROUPS);

                if not success then
                    task.wait(v20);
                end;

                if success or v20 >= 5 then
                    if not success then
                        u1.warn((`couldn't register necessary collision groups after {v20} tries with the last error being: {result}`));
                    end;

                    return;
                end;
            end;
        end);
    end;

    u15.setup = true;

    if RunService:IsServer() and not PLUGIN_CONTEXT then
        return;
    end;

    u15.caches = u11.init(u15.scope);
    shared.vfx = u15;
    u12.init(u15);
    u13.init(u15.scope);
    u14.init(u15.scope, u15.caches.shared_part, u12);
    u4.init();
    u7.init();
    u5.init(u15.caches.shared_part);
    u6.init(u15.caches.shared_part);
    u8.init(u15.caches.shared_part);
    u9.init(u15.caches.shared_part);
    u10.init(u15.caches.shared_part);
end;

function u15.deinit() -- Line: 190
    -- upvalues: u15 (copy), RunService (copy), PLUGIN_CONTEXT (copy), u2 (copy), u12 (copy), u4 (copy), u5 (copy), u6 (copy), u7 (copy), u8 (copy), u9 (copy), u10 (copy), CollectionService (copy)
    if not u15.setup then
        return;
    end;

    u15.setup = false;
    shared.vfx = nil;

    if RunService:IsServer() and not PLUGIN_CONTEXT then
        return;
    end;

    u2.cleanupScope(u15.scope);
    u12.deinit();
    u4.deinit();
    u5.deinit();
    u6.deinit();
    u7.deinit();
    u8.deinit();
    u9.deinit();
    u10.deinit();

    for _, v in CollectionService:GetTagged(u2.CLEANUP_TAG) do
        v:Destroy();
    end;
end;

local function fullEmit(p21: number, p22: number, ...) -- Line: 222
    -- upvalues: Players (copy), u15 (copy), u1 (copy), u12 (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v23 = false;

    if LocalPlayer:FindFirstChild("setting") and (not v23 and LocalPlayer.setting:FindFirstChild("NoVFXAtAll")) then
        v23 = LocalPlayer.setting:FindFirstChild("NoVFXAtAll").Value;
    end;

    if not v23 then
        if not u15.setup then
            u1.error("not initialized");
        end;

        return u12.emit(p22, ...);
    end;
end;

function u15.emit(p24, ...) -- Line: 231
    -- upvalues: Players (copy), fullEmit (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v25 = false;

    if LocalPlayer:FindFirstChild("setting") and (not v25 and LocalPlayer.setting:FindFirstChild("NoVFXAtAll")) then
        v25 = LocalPlayer.setting:FindFirstChild("NoVFXAtAll").Value;
    end;

    if not v25 then
        if typeof(p24) == "number" then
            return fullEmit(p24, 0, ...);
        end;

        return fullEmit(1, 0, p24, ...);
    end;
end;

function u15.emitWithDepth(p26: number, ...) -- Line: 240
    -- upvalues: Players (copy), fullEmit (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v27 = false;

    if LocalPlayer:FindFirstChild("setting") and (not v27 and LocalPlayer.setting:FindFirstChild("NoVFXAtAll")) then
        v27 = LocalPlayer.setting:FindFirstChild("NoVFXAtAll").Value;
    end;

    if not v27 then
        return fullEmit(1, p26, ...);
    end;
end;

function u15.cacheAttributes(p28: userdata, p29: boolean) -- Line: 245
    -- upvalues: u2 (copy), u1 (copy), ReplicatedStorage (copy), u3 (copy)
    if u2.SERVER_CONTEXT then
        u1.error("attributes can only be cached in a client-side context");
    end;

    if not p28:IsDescendantOf(ReplicatedStorage) then
        u1.error("attributes can only be cached for VFX inside ReplicatedStorage");
    end;

    u3.cache(p28);

    if p29 then
        return;
    end;

    for _, descendant in p28:GetDescendants() do
        u3.cache(descendant);
    end;
end;

function u15.restoreAttributes(p30: userdata, p31: boolean?) -- Line: 265
    -- upvalues: u2 (copy), u1 (copy), u3 (copy)
    if u2.SERVER_CONTEXT then
        u1.error("attributes can only be restored in a client-side context");
    end;

    u3.restore(p30);

    if p31 then
        return;
    end;

    for _, descendant in p30:GetDescendants() do
        u3.restore(descendant);
    end;
end;

local function setEnabled(p32: userdata, p33: boolean) -- Line: 281
    -- upvalues: Players (copy), u3 (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v34 = false;

    if LocalPlayer:FindFirstChild("setting") and (not v34 and LocalPlayer.setting:FindFirstChild("NoVFXAtAll")) then
        v34 = LocalPlayer.setting:FindFirstChild("NoVFXAtAll").Value;
    end;

    if v34 then
        return;
    end;

    if p32:IsA("ParticleEmitter") then
        p32.Enabled = p33;

        return;
    end;

    if p32:IsA("Beam") then
        p32.Enabled = p33;

        return;
    end;

    if u3.isCached(p32) then
        u3.trigger(p32, "Enabled", p33);

        return;
    end;

    p32:SetAttribute("Enabled", p33);
end;

function u15.enable(p35: userdata) -- Line: 298
    -- upvalues: Players (copy), setEnabled (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v36 = false;

    if LocalPlayer:FindFirstChild("setting") and (not v36 and LocalPlayer.setting:FindFirstChild("NoVFXAtAll")) then
        v36 = LocalPlayer.setting:FindFirstChild("NoVFXAtAll").Value;
    end;

    if v36 then
        return;
    end;

    setEnabled(p35, true);

    for _, descendant in p35:GetDescendants() do
        setEnabled(descendant, true);
    end;
end;

function u15.disable(p37: userdata) -- Line: 307
    -- upvalues: setEnabled (copy)
    setEnabled(p37, false);

    for _, descendant in p37:GetDescendants() do
        setEnabled(descendant, false);
    end;
end;

u15.retime = require("@self/mod/retime").batch;
u15.resize = require("@self/mod/resize").batch;
u15.recolor = require("@self/mod/recolor");

return u15;