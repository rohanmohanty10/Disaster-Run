  

return function() -- Line: 1
    local createMotion = require(script.Parent.Parent.createMotion);
    local snapshot = require(script.Parent.Parent.utils.snapshot);
    local spring = require(script.Parent.spring);
    it("should animate a value", function() -- Line: 19
        -- upvalues: snapshot (copy), spring (copy)
        local v1 = snapshot.testSnapshot(spring(1), "[0.37,0.73,0.9,0.96,0.98,0.99,0.99,0.99,0.99,1]");
        expect(v1:get()).to.equal(1);
        expect(v1:isComplete()).to.equal(true);
    end);
    it("should accept damping ratio", function() -- Line: 25
        -- upvalues: snapshot (copy), spring (copy)
        local v2 = snapshot.testSnapshot(spring(1, {
            damping = 0.75
        }), "[0.41,0.84,1.01,1.03,1.02,1.01,0.99,0.99,0.99,1]");
        expect(v2:isComplete()).to.equal(true);
        local v3 = snapshot.testSnapshot(spring(1, {
            damping = 1
        }), "[0.36,0.71,0.89,0.95,0.98,0.99,0.99,0.99,0.99,1]");
        expect(v3:isComplete()).to.equal(true);
        local v4 = snapshot.testSnapshot(spring(1, {
            damping = 1.3
        }), "[0.31,0.6,0.78,0.87,0.93,0.96,0.97,0.98,0.99,0.99,0.99,0.99,0.99,0.99,0.99,0.99]");
        expect(v4:isComplete()).to.equal(false);
    end);
    it("should accept tension", function() -- Line: 38
        -- upvalues: snapshot (copy), spring (copy)
        local v5 = snapshot.testSnapshot(spring(1, {
            tension = 200
        }), "[0.43,0.81,0.95,0.99,0.99,1.01,1.01,1]");
        expect(v5:isComplete()).to.equal(true);
        local v6 = snapshot.testSnapshot(spring(1, {
            tension = 300
        }), "[0.61,0.98,1.03,1.01,0.99,0.99,1]");
        expect(v6:isComplete()).to.equal(true);
    end);
    it("should accept mass", function() -- Line: 48
        -- upvalues: snapshot (copy), spring (copy)
        local v7 = snapshot.testSnapshot(spring(1, {
            mass = 0.5
        }), "[0.44,0.74,0.87,0.94,0.97,0.98,0.99,0.99,0.99,0.99,0.99,0.99,1]");
        expect(v7:isComplete()).to.equal(true);
        local v8 = snapshot.testSnapshot(spring(1, {
            mass = 2
        }), "[0.27,0.67,0.92,1.03,1.05,1.03,1.02,1.01,0.99,0.99,0.99,0.99,1]");
        expect(v8:isComplete()).to.equal(true);
    end);
    it("should accept friction", function() -- Line: 58
        -- upvalues: snapshot (copy), spring (copy)
        local v9 = snapshot.testSnapshot(spring(1, {
            friction = 20
        }), "[0.43,0.85,1.01,1.03,1.01,1.01,0.99,0.99,0.99,1]");
        expect(v9:isComplete()).to.equal(true);
        local v10 = snapshot.testSnapshot(spring(1, {
            friction = 30
        }), "[0.35,0.67,0.84,0.92,0.96,0.98,0.99,0.99,0.99,0.99,0.99,0.99,1]");
        expect(v10:isComplete()).to.equal(true);
    end);
    describe("when passed initial values", function() -- Line: 68
        -- upvalues: createMotion (copy), spring (copy)
        it("should accept position", function() -- Line: 69
            -- upvalues: createMotion (ref), spring (ref)
            local v11 = createMotion(0);
            v11:to(spring(1, {
                position = 0.5
            }));
            expect(v11:get()).to.equal(0.5);
        end);
        it("should accept velocity", function() -- Line: 75
            -- upvalues: createMotion (ref), spring (ref)
            local v12 = createMotion(0);
            v12:to(spring(1, {
                velocity = 1000
            }));
            expect(v12.state[1].velocity).to.equal(1000);
            v12:step(0.1);
            expect(v12:get() > 1).to.equal(true);
        end);
        it("should apply impulse", function() -- Line: 85
            -- upvalues: createMotion (ref), spring (ref)
            local v13 = createMotion(0);
            v13:to(spring(1, {
                impulse = 1
            }));
            v13:to(spring(1, {
                impulse = 1
            }));
            expect(v13.state[1].velocity).to.equal(2);
        end);
    end);
end;