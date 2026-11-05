  

 

return function() -- Line: 1
    local NoYield = require(script.Parent.NoYield);
    it("should call functions normally", function() -- Line: 4
        -- upvalues: NoYield (copy)
        local u1 = 0;
        local v4, v5 = NoYield(function(p2, p3) -- Line: 7, Name: test
            -- upvalues: u1 (ref)
            expect(p2).to.equal(5);
            expect(p3).to.equal(6);
            u1 = u1 + 1;

            return 11, "hello";
        end, 5, 6);
        expect(v4).to.equal(11);
        expect(v5).to.equal("hello");
    end);
    it("should throw on yield", function() -- Line: 22
        -- upvalues: NoYield (copy)
        local u6 = 0;
        local u7 = 0;
        local success, result = pcall(NoYield, function() -- Line: 26, Name: testMethod
            -- upvalues: u6 (ref), u7 (ref)
            u6 = u6 + 1;
            wait();
            u7 = u7 + 1;
        end);
        expect(u6).to.equal(1);
        expect(u7).to.equal(0);
        expect(success).to.equal(false);
        expect(result:find("Attempted to yield inside changed event!")).to.be.ok();
        expect(result:find("NoYield.spec")).to.be.ok();
    end);
    it("should propagate error messages", function() -- Line: 42
        -- upvalues: NoYield (copy)
        local u8 = 0;
        local success, result = pcall(NoYield, function() -- Line: 45, Name: test
            -- upvalues: u8 (ref)
            u8 = u8 + 1;
            error("foo");
        end);
        expect(success).to.equal(false);
        expect(result:find("foo")).to.be.ok();
        expect(result:find("NoYield.spec")).to.be.ok();
    end);
end;