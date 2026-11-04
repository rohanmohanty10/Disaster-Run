  

return function() -- Line: 1
    local createMotion = require(script.Parent.Parent.createMotion);
    local immediate = require(script.Parent.immediate);
    it("should set a value", function() -- Line: 5
        -- upvalues: createMotion (copy), immediate (copy)
        local v1 = createMotion({
            x = 0,
            y = 0
        });
        v1:to(immediate({
            x = 1,
            y = 1
        }));
        v1:step(0);
        expect(v1:get()).to.be.ok();
        expect(v1:get().x).to.equal(1);
        expect(v1:get().y).to.equal(1);
        expect(v1:isComplete()).to.equal(true);
    end);
    it("should set multiple values", function() -- Line: 17
        -- upvalues: createMotion (copy), immediate (copy)
        local v2 = createMotion({
            x = 0,
            y = 0
        });
        v2:to({
            x = immediate(1),
            y = immediate(1)
        });
        v2:step(0);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(1);
        expect(v2:get().y).to.equal(1);
        expect(v2:isComplete()).to.equal(true);
        v2:to({
            x = immediate(2),
            y = immediate(2)
        });
        v2:step(0);
        expect(v2:get()).to.be.ok();
        expect(v2:get().x).to.equal(2);
        expect(v2:get().y).to.equal(2);
        expect(v2:isComplete()).to.equal(true);
    end);
end;