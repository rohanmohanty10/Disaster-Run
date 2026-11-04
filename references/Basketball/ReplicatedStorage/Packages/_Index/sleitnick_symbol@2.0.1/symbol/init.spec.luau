 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
return function()
	local Symbol = require(script.Parent)

	describe("Constructor", function()
		it("should create a new symbol", function()
			local symbol = Symbol("Test")
			expect(symbol).to.be.a("userdata")
			expect(symbol == symbol).to.equal(true)
			expect(tostring(symbol)).to.equal("Symbol(Test)")
		end)

		it("should create a new symbol with no name", function()
			local symbol = Symbol()
			expect(symbol).to.be.a("userdata")
			expect(symbol == symbol).to.equal(true)
			expect(tostring(symbol)).to.equal("Symbol()")
		end)

		it("should be unique regardless of the name", function()
			expect(Symbol("Test") == Symbol("Test")).to.equal(false)
			expect(Symbol() == Symbol()).to.equal(false)
			expect(Symbol("Test") == Symbol()).to.equal(false)
			expect(Symbol("Test1") == Symbol("Test2")).to.equal(false)
		end)

		it("should be useable as a table key", function()
			local symbol = Symbol()
			local t = {}
			t[symbol] = 100
			expect(t[symbol]).to.equal(100)
		end)
	end)
end

]]

 

return function() -- Line: 1
    local script_Parent = require(script.Parent);
    describe("Constructor", function() -- Line: 4
        -- upvalues: script_Parent (copy)
        it("should create a new symbol", function() -- Line: 5
            -- upvalues: script_Parent (ref)
            local v1 = script_Parent("Test");
            expect(v1).to.be.a("userdata");
            expect(v1 == v1).to.equal(true);
            expect((tostring(v1))).to.equal("Symbol(Test)");
        end);
        it("should create a new symbol with no name", function() -- Line: 12
            -- upvalues: script_Parent (ref)
            local v2 = script_Parent();
            expect(v2).to.be.a("userdata");
            expect(v2 == v2).to.equal(true);
            expect((tostring(v2))).to.equal("Symbol()");
        end);
        it("should be unique regardless of the name", function() -- Line: 19
            -- upvalues: script_Parent (ref)
            expect(script_Parent("Test") == script_Parent("Test")).to.equal(false);
            expect(script_Parent() == script_Parent()).to.equal(false);
            expect(script_Parent("Test") == script_Parent()).to.equal(false);
            expect(script_Parent("Test1") == script_Parent("Test2")).to.equal(false);
        end);
        it("should be useable as a table key", function() -- Line: 26
            -- upvalues: script_Parent (ref)
            local v3 = script_Parent();
            expect(({
                [v3] = 100
            })[v3]).to.equal(100);
        end);
    end);
end;