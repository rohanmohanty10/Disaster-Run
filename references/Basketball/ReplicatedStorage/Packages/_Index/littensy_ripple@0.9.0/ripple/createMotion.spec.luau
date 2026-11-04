 
 

return function() -- Line: 1
    require(script.Parent.types);
    local createMotion = require(script.Parent.createMotion);
    local linear = require(script.Parent.solvers.linear);
    local spy = require(script.Parent.utils.spy);
    it("should return a Motion", function() -- Line: 7
        -- upvalues: createMotion (copy)
        local v1 = createMotion(0);
        expect(v1).to.be.ok();
        expect(v1.state).to.be.a("table");
        expect(v1.start).to.be.a("function");
        expect(v1.stop).to.be.a("function");
        expect(v1.get).to.be.a("function");
        expect(v1.set).to.be.a("function");
        expect(v1.getVelocity).to.be.a("function");
        expect(v1.setVelocity).to.be.a("function");
        expect(v1.patch).to.be.a("function");
        expect(v1.impulse).to.be.a("function");
        expect(v1.to).to.be.a("function");
        expect(v1.step).to.be.a("function");
        expect(v1.isComplete).to.be.a("function");
        expect(v1.onComplete).to.be.a("function");
        expect(v1.onStep).to.be.a("function");
        expect(v1.destroy).to.be.a("function");
    end);
    it("should animate a number", function() -- Line: 27
        -- upvalues: createMotion (copy), linear (copy)
        local v2 = createMotion(0);
        v2:to(linear(1, {
            speed = 1
        }));
        v2:step(0.5);
        expect(v2:get()).to.equal(0.5);
        expect(v2:isComplete()).to.equal(false);
        v2:step(0.5);
        expect(v2:get()).to.equal(1);
        expect(v2:isComplete()).to.equal(true);
    end);
    it("should animate a vector", function() -- Line: 42
        -- upvalues: createMotion (copy), linear (copy)
        local v3 = createMotion((Vector3.new()));
        v3:to(linear(Vector3.new(0.5, 0.75, 1), {
            speed = 1
        }));
        v3:step(0.5);
        expect(v3:get()).to.equal(Vector3.new(0.5, 0.5, 0.5));
        expect(v3:isComplete()).to.equal(false);
        v3:step(0.5);
        expect(v3:get()).to.equal(Vector3.new(0.5, 0.75, 1));
        expect(v3:isComplete()).to.equal(true);
    end);
    it("should animate an array", function() -- Line: 57
        -- upvalues: createMotion (copy), linear (copy)
        local v4 = createMotion({ 0, 0, 0 });
        v4:to(linear({ 0.5, 0.75, 1 }, {
            speed = 1
        }));
        v4:step(0.5);
        expect(v4:get()[1]).to.equal(0.5);
        expect(v4:get()[2]).to.equal(0.5);
        expect(v4:get()[3]).to.equal(0.5);
        v4:step(0.5);
        expect(v4:get()[1]).to.equal(0.5);
        expect(v4:get()[2]).to.equal(0.75);
        expect(v4:get()[3]).to.equal(1);
    end);
    describe("when calling \'step\'", function() -- Line: 74
        -- upvalues: createMotion (copy), spy (copy), linear (copy)
        it("should call onStep", function() -- Line: 75
            -- upvalues: createMotion (ref), spy (ref), linear (ref)
            local v5 = createMotion(0);
            local v6 = spy();
            v5:onStep(v6.handle);
            v5:to(linear(1, {
                speed = 1
            }));
            v5:step(0.5);
            expect(v6.calls).to.equal(1);
            expect(v6.arguments[1][1]).to.equal(0.5);
            expect(v6.arguments[1][2]).to.equal(0.5);
            v5:step(0.5);
            expect(v6.calls).to.equal(2);
            expect(v6.arguments[2][1]).to.equal(1);
            expect(v6.arguments[2][2]).to.equal(0.5);
            v5:step(0.5);
            expect(v6.calls).to.equal(2);
            v5:to(linear(0, {
                speed = 1
            }));
            v5:step(0.5);
            expect(v6.calls).to.equal(3);
            expect(v6.arguments[3][1]).to.equal(0.5);
            expect(v6.arguments[3][2]).to.equal(0.5);
        end);
        it("should call onComplete", function() -- Line: 105
            -- upvalues: createMotion (ref), spy (ref), linear (ref)
            local v7 = createMotion(0);
            local v8 = spy();
            v7:onComplete(v8.handle);
            v7:to(linear(1, {
                speed = 1
            }));
            v7:step(0.5);
            expect(v8.calls).to.equal(0);
            v7:step(0.5);
            expect(v8.calls).to.equal(1);
            expect(v8.arguments[1][1]).to.equal(1);
            v7:step(0.5);
            expect(v8.calls).to.equal(1);
            v7:to(linear(0, {
                speed = 1
            }));
            v7:step(1);
            expect(v8.calls).to.equal(2);
            expect(v8.arguments[2][1]).to.equal(0);
        end);
        it("should not run completed solvers", function() -- Line: 131
            -- upvalues: createMotion (ref), spy (ref)
            local v9 = createMotion({
                a = 0,
                b = 0
            });
            local v10 = spy();
            local u11 = spy();
            v9:to({
                a = v10.handle,

                b = function(p12, p13, p14) -- Line: 138, Name: b
                    -- upvalues: u11 (copy)
                    u11.handle(p12, p13, p14);
                    p13.value = 1;
                    p13.complete = true;
                end
            });
            expect(v9.state.a.complete).to.equal(false);
            expect(v9.state.b.complete).to.equal(true);
            expect(v10.calls).to.equal(1);
            expect(u11.calls).to.equal(1);
            v9:step(1);
            expect(v9.state.a.complete).to.equal(false);
            expect(v9.state.b.complete).to.equal(true);
            expect(v10.calls).to.equal(2);
            expect(u11.calls).to.equal(1);
        end);
    end);
    describe("when calling \'to\'", function() -- Line: 159
        -- upvalues: createMotion (copy), spy (copy), linear (copy)
        it("should destroy the old solver", function() -- Line: 160
            -- upvalues: createMotion (ref), spy (ref), linear (ref)
            local v15 = createMotion(0);
            local u16 = spy();
            v15:to(function(p17, p18) -- Line: 164
                -- upvalues: u16 (copy)
                p18.destructor = u16.handle;
            end);
            v15:step(1);
            expect(u16.calls).to.equal(0);
            v15:to(linear(1));
            expect(u16.calls).to.equal(1);
        end);
        it("should accept solvers per key", function() -- Line: 175
            -- upvalues: createMotion (ref), linear (ref)
            local v19 = createMotion({
                a = 0,
                b = 0
            });
            v19:to({
                a = linear(1, {
                    speed = 1
                }),
                b = linear(1, {
                    speed = 0.5
                })
            });
            v19:step(0.5);
            expect(v19:get().a).to.equal(0.5);
            expect(v19:get().b).to.equal(0.25);
            expect(v19:isComplete()).to.equal(false);
            v19:step(0.5);
            expect(v19:get().a).to.equal(1);
            expect(v19:get().b).to.equal(0.5);
            expect(v19:isComplete()).to.equal(false);
            v19:step(1);
            expect(v19:get().a).to.equal(1);
            expect(v19:get().b).to.equal(1);
            expect(v19:isComplete()).to.equal(true);
        end);
        it("should mount the solver", function() -- Line: 202
            -- upvalues: createMotion (ref), spy (ref)
            local v20 = createMotion(0);
            local v21 = spy();
            v20:to(v21.handle);
            expect(v21.calls).to.equal(1);
            expect(v21.arguments[1][1]).to.equal(1);
            expect(v21.arguments[1][2]).to.be.a("table");
            expect(v21.arguments[1][3]).to.equal(0);
        end);
        it("should accept complex solvers", function() -- Line: 214
            -- upvalues: createMotion (ref), linear (ref)
            local v22 = createMotion({
                a = 0,
                b = 0
            });
            v22:to(linear({
                a = 1
            }, {
                speed = 1
            }));
            v22:to(linear({
                b = 1
            }, {
                speed = 1
            }));
            v22:step(0.5);
            expect(v22:get().a).to.equal(0.5);
            expect(v22:get().b).to.equal(0.5);
            expect(v22:isComplete()).to.equal(false);
            v22:step(0.5);
            expect(v22:get().a).to.equal(1);
            expect(v22:get().b).to.equal(1);
            expect(v22:isComplete()).to.equal(true);
        end);
    end);
    describe("when passing options", function() -- Line: 233
        -- upvalues: createMotion (copy), linear (copy)
        it("should accept heartbeat", function() -- Line: 234
            -- upvalues: createMotion (ref), linear (ref)
            local u23 = {};

            local function step(p24: number) -- Line: 248
                -- upvalues: u23 (copy)
                for _, v in u23 do
                    v(p24);
                end;
            end;

            local v27 = createMotion(0, {
                start = true,
                heartbeat = {
                    Connect = function(p25, u26) -- Line: 238, Name: connect
                        -- upvalues: u23 (copy)
                        table.insert(u23, u26);

                        return {
                            Disconnect = function() -- Line: 241, Name: disconnect
                                -- upvalues: u23 (ref), u26 (copy)
                                table.remove(u23, table.find(u23, u26) or -1);
                            end
                        };
                    end
                }
            });
            v27:to(linear(1, {
                speed = 1
            }));

            for _, v in u23 do
                v(0.5);
            end;

            expect(v27:get()).to.equal(0.5);
            expect(v27:isComplete()).to.equal(false);

            for _, v in u23 do
                v(0.5);
            end;

            expect(v27:get()).to.equal(1);
            expect(v27:isComplete()).to.equal(true);
        end);
    end);
    describe("patching state", function() -- Line: 276
        -- upvalues: createMotion (copy), linear (copy)
        it("should set a value", function() -- Line: 277
            -- upvalues: createMotion (ref), linear (ref)
            local v28 = createMotion({
                a = 0,
                b = 0
            });
            v28:to({
                a = linear(1, {
                    speed = 1
                }),
                b = linear(1, {
                    speed = 0.5
                })
            });
            v28:step(0.5);
            expect(v28:get().a).to.equal(0.5);
            expect(v28:get().b).to.equal(0.25);
            v28:set({
                a = 2
            });
            v28:step(0.5);
            expect(v28:get().a).to.equal(1.5);
            expect(v28:get().b).to.equal(0.5);
        end);
        it("should flag as incomplete", function() -- Line: 297
            -- upvalues: createMotion (ref), linear (ref)
            local v29 = createMotion({
                a = 0,
                b = 0
            });
            v29:to({
                a = linear(1, {
                    speed = 1
                }),
                b = linear(1, {
                    speed = 1
                })
            });
            v29:step(1);
            expect(v29:isComplete()).to.equal(true);
            v29:set({
                a = 2
            });
            expect(v29:isComplete()).to.equal(false);
            v29:step(1);
            expect(v29:isComplete()).to.equal(true);
        end);
        it("should patch the state", function() -- Line: 315
            -- upvalues: createMotion (ref)
            local v30 = createMotion({
                a = 0,
                b = 0
            });
            v30:patch({
                a = {
                    value = 1
                }
            });
            expect(v30:get().a).to.equal(1);
            expect(v30:get().b).to.equal(0);
        end);
    end);
end;