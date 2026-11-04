 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
return function()
	local EnumList = require(script.Parent)

	describe("Constructor", function()
		it("should create a new enumlist", function()
			expect(function()
				EnumList.new("Test", { "ABC", "XYZ" })
			end).never.to.throw()
		end)

		it("should fail to create a new enumlist with no name", function()
			expect(function()
				EnumList.new(nil, { "ABC", "XYZ" })
			end).to.throw()
		end)

		it("should fail to create a new enumlist with no enums", function()
			expect(function()
				EnumList.new("Test")
			end).to.throw()
		end)

		it("should fail to create a new enumlist with non string enums", function()
			expect(function()
				EnumList.new("Test", { true, false, 32, "ABC" })
			end).to.throw()
		end)
	end)

	describe("Access", function()
		it("should be able to access enum items", function()
			local test = EnumList.new("Test", { "ABC", "XYZ" })
			expect(function()
				local _item = test.ABC
			end).never.to.throw()
			expect(test:BelongsTo(test.ABC)).to.equal(true)
		end)

		it("should throw if trying to modify the enumlist", function()
			local test = EnumList.new("Test", { "ABC", "XYZ" })
			expect(function()
				test.Hello = 32
			end).to.throw()
			expect(function()
				test.ABC = 32
			end).to.throw()
		end)

		it("should throw if trying to modify an enumitem", function()
			local test = EnumList.new("Test", { "ABC", "XYZ" })
			expect(function()
				local abc = test.ABC
				abc.XYZ = 32
			end).to.throw()
			expect(function()
				local abc = test.ABC
				abc.Name = "NewName"
			end).to.throw()
		end)

		it("should get the name", function()
			local test = EnumList.new("Test", { "ABC", "XYZ" })
			local name = test:GetName()
			expect(name).to.equal("Test")
		end)
	end)

	describe("Get Items", function()
		it("should be able to get all enum items", function()
			local test = EnumList.new("Test", { "ABC", "XYZ" })
			local items = test:GetEnumItems()
			expect(items).to.be.a("table")
			expect(#items).to.equal(2)
			for i, enumItem in ipairs(items) do
				expect(enumItem).to.be.a("table")
				expect(enumItem.Name).to.be.a("string")
				expect(enumItem.Value).to.be.a("number")
				expect(enumItem.Value).to.equal(i)
				expect(enumItem.EnumType).to.equal(test)
			end
		end)
	end)
end

]]

 

return function() -- Line: 1
    local script_Parent = require(script.Parent);
    describe("Constructor", function() -- Line: 4
        -- upvalues: script_Parent (copy)
        it("should create a new enumlist", function() -- Line: 5
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 6
                -- upvalues: script_Parent (ref)
                script_Parent.new("Test", { "ABC", "XYZ" });
            end).never.to.throw();
        end);
        it("should fail to create a new enumlist with no name", function() -- Line: 11
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 12
                -- upvalues: script_Parent (ref)
                script_Parent.new(nil, { "ABC", "XYZ" });
            end).to.throw();
        end);
        it("should fail to create a new enumlist with no enums", function() -- Line: 17
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 18
                -- upvalues: script_Parent (ref)
                script_Parent.new("Test");
            end).to.throw();
        end);
        it("should fail to create a new enumlist with non string enums", function() -- Line: 23
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 24
                -- upvalues: script_Parent (ref)
                script_Parent.new("Test", { true, false, 32, "ABC" });
            end).to.throw();
        end);
    end);
    describe("Access", function() -- Line: 30
        -- upvalues: script_Parent (copy)
        it("should be able to access enum items", function() -- Line: 31
            -- upvalues: script_Parent (ref)
            local Test = script_Parent.new("Test", { "ABC", "XYZ" });
            expect(function() -- Line: 33
                -- upvalues: Test (copy)
                local _ = Test.ABC;
            end).never.to.throw();
            expect(Test:BelongsTo(Test.ABC)).to.equal(true);
        end);
        it("should throw if trying to modify the enumlist", function() -- Line: 39
            -- upvalues: script_Parent (ref)
            local Test = script_Parent.new("Test", { "ABC", "XYZ" });
            expect(function() -- Line: 41
                -- upvalues: Test (copy)
                Test.Hello = 32;
            end).to.throw();
            expect(function() -- Line: 44
                -- upvalues: Test (copy)
                Test.ABC = 32;
            end).to.throw();
        end);
        it("should throw if trying to modify an enumitem", function() -- Line: 49
            -- upvalues: script_Parent (ref)
            local Test = script_Parent.new("Test", { "ABC", "XYZ" });
            expect(function() -- Line: 51
                -- upvalues: Test (copy)
                Test.ABC.XYZ = 32;
            end).to.throw();
            expect(function() -- Line: 55
                -- upvalues: Test (copy)
                Test.ABC.Name = "NewName";
            end).to.throw();
        end);
        it("should get the name", function() -- Line: 61
            -- upvalues: script_Parent (ref)
            local Name = script_Parent.new("Test", { "ABC", "XYZ" }):GetName();
            expect(Name).to.equal("Test");
        end);
    end);
    describe("Get Items", function() -- Line: 68
        -- upvalues: script_Parent (copy)
        it("should be able to get all enum items", function() -- Line: 69
            -- upvalues: script_Parent (ref)
            local Test = script_Parent.new("Test", { "ABC", "XYZ" });
            local EnumItems = Test:GetEnumItems();
            expect(EnumItems).to.be.a("table");
            expect(#EnumItems).to.equal(2);

            for i, v in ipairs(EnumItems) do
                expect(v).to.be.a("table");
                expect(v.Name).to.be.a("string");
                expect(v.Value).to.be.a("number");
                expect(v.Value).to.equal(i);
                expect(v.EnumType).to.equal(Test);
            end;
        end);
    end);
end;