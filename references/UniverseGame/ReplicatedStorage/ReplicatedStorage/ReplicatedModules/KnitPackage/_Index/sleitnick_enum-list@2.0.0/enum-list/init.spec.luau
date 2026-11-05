  

 

return function() -- Line: 1
    local Parent = require(script.Parent);
    describe("Constructor", function() -- Line: 5
        -- upvalues: Parent (copy)
        it("should create a new enumlist", function() -- Line: 7
            -- upvalues: Parent (ref)
            expect(function() -- Line: 8
                -- upvalues: Parent (ref)
                Parent.new("Test", { "ABC", "XYZ" });
            end).never.to.throw();
        end);
        it("should fail to create a new enumlist with no name", function() -- Line: 13
            -- upvalues: Parent (ref)
            expect(function() -- Line: 14
                -- upvalues: Parent (ref)
                Parent.new(nil, { "ABC", "XYZ" });
            end).to.throw();
        end);
        it("should fail to create a new enumlist with no enums", function() -- Line: 19
            -- upvalues: Parent (ref)
            expect(function() -- Line: 20
                -- upvalues: Parent (ref)
                Parent.new("Test");
            end).to.throw();
        end);
        it("should fail to create a new enumlist with non string enums", function() -- Line: 25
            -- upvalues: Parent (ref)
            expect(function() -- Line: 26
                -- upvalues: Parent (ref)
                Parent.new("Test", { true, false, 32, "ABC" });
            end).to.throw();
        end);
    end);
    describe("Access", function() -- Line: 33
        -- upvalues: Parent (copy)
        it("should be able to access enum items", function() -- Line: 35
            -- upvalues: Parent (ref)
            local Test = Parent.new("Test", { "ABC", "XYZ" });
            expect(function() -- Line: 37
                -- upvalues: Test (copy)
                local _ = Test.ABC;
            end).never.to.throw();
            expect(Test:BelongsTo(Test.ABC)).to.equal(true);
        end);
        it("should throw if trying to modify the enumlist", function() -- Line: 43
            -- upvalues: Parent (ref)
            local Test = Parent.new("Test", { "ABC", "XYZ" });
            expect(function() -- Line: 45
                -- upvalues: Test (copy)
                Test.Hello = 32;
            end).to.throw();
            expect(function() -- Line: 48
                -- upvalues: Test (copy)
                Test.ABC = 32;
            end).to.throw();
        end);
        it("should throw if trying to modify an enumitem", function() -- Line: 53
            -- upvalues: Parent (ref)
            local Test = Parent.new("Test", { "ABC", "XYZ" });
            expect(function() -- Line: 55
                -- upvalues: Test (copy)
                Test.ABC.XYZ = 32;
            end).to.throw();
            expect(function() -- Line: 59
                -- upvalues: Test (copy)
                Test.ABC.Name = "NewName";
            end).to.throw();
        end);
        it("should get the name", function() -- Line: 65
            -- upvalues: Parent (ref)
            local v1 = Parent.new("Test", { "ABC", "XYZ" }):GetName();
            expect(v1).to.equal("Test");
        end);
    end);
    describe("Get Items", function() -- Line: 73
        -- upvalues: Parent (copy)
        it("should be able to get all enum items", function() -- Line: 75
            -- upvalues: Parent (ref)
            local Test = Parent.new("Test", { "ABC", "XYZ" });
            local v2 = Test:GetEnumItems();
            expect(v2).to.be.a("table");
            expect(#v2).to.equal(2);

            for i, v in ipairs(v2) do
                expect(v).to.be.a("table");
                expect(v.Name).to.be.a("string");
                expect(v.Value).to.be.a("number");
                expect(v.Value).to.equal(i);
                expect(v.EnumType).to.equal(Test);
            end;
        end);
    end);
end;