 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("@self/mod/logger");
local u2 = require("@self/mod/utility");
local u3 = require("@self/mod/attributes");
local u4 = require("@self/effects/bezier");
require("@self/effects/mesh");
local u5 = require("@self/effects/lightning");
local u6 = require("@self/effects/camera_shake");
local u7 = require("@self/effects/shockwave_ring");
local u8 = require("@self/effects/shockwave_line");
local u9 = require("@self/effects/shockwave_debris");
local u10 = require("@self/effects/mesh");
local u11 = require("@self/services/caches");
local u12 = require("@self/services/effects");
local u13 = require("@self/services/texture_loader");
local u14 = require("@self/services/enabled_effects");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local PLUGIN_CONTEXT = u2.PLUGIN_CONTEXT;
local SERVER_CONTEXT = u2.SERVER_CONTEXT;
local u15 = {
    scope = {},
    setup = false
};

function u15.init(p16: table?) -- Line: 123
    -- upvalues: u15 (copy), SERVER_CONTEXT (copy), u2 (copy), u1 (copy), RunService (copy), PLUGIN_CONTEXT (copy), u11 (copy), u12 (copy), u13 (copy), u14 (copy), u6 (copy), u4 (copy), u10 (copy), u5 (copy), u7 (copy), u8 (copy), u9 (copy)
    if u15.setup then
        return;
    end;

    if SERVER_CONTEXT then
        task.spawn(function() -- Line: 129
            -- upvalues: u2 (ref), u1 (ref)
            local v17 = 0;

            while true do
                v17 = v17 + 1;
                local success, result = pcall(u2.setCollisionGroups, u2.COLLISION_GROUPS);

                if not success then
                    task.wait(v17);
                end;

                if success or v17 >= 5 then
                    if not success then
                        u1.warn((`couldn't register necessary collision groups after {v17} tries with the last error being: {result}`));
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
    shared.MOSTRECENTFORGE = u15;
    u12.init(u15);
    u13.init(u15.scope);
    u14.init(u15.scope, u15.caches.shared_part, u12);
    u6.init();
    u4.init(u15.caches.shared_part);
    u10.init(u15.caches.shared_part);
    u5.init(u15.caches.shared_part);
    u7.init(u15.caches.shared_part);
    u8.init(u15.caches.shared_part);
    u9.init(u15.caches.shared_part);
end;

function u15.deinit() -- Line: 183
    -- upvalues: u15 (copy), RunService (copy), PLUGIN_CONTEXT (copy), u2 (copy), u12 (copy), u4 (copy), u10 (copy), u5 (copy), u6 (copy), u7 (copy), u8 (copy), u9 (copy), CollectionService (copy)
    if not u15.setup then
        return;
    end;

    u15.setup = false;
    shared.MOSTRECENTFORGE = nil;

    if RunService:IsServer() and not PLUGIN_CONTEXT then
        return;
    end;

    u2.cleanupScope(u15.scope);
    u12.deinit();
    u4.deinit();
    u10.deinit();
    u5.deinit();
    u6.deinit();
    u7.deinit();
    u8.deinit();
    u9.deinit();

    for _, v in CollectionService:GetTagged(u2.CLEANUP_TAG) do
        v:Destroy();
    end;
end;

local function fullEmit(p18: number, p19: number, ...) -- Line: 215
    -- upvalues: vfxUtil (copy), Players (copy), u15 (copy), u1 (copy), u12 (copy)
    if not vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
        if not u15.setup then
            u1.error("not initialized");
        end;

        return u12.emit(p19, ...);
    end;
end;

function u15.emit(p20, ...) -- Line: 224
    -- upvalues: vfxUtil (copy), Players (copy), fullEmit (copy)
    if not vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
        if typeof(p20) == "number" then
            return fullEmit(p20, 0, ...);
        end;

        return fullEmit(1, 0, p20, ...);
    end;
end;

function u15.meshEmit(...) -- Line: 233
    -- upvalues: vfxUtil (copy), Players (copy), u10 (copy)
    if vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
        return;
    end;

    u10.emit(...);
end;

function u15.emitWithDepth(p21: number, ...) -- Line: 238
    -- upvalues: vfxUtil (copy), Players (copy), fullEmit (copy)
    if not vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
        return fullEmit(1, p21, ...);
    end;
end;

function u15.enable(p22: userdata) -- Line: 244
    -- upvalues: vfxUtil (copy), Players (copy), u3 (copy)
    if vfxUtil.IsSettingOn(Players.LocalPlayer, "NoVFXAtAll") then
        return;
    end;

    if p22:IsA("ParticleEmitter") or p22:IsA("Beam") then
        p22.Enabled = true;

        return;
    end;

    if u3.isCached(p22) then
        u3.trigger(p22, "Enabled", true);

        return;
    end;

    p22:SetAttribute("Enabled", true);
end;

function u15.disable(p23: userdata) -- Line: 258
    -- upvalues: u3 (copy)
    if p23:IsA("ParticleEmitter") or p23:IsA("Beam") then
        p23.Enabled = false;

        return;
    end;

    if u3.isCached(p23) then
        u3.trigger(p23, "Enabled", false);

        return;
    end;

    p23:SetAttribute("Enabled", false);
end;

function u15.cacheAttributes(p24: userdata) -- Line: 272
    -- upvalues: u2 (copy), u1 (copy), ReplicatedStorage (copy), u3 (copy)
    if u2.SERVER_CONTEXT then
        u1.error("attributes can only be cached in a client-side context");
    end;

    if not p24:IsDescendantOf(ReplicatedStorage) then
        u1.error("attributes can only be cached for VFX inside ReplicatedStorage");
    end;

    for _, descendant in p24:GetDescendants() do
        u3.cache(descendant);
    end;
end;

function u15.restoreAttributes(p25: userdata) -- Line: 286
    -- upvalues: u2 (copy), u1 (copy), u3 (copy)
    if u2.SERVER_CONTEXT then
        u1.error("attributes can only be restored in a client-side context");
    end;

    for _, descendant in p25:GetDescendants() do
        u3.restore(descendant);
    end;
end;

return u15;