  

 

return function() -- Line: 1
    local Store = require(script.Parent.Store);
    describe("new", function() -- Line: 4
        -- upvalues: Store (copy)
        it("should instantiate with a reducer", function() -- Line: 5
            -- upvalues: Store (ref)
            local v3 = Store.new(function(p1, p2) -- Line: 6
                return "hello, world";
            end);
            expect(v3).to.be.ok();
            expect(v3:getState()).to.equal("hello, world");
            v3:destruct();
        end);
        it("should instantiate with a reducer and an initial state", function() -- Line: 16
            -- upvalues: Store (ref)
            local v6 = Store.new(function(p4, p5) -- Line: 17
                return p4;
            end, "initial state");
            expect(v6).to.be.ok();
            expect(v6:getState()).to.equal("initial state");
            v6:destruct();
        end);
        it("should instantiate with a reducer, initial state, and middlewares", function() -- Line: 27
            -- upvalues: Store (ref)
            local v9 = Store.new(function(p7, p8) -- Line: 28
                return p7;
            end, "initial state", {});
            expect(v9).to.be.ok();
            expect(v9:getState()).to.equal("initial state");
            v9:destruct();
        end);
        it("should modify the dispatch method when middlewares are passed", function() -- Line: 38
            -- upvalues: Store (ref)
            local u10 = 0;
            local u11 = 0;
            local u12 = nil;
            local u13 = nil;
            local u14 = nil;
            local v20 = Store.new(function(p15, p16) -- Line: 45, Name: reducer
                return p16.type == "test" and "test state" or p15;
            end, "initial state", { function(u17, p18) -- Line: 53, Name: testMiddleware
                    -- upvalues: u10 (ref), u12 (ref), u13 (ref), u11 (ref), u14 (ref)
                    u10 = u10 + 1;
                    u12 = u17;
                    u13 = p18;

                    return function(p19) -- Line: 58
                        -- upvalues: u11 (ref), u14 (ref), u17 (copy)
                        u11 = u11 + 1;
                        u14 = p19;
                        u17(p19);
                    end;
                end });
            expect(u10).to.equal(1);
            expect(u11).to.equal(0);
            expect(u12).to.be.a("function");
            expect(u13).to.equal(v20);
            v20:dispatch({
                type = "test"
            });
            expect(u10).to.equal(1);
            expect(u11).to.equal(1);
            expect(u14.type).to.equal("test");
            v20:flush();
            expect(v20:getState()).to.equal("test state");
            v20:destruct();
        end);
        it("should execute middleware left-to-right", function() -- Line: 88
            -- upvalues: Store (ref)
            local u21 = {};
            local v29 = Store.new(function(p22) -- Line: 91, Name: reducer
                return p22;
            end, 5, { function(u23, p24) -- Line: 95, Name: middlewareA
                    -- upvalues: u21 (copy)
                    table.insert(u21, "instantiate a");

                    return function(p25) -- Line: 97
                        -- upvalues: u21 (ref), u23 (copy)
                        table.insert(u21, "execute a");

                        return u23(p25);
                    end;
                end, function(u26, p27) -- Line: 103, Name: middlewareB
                    -- upvalues: u21 (copy)
                    table.insert(u21, "instantiate b");

                    return function(p28) -- Line: 105
                        -- upvalues: u21 (ref), u26 (copy)
                        table.insert(u21, "execute b");

                        return u26(p28);
                    end;
                end });
            expect(#u21).to.equal(2);
            expect(u21[1]).to.equal("instantiate b");
            expect(u21[2]).to.equal("instantiate a");
            v29:dispatch({
                type = "test"
            });
            expect(#u21).to.equal(4);
            expect(u21[3]).to.equal("execute a");
            expect(u21[4]).to.equal("execute b");
            v29:destruct();
        end);
        it("should send an initial action with a \'type\' field", function() -- Line: 128
            -- upvalues: Store (ref)
            local u30 = nil;
            local u31 = 0;
            local v34 = Store.new(function(p32, p33) -- Line: 132
                -- upvalues: u30 (ref), u31 (ref)
                u30 = p33;
                u31 = u31 + 1;

                return p32;
            end);
            expect(u31).to.equal(1);
            expect(u30).to.be.a("table");
            expect(u30.type).to.be.ok();
            v34:destruct();
        end);
        it("should report a reducer error thrown when handling the INIT action", function() -- Line: 146
            -- upvalues: Store (ref)
            local u35 = nil;
            local u36 = nil;
            local u37 = nil;
            local v43 = Store.new(function(p38, p39) -- Line: 160
                error("Z4PH0D");
            end, {
                Value = 1
            }, nil, {
                reportReducerError = function(p40, p41, p42) -- Line: 149, Name: reportReducerError
                    -- upvalues: u35 (ref), u36 (ref), u37 (ref)
                    u35 = p40;
                    u36 = p41;
                    u37 = p42;
                end,

                reportUpdateError = function() -- Line: 154, Name: reportUpdateError
                end
            });
            expect(u35.Value).to.equal(1);
            expect(u36.type).to.equal("@@INIT");
            expect(u37.message).to.equal("Caught error in reducer with init");
            expect(string.find(u37.thrownValue, "Z4PH0D")).to.be.ok();
            expect(string.find(u37.thrownValue, script.Name)).to.be.ok();
            v43:destruct();
        end);
        it("should report a reducer error thrown when handling a subsequent action", function() -- Line: 187
            -- upvalues: Store (ref)
            local u44 = nil;
            local u45 = nil;
            local u46 = nil;
            local v52 = Store.new(function(p47, p48) -- Line: 201
                if p48.type ~= "ThrowError" then
                    return p48.type == "Increment" and {
                        Value = p47.Value + 1
                    } or p47;
                end;

                error("Z4PH0D");

                return p47;
            end, {
                Value = 1
            }, nil, {
                reportReducerError = function(p49, p50, p51) -- Line: 190, Name: reportReducerError
                    -- upvalues: u44 (ref), u45 (ref), u46 (ref)
                    u44 = p49;
                    u45 = p50;
                    u46 = p51;
                end,

                reportUpdateError = function() -- Line: 195, Name: reportUpdateError
                end
            });
            expect(u44).to.equal(nil);
            expect(u45).to.equal(nil);
            expect(u46).to.equal(nil);
            v52:dispatch({
                type = "Increment"
            });
            v52:dispatch({
                type = "ThrowError"
            });
            expect(u44.Value).to.equal(2);
            expect(u45.type).to.equal("ThrowError");
            expect(u46.message).to.equal("Caught error in reducer");
            expect(string.find(u46.thrownValue, "Z4PH0D")).to.be.ok();
            expect(string.find(u46.thrownValue, script.Name)).to.be.ok();
            v52:destruct();
        end);
    end);
    describe("getState", function() -- Line: 244
        -- upvalues: Store (copy)
        it("should get the current state", function() -- Line: 245
            -- upvalues: Store (ref)
            local v55 = Store.new(function(p53, p54) -- Line: 246
                return "foo";
            end);
            local v56 = v55:getState();
            expect(v56).to.equal("foo");
            v55:destruct();
        end);
        it("should throw errors if triggered during dispatches", function() -- Line: 257
            -- upvalues: Store (ref)
            local u57 = nil;
            u57 = Store.new(function(p58, p59) -- Line: 259
                -- upvalues: u57 (ref)
                if p59.type ~= "@@INIT" then
                    u57:getState();
                end;
            end);
            expect(function() -- Line: 265
                -- upvalues: u57 (ref)
                u57:dispatch({
                    type = "SomeAction"
                });
            end).to.throw();
            u57:destruct();
        end);
    end);
    describe("dispatch", function() -- Line: 273
        -- upvalues: Store (copy)
        it("should be sent through the reducer", function() -- Line: 274
            -- upvalues: Store (ref)
            local v62 = Store.new(function(p60, p61) -- Line: 275
                return p61.type == "act" and "bar" or (p60 or "foo");
            end);
            expect(v62).to.be.ok();
            expect(v62:getState()).to.equal("foo");
            v62:dispatch({
                type = "act"
            });
            v62:flush();
            expect(v62:getState()).to.equal("bar");
            v62:destruct();
        end);
        it("should trigger the changed event after a flush", function() -- Line: 299
            -- upvalues: Store (ref)
            local v66 = Store.new(function(p63, p64) -- Line: 300
                local v65 = p63 or 0;

                if p64.type == "increment" then
                    return v65 + 1;
                end;

                return v65;
            end);
            local u67 = 0;
            v66.changed:connect(function(p68, p69) -- Line: 312
                -- upvalues: u67 (ref)
                expect(p69).to.equal(0);
                expect(p68).to.equal(1);
                u67 = u67 + 1;
            end);
            v66:dispatch({
                type = "increment"
            });
            v66:flush();
            expect(u67).to.equal(1);
            v66:destruct();
        end);
        it("should handle actions dispatched within the changed event", function() -- Line: 330
            -- upvalues: Store (ref)
            local u73 = Store.new(function(p70, p71) -- Line: 331
                local v72 = p70 or {
                    value = 0
                };

                return p71.type == "increment" and {
                    value = v72.value + 1
                } or (p71.type == "decrement" and {
                    value = v72.value - 1
                } or v72);
            end);
            local u74 = 0;
            u73.changed:connect(function(p75, p76) -- Line: 351
                -- upvalues: u73 (copy), u74 (ref)
                expect(p75).never.to.equal(p76);

                if p75.value > 0 then
                    u73:dispatch({
                        type = "decrement"
                    });
                end;

                u74 = u74 + 1;
            end);
            u73:dispatch({
                type = "increment"
            });
            u73:flush();
            u73:flush();
            expect(u74).to.equal(2);
            u73:destruct();
        end);
        it("should prevent yielding from changed handler", function() -- Line: 374
            -- upvalues: Store (ref)
            local u77 = nil;
            local u78 = nil;
            local v83 = {
                reportUpdateError = function(p79, p80, p81, p82) -- Line: 377, Name: reportUpdateError
                    -- upvalues: u77 (ref), u78 (ref)
                    u77 = p82.message;
                    u78 = p82.thrownValue;
                end,

                reportReducerError = function() -- Line: 381, Name: reportReducerError
                end
            };
            local u84 = 0;
            local u85 = 0;
            local v88 = Store.new(function(p86, p87) -- Line: 388
                return (p86 or 0) + 1;
            end, nil, nil, v83);
            v88.changed:connect(function(p89, p90) -- Line: 393
                -- upvalues: u84 (ref), u85 (ref)
                u84 = u84 + 1;
                wait();
                u85 = u85 + 1;
            end);
            v88:dispatch({
                type = "increment"
            });
            v88:flush();
            expect(u84).to.equal(1);
            expect(u85).to.equal(0);
            expect(u77).to.equal("Caught error flushing store updates");
            expect(string.find(u78, script.Name)).to.be.ok();
            expect(string.find(u78, "to yield")).to.be.ok();
            v88:destruct();
        end);
        it("should throw if an action is dispatched without a type field", function() -- Line: 424
            -- upvalues: Store (ref)
            local u93 = Store.new(function(p91, p92) -- Line: 425
                return p91;
            end);
            expect(function() -- Line: 429
                -- upvalues: u93 (copy)
                u93:dispatch({});
            end).to.throw();
            u93:destruct();
        end);
        it("should throw if the action is not a function or table", function() -- Line: 436
            -- upvalues: Store (ref)
            local u96 = Store.new(function(p94, p95) -- Line: 437
                return p94;
            end);
            expect(function() -- Line: 441
                -- upvalues: u96 (copy)
                u96:dispatch(1);
            end).to.throw();
            u96:destruct();
        end);
        it("should report an error if the listeners error when flushing", function() -- Line: 448
            -- upvalues: Store (ref)
            local u97 = nil;
            local u98 = nil;
            local u99 = nil;
            local u100 = nil;
            local v107 = Store.new(function(p101, p102) -- Line: 462
                return p102.type == "Increment" and {
                    Value = p101.Value + p102.amount
                } or p101;
            end, {
                Value = 1
            }, nil, {
                reportReducerError = function() -- Line: 451, Name: reportReducerError
                end,

                reportUpdateError = function(p103, p104, p105, p106) -- Line: 454, Name: reportUpdateError
                    -- upvalues: u97 (ref), u98 (ref), u99 (ref), u100 (ref)
                    u97 = p103;
                    u98 = p104;
                    u99 = p105;
                    u100 = p106;
                end
            });
            v107.changed:connect(function(p108, p109) -- Line: 475
                if p108.Value == 15 then
                    error("Z4PH0D");
                end;
            end);
            local v110 = { {
                    type = "Increment",
                    amount = 1
                }, {
                    type = "Increment",
                    amount = 3
                }, {
                    type = "Increment",
                    amount = 10
                } };

            for _, v in ipairs(v110) do
                v107:dispatch(v);
            end;

            v107:flush();
            expect(u100.message).to.equal("Caught error flushing store updates");
            expect(string.find(u100.thrownValue, script.Name)).to.be.ok();
            expect(u99[1]).to.equal(v110[1]);
            expect(u99[2]).to.equal(v110[2]);
            expect(u99[3]).to.equal(v110[3]);
            expect(u97.Value).to.equal(1);
            expect(u98.Value).to.equal(15);
            v107:destruct();
        end);
        it("should throw errors if dispatching while a dispatch is already happening", function() -- Line: 509
            -- upvalues: Store (ref)
            local u111 = nil;
            u111 = Store.new(function(p112, p113) -- Line: 511
                -- upvalues: u111 (ref)
                if p113.type == "SomeAction" then
                    u111:dispatch({
                        type = "MidDispatchAction"
                    });
                end;
            end);
            expect(function() -- Line: 517
                -- upvalues: u111 (ref)
                u111:dispatch({
                    type = "SomeAction"
                });
            end).to.throw();
            u111:destruct();
        end);
    end);
    describe("flush", function() -- Line: 525
        -- upvalues: Store (copy)
        it("should not fire a changed event if there were no dispatches", function() -- Line: 526
            -- upvalues: Store (ref)
            local v114 = Store.new(function() -- Line: 527
            end);
            local u115 = 0;
            v114.changed:connect(function() -- Line: 531
                -- upvalues: u115 (ref)
                u115 = u115 + 1;
            end);
            v114:flush();
            expect(u115).to.equal(0);
            v114:dispatch({
                type = "increment"
            });
            v114:flush();
            expect(u115).to.equal(1);
            v114:flush();
            expect(u115).to.equal(1);
            v114:destruct();
        end);
    end);
end;