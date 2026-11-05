  

 

return function() -- Line: 1
    local connect = require(script.Parent.connect);
    local StoreProvider = require(script.Parent.StoreProvider);
    local Roact = require(script.Parent.Parent.Roact);
    local Rodux = require(script.Parent.Parent.Rodux);
    local TempConfig = require(script.Parent.TempConfig);

    local function noop() -- Line: 11
        return nil;
    end;

    local function NoopComponent() -- Line: 15
        return nil;
    end;

    local u4 = Rodux.combineReducers({
        count = function(p1, p2) -- Line: 19, Name: countReducer
            local v3 = p1 or 0;

            if p2.type == "increment" then
                return v3 + 1;
            end;

            return v3;
        end
    });
    describe("Argument validation", function() -- Line: 33
        -- upvalues: connect (copy), noop (copy)
        it("should accept no arguments", function() -- Line: 34
            -- upvalues: connect (ref)
            connect();
        end);
        it("should accept one function", function() -- Line: 38
            -- upvalues: connect (ref), noop (ref)
            connect(noop);
        end);
        it("should accept two functions", function() -- Line: 42
            -- upvalues: connect (ref), noop (ref)
            connect(noop, noop);
        end);
        it("should accept only the second function", function() -- Line: 46
            -- upvalues: connect (ref)
            connect(nil, function() -- Line: 47
            end);
        end);
        it("should throw if not passed a component", function() -- Line: 50
            -- upvalues: connect (ref)
            local function u6(p5) -- Line: 51
                return {};
            end;

            expect(function() -- Line: 55
                -- upvalues: connect (ref), u6 (copy)
                connect(u6)(nil);
            end).to.throw();
        end);
    end);
    it("should throw if not mounted under a StoreProvider", function() -- Line: 61
        -- upvalues: connect (copy), NoopComponent (copy), Roact (copy)
        local u7 = connect()(NoopComponent);
        expect(function() -- Line: 64
            -- upvalues: Roact (ref), u7 (copy)
            Roact.mount(Roact.createElement(u7));
        end).to.throw();
    end);
    it("should accept a higher-order function mapStateToProps", function() -- Line: 69
        -- upvalues: connect (copy), NoopComponent (copy), Rodux (copy), u4 (copy), Roact (copy), StoreProvider (copy)
        local v9 = connect(function() -- Line: 70, Name: mapStateToProps
            return function(p8) -- Line: 71
                return {
                    count = p8.count
                };
            end;
        end)(NoopComponent);
        local v10 = Rodux.Store.new(u4);
        local v11 = Roact.createElement(StoreProvider, {
            store = v10
        }, {
            someComponent = Roact.createElement(v9)
        });
        local v12 = Roact.mount(v11);
        Roact.unmount(v12);
    end);
    it("should not accept a higher-order mapStateToProps that returns a non-table value", function() -- Line: 92
        -- upvalues: connect (copy), NoopComponent (copy), Rodux (copy), u4 (copy), Roact (copy), StoreProvider (copy)
        local v14 = connect(function() -- Line: 93, Name: mapStateToProps
            return function(p13) -- Line: 94
                return "nope";
            end;
        end)(NoopComponent);
        local v15 = Rodux.Store.new(u4);
        local u16 = Roact.createElement(StoreProvider, {
            store = v15
        }, {
            someComponent = Roact.createElement(v14)
        });
        expect(function() -- Line: 108
            -- upvalues: Roact (ref), u16 (copy)
            Roact.mount(u16);
        end).to.throw();
    end);
    it("should not accept a mapStateToProps that returns a non-table value", function() -- Line: 113
        -- upvalues: connect (copy), NoopComponent (copy), Rodux (copy), u4 (copy), Roact (copy), StoreProvider (copy)
        local v17 = connect(function() -- Line: 114, Name: mapStateToProps
            return "nah";
        end)(NoopComponent);
        local v18 = Rodux.Store.new(u4);
        local u19 = Roact.createElement(StoreProvider, {
            store = v18
        }, {
            someComponent = Roact.createElement(v17)
        });
        expect(function() -- Line: 127
            -- upvalues: Roact (ref), u19 (copy)
            Roact.mount(u19);
        end).to.throw();
    end);
    it("should abort renders when mapStateToProps returns the same data", function() -- Line: 132
        -- upvalues: connect (copy), Rodux (copy), u4 (copy), Roact (copy), StoreProvider (copy)
        local u20 = 0;

        local function SomeComponent(p21) -- Line: 140
            -- upvalues: u20 (ref)
            u20 = u20 + 1;
        end;

        local v23 = connect(function(p22) -- Line: 133, Name: mapStateToProps
            return {
                count = p22.count
            };
        end)(SomeComponent);
        local v24 = Rodux.Store.new(u4);
        local v25 = Roact.createElement(StoreProvider, {
            store = v24
        }, {
            someComponent = Roact.createElement(v23)
        });
        local v26 = Roact.mount(v25);
        expect(u20).to.equal(1);
        v24:dispatch({
            type = "an unknown action"
        });
        v24:flush();
        expect(u20).to.equal(1);
        v24:dispatch({
            type = "increment"
        });
        v24:flush();
        expect(u20).to.equal(2);
        Roact.unmount(v26);
    end);
    it("should only call mapDispatchToProps once and never re-render if no mapStateToProps was passed", function() -- Line: 170
        -- upvalues: connect (copy), Rodux (copy), u4 (copy), Roact (copy), StoreProvider (copy)
        local u27 = 0;

        local function v29(u28) -- Line: 172
            -- upvalues: u27 (ref)
            u27 = u27 + 1;

            return {
                increment = function() -- Line: 176, Name: increment
                    -- upvalues: u28 (copy)
                    return u28({
                        type = "increment"
                    });
                end
            };
        end;

        local u30 = 0;

        local function v32(p31) -- Line: 183
            -- upvalues: u30 (ref)
            u30 = u30 + 1;
        end;

        local v33 = connect(nil, v29)(v32);
        local v34 = Rodux.Store.new(u4);
        local v35 = Roact.createElement(StoreProvider, {
            store = v34
        }, {
            someComponent = Roact.createElement(v33)
        });
        local v36 = Roact.mount(v35);
        expect(u27).to.equal(1);
        expect(u30).to.equal(1);
        v34:dispatch({
            type = "an unknown action"
        });
        v34:flush();
        expect(u27).to.equal(1);
        expect(u30).to.equal(1);
        v34:dispatch({
            type = "increment"
        });
        v34:flush();
        expect(u27).to.equal(1);
        expect(u30).to.equal(1);
        Roact.unmount(v36);
    end);
    it("should return result values from the dispatch passed to mapDispatchToProps", function() -- Line: 216
        -- upvalues: connect (copy), Rodux (copy), Roact (copy), StoreProvider (copy)
        local u37 = nil;

        local function v39(p38) -- Line: 226
            -- upvalues: u37 (ref)
            u37 = p38.dispatch;
        end;

        local v41 = connect(nil, function(p40) -- Line: 230, Name: mapDispatchToProps
            return {
                dispatch = p40
            };
        end)(v39);
        local v42 = Rodux.Store.new(function() -- Line: 217, Name: reducer
            return 0;
        end, nil, { Rodux.thunkMiddleware });
        local v43 = Roact.createElement(StoreProvider, {
            store = v42
        }, {
            someComponent = Roact.createElement(v41)
        });
        local v44 = Roact.mount(v43);
        expect(u37).to.be.a("function");
        expect(u37(function() -- Line: 221, Name: fiveThunk
            return 5;
        end)).to.equal(5);
        Roact.unmount(v44);
    end);
    it("should render parent elements before children", function() -- Line: 254
        -- upvalues: TempConfig (copy), connect (copy), Roact (copy), Rodux (copy), u4 (copy), StoreProvider (copy)
        local newConnectionOrder = TempConfig.newConnectionOrder;
        TempConfig.newConnectionOrder = true;

        local function mapStateToProps(p45) -- Line: 258
            return {
                count = p45.count
            };
        end;

        local u46 = false;

        local function ChildComponent(p47) -- Line: 266
            -- upvalues: u46 (ref)
            if p47.count > p47.parentCount then
                u46 = true;
            end;
        end;

        local u48 = connect(mapStateToProps)(ChildComponent);

        local function ParentComponent(p49) -- Line: 274
            -- upvalues: Roact (ref), u48 (copy)
            return Roact.createElement(u48, {
                parentCount = p49.count
            });
        end;

        local v50 = connect(mapStateToProps)(ParentComponent);
        local v51 = Rodux.Store.new(u4);
        local v52 = Roact.createElement(StoreProvider, {
            store = v51
        }, {
            parent = Roact.createElement(v50)
        });
        local v53 = Roact.mount(v52);
        v51:dispatch({
            type = "increment"
        });
        v51:flush();
        v51:dispatch({
            type = "increment"
        });
        v51:flush();
        Roact.unmount(v53);
        expect(u46).to.equal(false);
        TempConfig.newConnectionOrder = newConnectionOrder;
    end);
    it("should render child elements before children when TempConfig.newConnectionOrder is false", function() -- Line: 304
        -- upvalues: TempConfig (copy), connect (copy), Roact (copy), Rodux (copy), u4 (copy), StoreProvider (copy)
        local newConnectionOrder = TempConfig.newConnectionOrder;
        TempConfig.newConnectionOrder = false;

        local function v55(p54) -- Line: 308
            return {
                count = p54.count
            };
        end;

        local u56 = false;

        local function v58(p57) -- Line: 316
            -- upvalues: u56 (ref)
            if p57.count > p57.parentCount then
                u56 = true;
            end;
        end;

        local u59 = connect(v55)(v58);

        local function v61(p60) -- Line: 324
            -- upvalues: Roact (ref), u59 (copy)
            return Roact.createElement(u59, {
                parentCount = p60.count
            });
        end;

        local v62 = connect(v55)(v61);
        local v63 = Rodux.Store.new(u4);
        local v64 = Roact.createElement(StoreProvider, {
            store = v63
        }, {
            parent = Roact.createElement(v62)
        });
        local v65 = Roact.mount(v64);
        v63:dispatch({
            type = "increment"
        });
        v63:flush();
        v63:dispatch({
            type = "increment"
        });
        v63:flush();
        Roact.unmount(v65);
        expect(u56).to.equal(true);
        TempConfig.newConnectionOrder = newConnectionOrder;
    end);
end;