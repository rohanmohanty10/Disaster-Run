  

local v1 = {};
local script_Parent = script.Parent;
local Components = script_Parent.Components;
local Shared = script_Parent.Parent.Shared;
local shared_StoryCache = shared.StoryCache;
local State = require(script_Parent.State);
local React = require(Shared.React);
local ReactRoblox = require(Shared.ReactRoblox);

if not shared_StoryCache then
    shared_StoryCache = {};
    shared.StoryCache = shared_StoryCache;
end;

local u2 = {};
u2.__index = u2;
local l_require = require;

function u2.AddCallback(p3: any, p4: string, p5: function) -- Line: 41
    p3.callbacks[p4] = p5;
end;

function u2.__call(u6: any, u7: userdata) -- Line: 45
    -- upvalues: ReactRoblox (copy), State (copy), shared_StoryCache (ref), React (copy)
    local name = u6.name;
    local story = u6.story;
    local props = u6.props;
    local u8 = ReactRoblox.createRoot(u7);
    local u9 = State.CreatePorts();
    local u10 = shared_StoryCache[name] or {};

    local function update() -- Line: 56
        -- upvalues: u7 (copy), shared_StoryCache (ref), name (copy), u6 (copy), React (ref), State (ref), u9 (copy), story (copy), u8 (copy)
        local Attributes = u7:GetAttributes();
        shared_StoryCache[name] = table.clone(Attributes);

        for i, v in u6.callbacks do
            Attributes[i] = v();
        end;

        u8:render((React.createElement(State.Driver, {
            Ports = u9
        }, {
            Story = React.createElement(story, Attributes)
        })));

        if Attributes.AutoPlay then
            task.delay(0, function() -- Line: 73
                -- upvalues: u9 (ref)
                u9.SetPlaying:Fire(true);
            end);
        end;
    end;

    local u11 = {};

    for i, v in pairs(props) do
        local success, result = pcall(function(...) -- Line: 80
            -- upvalues: u7 (copy), i (copy), u10 (copy), v (ref), update (copy)
            local AttributeChangedSignal = u7:GetAttributeChangedSignal(i);

            if u10[i] ~= nil then
                v = u10[i];
            end;

            u7:SetAttribute(i, v);

            return AttributeChangedSignal:Connect(update);
        end);

        if success then
            table.insert(u11, result);
        end;
    end;

    update();

    return function() -- Line: 98
        -- upvalues: u11 (copy), u8 (copy)
        for _, v in ipairs(u11) do
            v:Disconnect();
        end;

        u8:unmount();
    end;
end;

function v1.Create(p12: userdata, p13: table?) -- Line: 107
    -- upvalues: Components (copy), l_require (copy), u2 (copy)
    local v14 = p12.Name:gsub("%.story$", "");

    if v14 then
        v14 = Components:FindFirstChild(v14);
    end;

    local v15;

    if v14 then
        v15 = v14:IsA("ModuleScript");
    else
        v15 = v14;
    end;

    assert(v15, "Invalid story target provided!");
    local v16 = p13 or {};
    local v17 = {};

    for i, v in pairs(v16) do
        if typeof(v) == "function" then
            v17[i] = v;
            v16[i] = nil;
        end;
    end;

    local v18 = {
        name = v14:GetFullName(),
        story = l_require(v14),
        callbacks = v17,
        props = v16
    };

    return setmetatable(v18, u2);
end;

function v1.Custom(p19: string, p20: function, p21: table?) -- Line: 130
    -- upvalues: u2 (copy)
    local v22 = p21 or {};
    local v23 = {};

    for i, v in pairs(v22) do
        if typeof(v) == "function" then
            v23[i] = v;
            v22[i] = nil;
        end;
    end;

    return setmetatable({
        name = p19,
        story = p20,
        callbacks = v23,
        props = v22
    }, u2);
end;

return v1;