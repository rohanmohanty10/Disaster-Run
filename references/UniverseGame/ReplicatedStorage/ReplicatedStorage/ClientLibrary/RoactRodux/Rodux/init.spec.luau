  

 

return function() -- Line: 1
    describe("Rodux", function() -- Line: 2
        it("should load", function() -- Line: 3
            local Parent = require(script.Parent);
            expect(Parent.Store).to.be.ok();
        end);
    end);
end;