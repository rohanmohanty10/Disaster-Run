  

 

return function() -- Line: 1
    local Parent = require(script.Parent);
    describe("Some", function() -- Line: 5
        -- upvalues: Parent (copy)
        it("should create some option", function() -- Line: 7
            -- upvalues: Parent (ref)
            local v1 = Parent.Some(true);
            expect(v1:IsSome()).to.equal(true);
        end);
        it("should fail to create some option with nil", function() -- Line: 12
            -- upvalues: Parent (ref)
            expect(function() -- Line: 13
                -- upvalues: Parent (ref)
                Parent.Some(nil);
            end).to.throw();
        end);
        it("should not be none", function() -- Line: 18
            -- upvalues: Parent (ref)
            local v2 = Parent.Some(10);
            expect(v2:IsNone()).to.equal(false);
        end);
    end);
    describe("None", function() -- Line: 25
        -- upvalues: Parent (copy)
        it("should be able to reference none", function() -- Line: 27
            -- upvalues: Parent (ref)
            expect(function() -- Line: 28
                -- upvalues: Parent (ref)
                local _ = Parent.None;
            end).never.to.throw();
        end);
        it("should be able to check if none", function() -- Line: 33
            -- upvalues: Parent (ref)
            expect(Parent.None:IsNone()).to.equal(true);
        end);
        it("should be able to check if not some", function() -- Line: 38
            -- upvalues: Parent (ref)
            expect(Parent.None:IsSome()).to.equal(false);
        end);
    end);
    describe("Equality", function() -- Line: 45
        -- upvalues: Parent (copy)
        it("should equal the same some from same options", function() -- Line: 47
            -- upvalues: Parent (ref)
            local v3 = Parent.Some(32);
            expect(v3).to.equal(v3);
        end);
        it("should equal the same some from different options", function() -- Line: 52
            -- upvalues: Parent (ref)
            local v4 = Parent.Some(32);
            local v5 = Parent.Some(32);
            expect(v4).to.equal(v5);
        end);
    end);
    describe("Assert", function() -- Line: 60
        -- upvalues: Parent (copy)
        it("should assert that a some option is an option", function() -- Line: 62
            -- upvalues: Parent (ref)
            expect(Parent.Is(Parent.Some(10))).to.equal(true);
        end);
        it("should assert that a none option is an option", function() -- Line: 66
            -- upvalues: Parent (ref)
            expect(Parent.Is(Parent.None)).to.equal(true);
        end);
        it("should assert that a non-option is not an option", function() -- Line: 70
            -- upvalues: Parent (ref)
            expect(Parent.Is(10)).to.equal(false);
            expect(Parent.Is(true)).to.equal(false);
            expect(Parent.Is(false)).to.equal(false);
            expect(Parent.Is("Test")).to.equal(false);
            expect(Parent.Is({})).to.equal(false);
            expect(Parent.Is(function() -- Line: 76
            end)).to.equal(false);
            expect(Parent.Is(coroutine.create(function() -- Line: 77
            end))).to.equal(false);
            expect(Parent.Is(Parent)).to.equal(false);
        end);
    end);
    describe("Unwrap", function() -- Line: 83
        -- upvalues: Parent (copy)
        it("should unwrap a some option", function() -- Line: 85
            -- upvalues: Parent (ref)
            local u6 = Parent.Some(10);
            expect(function() -- Line: 87
                -- upvalues: u6 (copy)
                u6:Unwrap();
            end).never.to.throw();
            expect(u6:Unwrap()).to.equal(10);
        end);
        it("should fail to unwrap a none option", function() -- Line: 93
            -- upvalues: Parent (ref)
            local None = Parent.None;
            expect(function() -- Line: 95
                -- upvalues: None (copy)
                None:Unwrap();
            end).to.throw();
        end);
    end);
    describe("Expect", function() -- Line: 102
        -- upvalues: Parent (copy)
        it("should expect a some option", function() -- Line: 104
            -- upvalues: Parent (ref)
            local u7 = Parent.Some(10);
            expect(function() -- Line: 106
                -- upvalues: u7 (copy)
                u7:Expect("Expecting some value");
            end).never.to.throw();
            expect(u7:Unwrap()).to.equal(10);
        end);
        it("should fail when expecting on a none option", function() -- Line: 112
            -- upvalues: Parent (ref)
            local None = Parent.None;
            expect(function() -- Line: 114
                -- upvalues: None (copy)
                None:Expect("Expecting some value");
            end).to.throw();
        end);
    end);
    describe("ExpectNone", function() -- Line: 121
        -- upvalues: Parent (copy)
        it("should fail to expect a none option", function() -- Line: 123
            -- upvalues: Parent (ref)
            local u8 = Parent.Some(10);
            expect(function() -- Line: 125
                -- upvalues: u8 (copy)
                u8:ExpectNone("Expecting some value");
            end).to.throw();
        end);
        it("should expect a none option", function() -- Line: 130
            -- upvalues: Parent (ref)
            local None = Parent.None;
            expect(function() -- Line: 132
                -- upvalues: None (copy)
                None:ExpectNone("Expecting some value");
            end).never.to.throw();
        end);
    end);
    describe("UnwrapOr", function() -- Line: 139
        -- upvalues: Parent (copy)
        it("should unwrap a some option", function() -- Line: 141
            -- upvalues: Parent (ref)
            local v9 = Parent.Some(10);
            expect(v9:UnwrapOr(20)).to.equal(10);
        end);
        it("should unwrap a none option", function() -- Line: 146
            -- upvalues: Parent (ref)
            expect(Parent.None:UnwrapOr(20)).to.equal(20);
        end);
    end);
    describe("UnwrapOrElse", function() -- Line: 153
        -- upvalues: Parent (copy)
        it("should unwrap a some option", function() -- Line: 155
            -- upvalues: Parent (ref)
            local v10 = Parent.Some(10):UnwrapOrElse(function() -- Line: 157
                return 30;
            end);
            expect(v10).to.equal(10);
        end);
        it("should unwrap a none option", function() -- Line: 161
            -- upvalues: Parent (ref)
            local v11 = Parent.None:UnwrapOrElse(function() -- Line: 163
                return 30;
            end);
            expect(v11).to.equal(30);
        end);
    end);
    describe("And", function() -- Line: 169
        -- upvalues: Parent (copy)
        it("should return the second option with and when both are some", function() -- Line: 171
            -- upvalues: Parent (ref)
            local v12 = Parent.Some(1);
            local v13 = Parent.Some(2);
            expect(v12:And(v13)).to.equal(v13);
        end);
        it("should return none when first option is some and second option is none", function() -- Line: 177
            -- upvalues: Parent (ref)
            local v14 = Parent.Some(1);
            expect(v14:And(Parent.None):IsNone()).to.equal(true);
        end);
        it("should return none when first option is none and second option is some", function() -- Line: 183
            -- upvalues: Parent (ref)
            local None = Parent.None;
            local v15 = Parent.Some(2);
            expect(None:And(v15):IsNone()).to.equal(true);
        end);
        it("should return none when both options are none", function() -- Line: 189
            -- upvalues: Parent (ref)
            expect(Parent.None:And(Parent.None):IsNone()).to.equal(true);
        end);
    end);
    describe("AndThen", function() -- Line: 197
        -- upvalues: Parent (copy)
        it("should pass the some value to the predicate", function() -- Line: 199
            -- upvalues: Parent (ref)
            Parent.Some(32):AndThen(function(p16) -- Line: 201
                -- upvalues: Parent (ref)
                expect(p16).to.equal(32);

                return Parent.None;
            end);
        end);
        it("should throw if an option is not returned from predicate", function() -- Line: 207
            -- upvalues: Parent (ref)
            local u17 = Parent.Some(32);
            expect(function() -- Line: 209
                -- upvalues: u17 (copy)
                u17:AndThen(function() -- Line: 210
                end);
            end).to.throw();
        end);
        it("should return none if the option is none", function() -- Line: 215
            -- upvalues: Parent (ref)
            expect(Parent.None:AndThen(function() -- Line: 217
                -- upvalues: Parent (ref)
                return Parent.Some(10);
            end):IsNone()).to.equal(true);
        end);
        it("should return option of predicate if option is some", function() -- Line: 222
            -- upvalues: Parent (ref)
            local v18 = Parent.Some(32):AndThen(function() -- Line: 224
                -- upvalues: Parent (ref)
                return Parent.Some(10);
            end);
            expect(v18:IsSome()).to.equal(true);
            expect(v18:Unwrap()).to.equal(10);
        end);
    end);
    describe("Or", function() -- Line: 233
        -- upvalues: Parent (copy)
        it("should return the first option if it is some", function() -- Line: 235
            -- upvalues: Parent (ref)
            local v19 = Parent.Some(10);
            local v20 = Parent.Some(20);
            expect(v19:Or(v20)).to.equal(v19);
        end);
        it("should return the second option if the first one is none", function() -- Line: 241
            -- upvalues: Parent (ref)
            local None = Parent.None;
            local v21 = Parent.Some(20);
            expect(None:Or(v21)).to.equal(v21);
        end);
    end);
    describe("OrElse", function() -- Line: 249
        -- upvalues: Parent (copy)
        it("should return the first option if it is some", function() -- Line: 251
            -- upvalues: Parent (ref)
            local v22 = Parent.Some(10);
            local u23 = Parent.Some(20);
            expect(v22:OrElse(function() -- Line: 254
                -- upvalues: u23 (copy)
                return u23;
            end)).to.equal(v22);
        end);
        it("should return the second option if the first one is none", function() -- Line: 257
            -- upvalues: Parent (ref)
            local None = Parent.None;
            local u24 = Parent.Some(20);
            expect(None:OrElse(function() -- Line: 260
                -- upvalues: u24 (copy)
                return u24;
            end)).to.equal(u24);
        end);
        it("should throw if the predicate does not return an option", function() -- Line: 263
            -- upvalues: Parent (ref)
            local None = Parent.None;
            expect(function() -- Line: 265
                -- upvalues: None (copy)
                None:OrElse(function() -- Line: 265
                end);
            end).to.throw();
        end);
    end);
    describe("XOr", function() -- Line: 270
        -- upvalues: Parent (copy)
        it("should return first option if first option is some and second option is none", function() -- Line: 272
            -- upvalues: Parent (ref)
            local v25 = Parent.Some(1);
            expect(v25:XOr(Parent.None)).to.equal(v25);
        end);
        it("should return second option if first option is none and second option is some", function() -- Line: 278
            -- upvalues: Parent (ref)
            local None = Parent.None;
            local v26 = Parent.Some(2);
            expect(None:XOr(v26)).to.equal(v26);
        end);
        it("should return none if first and second option are some", function() -- Line: 284
            -- upvalues: Parent (ref)
            local v27 = Parent.Some(1);
            local v28 = Parent.Some(2);
            expect(v27:XOr(v28)).to.equal(Parent.None);
        end);
        it("should return none if first and second option are none", function() -- Line: 290
            -- upvalues: Parent (ref)
            expect(Parent.None:XOr(Parent.None)).to.equal(Parent.None);
        end);
    end);
    describe("Filter", function() -- Line: 298
        -- upvalues: Parent (copy)
        it("should return none if option is none", function() -- Line: 300
            -- upvalues: Parent (ref)
            expect(Parent.None:Filter(function() -- Line: 302
            end)).to.equal(Parent.None);
        end);
        it("should return none if option is some but fails predicate", function() -- Line: 305
            -- upvalues: Parent (ref)
            local v29 = Parent.Some(10);
            expect(v29:Filter(function(p30) -- Line: 307
                return false;
            end)).to.equal(Parent.None);
        end);
        it("should return self if option is some and passes predicate", function() -- Line: 310
            -- upvalues: Parent (ref)
            local v31 = Parent.Some(10);
            expect(v31:Filter(function(p32) -- Line: 312
                return true;
            end)).to.equal(v31);
        end);
    end);
    describe("Contains", function() -- Line: 317
        -- upvalues: Parent (copy)
        it("should return true if some option contains the given value", function() -- Line: 319
            -- upvalues: Parent (ref)
            local v33 = Parent.Some(32);
            expect(v33:Contains(32)).to.equal(true);
        end);
        it("should return false if some option does not contain the given value", function() -- Line: 324
            -- upvalues: Parent (ref)
            local v34 = Parent.Some(32);
            expect(v34:Contains(64)).to.equal(false);
        end);
        it("should return false if option is none", function() -- Line: 329
            -- upvalues: Parent (ref)
            expect(Parent.None:Contains(64)).to.equal(false);
        end);
    end);
    describe("ToString", function() -- Line: 336
        -- upvalues: Parent (copy)
        it("should return string of none option", function() -- Line: 338
            -- upvalues: Parent (ref)
            expect((tostring(Parent.None))).to.equal("Option<None>");
        end);
        it("should return string of some option with type", function() -- Line: 343
            -- upvalues: Parent (ref)
            local v35 = {
                10,
                true,
                false,
                "test",
                {},

                function() -- Line: 344
                end,

                coroutine.create(function() -- Line: 344
                end),
                workspace
            };

            for _, v in ipairs(v35) do
                local v36 = ("Option<%s>"):format((typeof(v)));
                expect((tostring(Parent.Some(v)))).to.equal(v36);
            end;
        end);
    end);
end;