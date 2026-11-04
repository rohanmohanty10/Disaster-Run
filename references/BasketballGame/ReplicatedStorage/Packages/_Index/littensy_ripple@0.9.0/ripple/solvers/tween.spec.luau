 
 

return function() -- Line: 1
    local createMotion = require(script.Parent.Parent.createMotion);
    local tween = require(script.Parent.tween);
    it("should animate a value", function() -- Line: 7
        -- upvalues: createMotion (copy), tween (copy)
        local v1 = createMotion(0);
        v1:to(tween(1, {
            time = 0.01
        }));
        v1:step(0);
        expect(v1:get()).to.equal(0);
        task.wait(0.05);
        v1:step(0);
        expect(v1:get()).to.equal(1);
    end);
    it("should animate multiple values", function() -- Line: 21
        -- upvalues: createMotion (copy), tween (copy)
        local v2 = createMotion({
            x = 0,
            y = 0
        });
        v2:to(tween({
            x = 1,
            y = 2
        }, {
            time = 0.01
        }));
        v2:step(0);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(0);
        expect(v2:get().y).to.equal(0);
        task.wait(0.05);
        v2:step(0);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(1);
        expect(v2:get().y).to.equal(2);
        v2:to({
            x = tween(2, {
                time = 0.01
            }),
            y = tween(3, {
                time = 0.1
            })
        });
        v2:step(0);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(1);
        expect(v2:get().y).to.equal(2);
        task.wait(0.05);
        v2:step(0);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(2);
        expect(v2:get().y).to.never.equal(3);
        task.wait(0.05);
        v2:step(0);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(2);
        expect(v2:get().y).to.equal(3);
    end);
end;