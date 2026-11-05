  

 

local Roact = require(script.Parent.Parent.Roact);
local getStore = require(script.Parent.getStore);
local shallowEqual = require(script.Parent.shallowEqual);
local join = require(script.Parent.join);
local TempConfig = require(script.Parent.TempConfig);

local function formatMessage(p1, p2) -- Line: 11
    return table.concat(p1, "\n"):format(unpack(p2 or {}));
end;

local function noop() -- Line: 15
    return nil;
end;

local function makeStateUpdater(u3) -- Line: 28
    -- upvalues: join (copy)
    return function(p4, p5, p6) -- Line: 29
        -- upvalues: u3 (copy), join (ref)
        if p6 == nil then
            p6 = p5.mapStateToProps(u3:getState(), p4);
        end;

        return {
            mappedStoreState = p6,
            propsForChild = join(p4, p6, p5.mappedStoreDispatch)
        };
    end;
end;

return function(u7, u8) -- Line: 52, Name: connect
    -- upvalues: noop (copy), Roact (copy), shallowEqual (copy), getStore (copy), join (copy), TempConfig (copy)
    local u9 = debug.traceback();

    if u7 == nil then
        u7 = noop;
    else
        local v10 = typeof(u7) == "function";
        assert(v10, "mapStateToProps must be a function or nil!");
    end;

    if u8 == nil then
        u8 = noop;
    else
        local v11 = typeof(u8) == "function";
        assert(v11, "mapDispatchToProps must be a function or nil!");
    end;

    return function(u12) -- Line: 67
        -- upvalues: u9 (copy), Roact (ref), shallowEqual (ref), getStore (ref), u7 (ref), u8 (ref), join (ref), TempConfig (ref)
        if u12 == nil then
            local v13 = { u9 };
            local v14 = table.concat(
                { "connect returns a function that must be passed a component.", "Check the connection at:", "%s" },
                "\n"
            ):format(unpack(v13 or {}));
            error(v14, 2);
        end;

        local v15 = ("RoduxConnection(%s)"):format((tostring(u12)));
        local v16 = Roact.Component:extend(v15);

        function v16.getDerivedStateFromProps(p17, p18) -- Line: 84
            if p18.stateUpdater ~= nil then
                return p18.stateUpdater(p17, p18);
            end;
        end;

        function v16.createStoreConnection(u19) -- Line: 90
            -- upvalues: shallowEqual (ref)
            u19.storeChangedConnection = u19.store.changed:connect(function(u20) -- Line: 91
                -- upvalues: u19 (copy), shallowEqual (ref)
                u19:setState(function(p21, p22) -- Line: 92
                    -- upvalues: u20 (copy), shallowEqual (ref)
                    local v23 = p21.mapStateToProps(u20, p22);

                    if shallowEqual(v23, p21.mappedStoreState) then
                        return nil;
                    end;

                    return p21.stateUpdater(p22, p21, v23);
                end);
            end);
        end;

        function v16.init(u24) -- Line: 107
            -- upvalues: getStore (ref), u12 (copy), u7 (ref), u8 (ref), join (ref), TempConfig (ref)
            u24.store = getStore(u24);

            if u24.store == nil then
                local v25 = { (tostring(u12)) };
                local v26 = table.concat(
                    { "Cannot initialize Roact-Rodux connection without being a descendent of StoreProvider!", "Tried to wrap component %q", "Make sure there is a StoreProvider above this component in the tree." },
                    "\n"
                ):format(unpack(v25 or {}));
                error(v26);
            end;

            local v27 = u24.store:getState();
            local v28 = u7;
            local v29 = v28(v27, u24.props);
            local v30;

            if typeof(v29) == "function" then
                v30 = v29(v27, u24.props);
            else
                v30 = v29;
                v29 = v28;
            end;

            if v30 ~= nil and typeof(v30) ~= "table" then
                local v31 = { tostring(v30), (typeof(v30)) };
                local v32 = table.concat(
                    { "mapStateToProps must either return a table, or return another function that returns a table.", "Instead, it returned %q, which is of type %s." },
                    "\n"
                ):format(unpack(v31 or {}));
                error(v32);
            end;

            local v33 = u8(function(...) -- Line: 148
                -- upvalues: u24 (copy)
                return u24.store:dispatch(...);
            end);
            local store = u24.store;

            local function v37(p34, p35, p36) -- Line: 29
                -- upvalues: store (copy), join (ref)
                if p36 == nil then
                    p36 = p35.mapStateToProps(store:getState(), p34);
                end;

                return {
                    mappedStoreState = p36,
                    propsForChild = join(p34, p36, p35.mappedStoreDispatch)
                };
            end;

            u24.state = {
                propsForChild = nil,
                stateUpdater = v37,
                mapStateToProps = v29,
                mappedStoreDispatch = v33
            };
            local v38 = v37(u24.props, u24.state, v30);

            for i, v in pairs(v38) do
                u24.state[i] = v;
            end;

            if TempConfig.newConnectionOrder then
                u24:createStoreConnection();
            end;
        end;

        function v16.didMount(p39) -- Line: 183
            -- upvalues: TempConfig (ref)
            if not TempConfig.newConnectionOrder then
                p39:createStoreConnection();
            end;
        end;

        function v16.willUnmount(p40) -- Line: 189
            p40.storeChangedConnection:disconnect();
        end;

        function v16.render(p41) -- Line: 193
            -- upvalues: Roact (ref), u12 (copy)
            return Roact.createElement(u12, p41.state.propsForChild);
        end;

        return v16;
    end;
end;