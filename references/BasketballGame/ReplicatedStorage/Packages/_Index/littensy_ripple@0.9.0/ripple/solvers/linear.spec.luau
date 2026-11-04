 
 

return function() -- Line: 1
    local createMotion = require(script.Parent.Parent.createMotion);
    local linear = require(script.Parent.linear);
    it("should animate a value", function() -- Line: 5
        -- upvalues: createMotion (copy), linear (copy)
        local v1 = createMotion(0);
        v1:to(linear(1, {
            speed = 1
        }));
        v1:step(0.5);
        expect(v1:get()).to.equal(0.5);
        expect(v1:isComplete()).to.equal(false);
        v1:step(0.5);
        expect(v1:get()).to.equal(1);
        expect(v1:isComplete()).to.equal(true);
    end);
    it("should animate multiple values", function() -- Line: 20
        -- upvalues: createMotion (copy), linear (copy)
        local v2 = createMotion({
            x = 0,
            y = 0
        });
        v2:to(linear({
            x = 1,
            y = 1
        }, {
            speed = 1
        }));
        v2:step(0.5);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(0.5);
        expect(v2:get().y).to.equal(0.5);
        expect(v2:isComplete()).to.equal(false);
        v2:step(0.5);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(1);
        expect(v2:get().y).to.equal(1);
        expect(v2:isComplete()).to.equal(true);
        v2:to({
            x = linear(2, {
                speed = 1
            }),
            y = linear(2, {
                speed = 0.5
            })
        });
        v2:step(0.5);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(1.5);
        expect(v2:get().y).to.equal(1.25);
        expect(v2:isComplete()).to.equal(false);
        v2:step(0.5);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(2);
        expect(v2:get().y).to.equal(1.5);
        expect(v2:isComplete()).to.equal(false);
        v2:step(1);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(2);
        expect(v2:get().y).to.equal(2);
        expect(v2:isComplete()).to.equal(true);
    end);
    it("should complete if overshooting", function() -- Line: 65
        -- upvalues: createMotion (copy), linear (copy)
        local v3 = createMotion(0);
        v3:to(linear(1, {
            speed = 1
        }));
        v3:step(1000);
        expect(v3:get()).to.equal(1);
        expect(v3:isComplete()).to.equal(true);
    end);
end;