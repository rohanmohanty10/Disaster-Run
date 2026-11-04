 

 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("@self/mod/logger");
local u2 = require("@self/mod/utility");
local u3 = require("@self/effects/bezier");
local u4 = require("@self/effects/lightning");
local u5 = require("@self/effects/camera_shake");
local u6 = require("@self/effects/shockwave_ring");
local u7 = require("@self/effects/shockwave_line");
local u8 = require("@self/effects/shockwave_debris");
local u9 = require("@self/services/caches");
local u10 = require("@self/services/effects");
local u11 = require("@self/services/texture_loader");
local u12 = require("@self/services/enabled_effects");
local PLUGIN_CONTEXT = u2.PLUGIN_CONTEXT;
local SERVER_CONTEXT = u2.SERVER_CONTEXT;
local u13 = {
    scope = {},
    setup = false
};

function u13.init(p14: table?) -- Line: 114
    -- upvalues: u13 (copy), SERVER_CONTEXT (copy), u2 (copy), u1 (copy), RunService (copy), PLUGIN_CONTEXT (copy), u9 (copy), u10 (copy), u11 (copy), u12 (copy), u5 (copy), u3 (copy), u4 (copy), u6 (copy), u7 (copy), u8 (copy)
    if u13.setup then
        return;
    end;

    if SERVER_CONTEXT then
        task.spawn(function() -- Line: 120
            -- upvalues: u2 (ref), u1 (ref)
            local v15 = 0;

            while true do
                v15 = v15 + 1;
                local success, result = pcall(u2.setCollisionGroups, u2.COLLISION_GROUPS);

                if not success then
                    task.wait(v15);
                end;

                if success or v15 >= 5 then
                    if not success then
                        u1.warn((`couldn't register necessary collision groups after {v15} tries with the last error being: {result}`));
                    end;

                    return;
                end;
            end;
        end);
    end;

    u13.setup = true;

    if RunService:IsServer() and not PLUGIN_CONTEXT then
        return;
    end;

    u13.caches = u9.init(u13.scope);
    shared.vfx = u13;
    u10.init(u13);
    u11.init(u13.scope);
    u12.init(u13.scope, u13.caches.shared_part, u10);
    u5.init();
    u3.init(u13.caches.shared_part);
    u4.init(u13.caches.shared_part);
    u6.init(u13.caches.shared_part);
    u7.init(u13.caches.shared_part);
    u8.init(u13.caches.shared_part);
end;

function u13.deinit() -- Line: 173
    -- upvalues: u13 (copy), RunService (copy), PLUGIN_CONTEXT (copy), u2 (copy), u10 (copy), u3 (copy), u4 (copy), u5 (copy), u6 (copy), u7 (copy), u8 (copy), CollectionService (copy)
    if not u13.setup then
        return;
    end;

    u13.setup = false;
    shared.vfx = nil;

    if RunService:IsServer() and not PLUGIN_CONTEXT then
        return;
    end;

    u2.cleanupScope(u13.scope);
    u10.deinit();
    u3.deinit();
    u4.deinit();
    u5.deinit();
    u6.deinit();
    u7.deinit();
    u8.deinit();

    for _, v in CollectionService:GetTagged(u2.CLEANUP_TAG) do
        v:Destroy();
    end;
end;

local function fullEmit(p16: number, p17: number, ...) -- Line: 204
    -- upvalues: u13 (copy), u1 (copy), u10 (copy)
    if not u13.setup then
        u1.error("not initialized");
    end;

    return u10.emit(p17, ...);
end;

function u13.emit(p18, ...) -- Line: 212
    -- upvalues: fullEmit (copy)
    if typeof(p18) == "number" then
        return fullEmit(p18, 0, ...);
    end;

    return fullEmit(1, 0, p18, ...);
end;

function u13.emitWithDepth(p19: number, ...) -- Line: 220
    -- upvalues: fullEmit (copy)
    return fullEmit(1, p19, ...);
end;

return u13;