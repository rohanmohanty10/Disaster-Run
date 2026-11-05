  

 

local v1 = {
    major = 0,
    minor = 3,
    patch = 1
};
local root = require(script.root);
local mount = require(script.mount);
local create = require(script.create);
local apply = require(script.apply);
local source = require(script.source);
local effect = require(script.effect);
local derive = require(script.derive);
local cleanup = require(script.cleanup);
local untrack = require(script.untrack);
local read = require(script.read);
local batch = require(script.batch);
local context = require(script.context);
local switch = require(script.switch);
local show = require(script.show);
local v2, v3 = require(script.maps)();
local v4, u5 = require(script.spring)();
local v6 = require(script.action)();
local changed = require(script.changed);
local throw = require(script.throw);
local flags = require(script.flags);

local function step(p7) -- Line: 33
    -- upvalues: u5 (copy)
    if game then
        debug.profilebegin("VIDE STEP");
        debug.profilebegin("VIDE SPRING");
    end;

    u5(p7);

    if game then
        debug.profileend();
        debug.profileend();
    end;
end;

local u9 = game and game:GetService("RunService").Heartbeat:Connect(function(p8) -- Line: 47
    -- upvalues: step (copy)
    task.defer(step, p8);
end);
local v13 = {
    strict = nil,
    version = v1,
    root = root,
    mount = mount,
    create = create,
    source = source,
    effect = effect,
    derive = derive,
    switch = switch,
    show = show,
    indexes = v2,
    values = v3,
    cleanup = cleanup,
    untrack = untrack,
    read = read,
    batch = batch,
    context = context,
    spring = v4,
    action = v6,
    changed = changed,

    apply = function(u10) -- Line: 84, Name: apply
        -- upvalues: apply (copy)
        return function(p11) -- Line: 85
            -- upvalues: apply (ref), u10 (copy)
            apply(u10, p11);

            return u10;
        end;
    end,

    step = function(p12) -- Line: 92, Name: step
        -- upvalues: u9 (ref), step (copy)
        if u9 then
            u9:Disconnect();
            u9 = nil;
        end;

        step(p12);
    end
};
setmetatable(v13, {
    __index = function(p14, p15) -- Line: 102, Name: __index
        -- upvalues: flags (copy), throw (copy)
        if p15 == "strict" then
            return flags.strict;
        end;

        throw((`{tostring(p15)} is not a valid member of vide`));
    end,

    __newindex = function(p16, p17, p18) -- Line: 110, Name: __newindex
        -- upvalues: flags (copy), throw (copy)
        if p17 == "strict" then
            flags.strict = p18;

            return;
        end;

        throw((`{tostring(p17)} is not a valid member of vide`));
    end
});

return v13;