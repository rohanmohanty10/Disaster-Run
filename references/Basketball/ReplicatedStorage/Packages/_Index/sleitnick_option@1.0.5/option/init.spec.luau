 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
return function()
	local Option = require(script.Parent)

	describe("Some", function()
		it("should create some option", function()
			local opt = Option.Some(true)
			expect(opt:IsSome()).to.equal(true)
		end)

		it("should fail to create some option with nil", function()
			expect(function()
				Option.Some(nil)
			end).to.throw()
		end)

		it("should not be none", function()
			local opt = Option.Some(10)
			expect(opt:IsNone()).to.equal(false)
		end)
	end)

	describe("None", function()
		it("should be able to reference none", function()
			expect(function()
				local _none = Option.None
			end).never.to.throw()
		end)

		it("should be able to check if none", function()
			local none = Option.None
			expect(none:IsNone()).to.equal(true)
		end)

		it("should be able to check if not some", function()
			local none = Option.None
			expect(none:IsSome()).to.equal(false)
		end)
	end)

	describe("Equality", function()
		it("should equal the same some from same options", function()
			local opt = Option.Some(32)
			expect(opt).to.equal(opt)
		end)

		it("should equal the same some from different options", function()
			local opt1 = Option.Some(32)
			local opt2 = Option.Some(32)
			expect(opt1).to.equal(opt2)
		end)
	end)

	describe("Assert", function()
		it("should assert that a some option is an option", function()
			expect(Option.Is(Option.Some(10))).to.equal(true)
		end)

		it("should assert that a none option is an option", function()
			expect(Option.Is(Option.None)).to.equal(true)
		end)

		it("should assert that a non-option is not an option", function()
			expect(Option.Is(10)).to.equal(false)
			expect(Option.Is(true)).to.equal(false)
			expect(Option.Is(false)).to.equal(false)
			expect(Option.Is("Test")).to.equal(false)
			expect(Option.Is({})).to.equal(false)
			expect(Option.Is(function() end)).to.equal(false)
			expect(Option.Is(coroutine.create(function() end))).to.equal(false)
			expect(Option.Is(Option)).to.equal(false)
		end)
	end)

	describe("Unwrap", function()
		it("should unwrap a some option", function()
			local opt = Option.Some(10)
			expect(function()
				opt:Unwrap()
			end).never.to.throw()
			expect(opt:Unwrap()).to.equal(10)
		end)

		it("should fail to unwrap a none option", function()
			local opt = Option.None
			expect(function()
				opt:Unwrap()
			end).to.throw()
		end)
	end)

	describe("Expect", function()
		it("should expect a some option", function()
			local opt = Option.Some(10)
			expect(function()
				opt:Expect("Expecting some value")
			end).never.to.throw()
			expect(opt:Unwrap()).to.equal(10)
		end)

		it("should fail when expecting on a none option", function()
			local opt = Option.None
			expect(function()
				opt:Expect("Expecting some value")
			end).to.throw()
		end)
	end)

	describe("ExpectNone", function()
		it("should fail to expect a none option", function()
			local opt = Option.Some(10)
			expect(function()
				opt:ExpectNone("Expecting some value")
			end).to.throw()
		end)

		it("should expect a none option", function()
			local opt = Option.None
			expect(function()
				opt:ExpectNone("Expecting some value")
			end).never.to.throw()
		end)
	end)

	describe("UnwrapOr", function()
		it("should unwrap a some option", function()
			local opt = Option.Some(10)
			expect(opt:UnwrapOr(20)).to.equal(10)
		end)

		it("should unwrap a none option", function()
			local opt = Option.None
			expect(opt:UnwrapOr(20)).to.equal(20)
		end)
	end)

	describe("UnwrapOrElse", function()
		it("should unwrap a some option", function()
			local opt = Option.Some(10)
			local result = opt:UnwrapOrElse(function()
				return 30
			end)
			expect(result).to.equal(10)
		end)

		it("should unwrap a none option", function()
			local opt = Option.None
			local result = opt:UnwrapOrElse(function()
				return 30
			end)
			expect(result).to.equal(30)
		end)
	end)

	describe("And", function()
		it("should return the second option with and when both are some", function()
			local opt1 = Option.Some(1)
			local opt2 = Option.Some(2)
			expect(opt1:And(opt2)).to.equal(opt2)
		end)

		it("should return none when first option is some and second option is none", function()
			local opt1 = Option.Some(1)
			local opt2 = Option.None
			expect(opt1:And(opt2):IsNone()).to.equal(true)
		end)

		it("should return none when first option is none and second option is some", function()
			local opt1 = Option.None
			local opt2 = Option.Some(2)
			expect(opt1:And(opt2):IsNone()).to.equal(true)
		end)

		it("should return none when both options are none", function()
			local opt1 = Option.None
			local opt2 = Option.None
			expect(opt1:And(opt2):IsNone()).to.equal(true)
		end)
	end)

	describe("AndThen", function()
		it("should pass the some value to the predicate", function()
			local opt = Option.Some(32)
			opt:AndThen(function(value)
				expect(value).to.equal(32)
				return Option.None
			end)
		end)

		it("should throw if an option is not returned from predicate", function()
			local opt = Option.Some(32)
			expect(function()
				opt:AndThen(function() end)
			end).to.throw()
		end)

		it("should return none if the option is none", function()
			local opt = Option.None
			expect(opt:AndThen(function()
				return Option.Some(10)
			end):IsNone()).to.equal(true)
		end)

		it("should return option of predicate if option is some", function()
			local opt = Option.Some(32)
			local result = opt:AndThen(function()
				return Option.Some(10)
			end)
			expect(result:IsSome()).to.equal(true)
			expect(result:Unwrap()).to.equal(10)
		end)
	end)

	describe("Or", function()
		it("should return the first option if it is some", function()
			local opt1 = Option.Some(10)
			local opt2 = Option.Some(20)
			expect(opt1:Or(opt2)).to.equal(opt1)
		end)

		it("should return the second option if the first one is none", function()
			local opt1 = Option.None
			local opt2 = Option.Some(20)
			expect(opt1:Or(opt2)).to.equal(opt2)
		end)
	end)

	describe("OrElse", function()
		it("should return the first option if it is some", function()
			local opt1 = Option.Some(10)
			local opt2 = Option.Some(20)
			expect(opt1:OrElse(function()
				return opt2
			end)).to.equal(opt1)
		end)

		it("should return the second option if the first one is none", function()
			local opt1 = Option.None
			local opt2 = Option.Some(20)
			expect(opt1:OrElse(function()
				return opt2
			end)).to.equal(opt2)
		end)

		it("should throw if the predicate does not return an option", function()
			local opt1 = Option.None
			expect(function()
				opt1:OrElse(function() end)
			end).to.throw()
		end)
	end)

	describe("XOr", function()
		it("should return first option if first option is some and second option is none", function()
			local opt1 = Option.Some(1)
			local opt2 = Option.None
			expect(opt1:XOr(opt2)).to.equal(opt1)
		end)

		it("should return second option if first option is none and second option is some", function()
			local opt1 = Option.None
			local opt2 = Option.Some(2)
			expect(opt1:XOr(opt2)).to.equal(opt2)
		end)

		it("should return none if first and second option are some", function()
			local opt1 = Option.Some(1)
			local opt2 = Option.Some(2)
			expect(opt1:XOr(opt2)).to.equal(Option.None)
		end)

		it("should return none if first and second option are none", function()
			local opt1 = Option.None
			local opt2 = Option.None
			expect(opt1:XOr(opt2)).to.equal(Option.None)
		end)
	end)

	describe("Filter", function()
		it("should return none if option is none", function()
			local opt = Option.None
			expect(opt:Filter(function() end)).to.equal(Option.None)
		end)

		it("should return none if option is some but fails predicate", function()
			local opt = Option.Some(10)
			expect(opt:Filter(function(_v)
				return false
			end)).to.equal(Option.None)
		end)

		it("should return self if option is some and passes predicate", function()
			local opt = Option.Some(10)
			expect(opt:Filter(function(_v)
				return true
			end)).to.equal(opt)
		end)
	end)

	describe("Contains", function()
		it("should return true if some option contains the given value", function()
			local opt = Option.Some(32)
			expect(opt:Contains(32)).to.equal(true)
		end)

		it("should return false if some option does not contain the given value", function()
			local opt = Option.Some(32)
			expect(opt:Contains(64)).to.equal(false)
		end)

		it("should return false if option is none", function()
			local opt = Option.None
			expect(opt:Contains(64)).to.equal(false)
		end)
	end)

	describe("ToString", function()
		it("should return string of none option", function()
			local opt = Option.None
			expect(tostring(opt)).to.equal("Option<None>")
		end)

		it("should return string of some option with type", function()
			local values = { 10, true, false, "test", {}, function() end, coroutine.create(function() end), workspace }
			for _, value in ipairs(values) do
				local expectedString = ("Option<%s>"):format(typeof(value))
				expect(tostring(Option.Some(value))).to.equal(expectedString)
			end
		end)
	end)
end

]]

 

return function() -- Line: 1
    local script_Parent = require(script.Parent);
    describe("Some", function() -- Line: 4
        -- upvalues: script_Parent (copy)
        it("should create some option", function() -- Line: 5
            -- upvalues: script_Parent (ref)
            local v1 = script_Parent.Some(true);
            expect(v1:IsSome()).to.equal(true);
        end);
        it("should fail to create some option with nil", function() -- Line: 10
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 11
                -- upvalues: script_Parent (ref)
                script_Parent.Some(nil);
            end).to.throw();
        end);
        it("should not be none", function() -- Line: 16
            -- upvalues: script_Parent (ref)
            local v2 = script_Parent.Some(10);
            expect(v2:IsNone()).to.equal(false);
        end);
    end);
    describe("None", function() -- Line: 22
        -- upvalues: script_Parent (copy)
        it("should be able to reference none", function() -- Line: 23
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 24
                -- upvalues: script_Parent (ref)
                local _ = script_Parent.None;
            end).never.to.throw();
        end);
        it("should be able to check if none", function() -- Line: 29
            -- upvalues: script_Parent (ref)
            expect(script_Parent.None:IsNone()).to.equal(true);
        end);
        it("should be able to check if not some", function() -- Line: 34
            -- upvalues: script_Parent (ref)
            expect(script_Parent.None:IsSome()).to.equal(false);
        end);
    end);
    describe("Equality", function() -- Line: 40
        -- upvalues: script_Parent (copy)
        it("should equal the same some from same options", function() -- Line: 41
            -- upvalues: script_Parent (ref)
            local v3 = script_Parent.Some(32);
            expect(v3).to.equal(v3);
        end);
        it("should equal the same some from different options", function() -- Line: 46
            -- upvalues: script_Parent (ref)
            local v4 = script_Parent.Some(32);
            local v5 = script_Parent.Some(32);
            expect(v4).to.equal(v5);
        end);
    end);
    describe("Assert", function() -- Line: 53
        -- upvalues: script_Parent (copy)
        it("should assert that a some option is an option", function() -- Line: 54
            -- upvalues: script_Parent (ref)
            expect(script_Parent.Is(script_Parent.Some(10))).to.equal(true);
        end);
        it("should assert that a none option is an option", function() -- Line: 58
            -- upvalues: script_Parent (ref)
            expect(script_Parent.Is(script_Parent.None)).to.equal(true);
        end);
        it("should assert that a non-option is not an option", function() -- Line: 62
            -- upvalues: script_Parent (ref)
            expect(script_Parent.Is(10)).to.equal(false);
            expect(script_Parent.Is(true)).to.equal(false);
            expect(script_Parent.Is(false)).to.equal(false);
            expect(script_Parent.Is("Test")).to.equal(false);
            expect(script_Parent.Is({})).to.equal(false);
            expect(script_Parent.Is(function() -- Line: 68
            end)).to.equal(false);
            expect(script_Parent.Is(coroutine.create(function() -- Line: 69
            end))).to.equal(false);
            expect(script_Parent.Is(script_Parent)).to.equal(false);
        end);
    end);
    describe("Unwrap", function() -- Line: 74
        -- upvalues: script_Parent (copy)
        it("should unwrap a some option", function() -- Line: 75
            -- upvalues: script_Parent (ref)
            local u6 = script_Parent.Some(10);
            expect(function() -- Line: 77
                -- upvalues: u6 (copy)
                u6:Unwrap();
            end).never.to.throw();
            expect(u6:Unwrap()).to.equal(10);
        end);
        it("should fail to unwrap a none option", function() -- Line: 83
            -- upvalues: script_Parent (ref)
            local None = script_Parent.None;
            expect(function() -- Line: 85
                -- upvalues: None (copy)
                None:Unwrap();
            end).to.throw();
        end);
    end);
    describe("Expect", function() -- Line: 91
        -- upvalues: script_Parent (copy)
        it("should expect a some option", function() -- Line: 92
            -- upvalues: script_Parent (ref)
            local u7 = script_Parent.Some(10);
            expect(function() -- Line: 94
                -- upvalues: u7 (copy)
                u7:Expect("Expecting some value");
            end).never.to.throw();
            expect(u7:Unwrap()).to.equal(10);
        end);
        it("should fail when expecting on a none option", function() -- Line: 100
            -- upvalues: script_Parent (ref)
            local None = script_Parent.None;
            expect(function() -- Line: 102
                -- upvalues: None (copy)
                None:Expect("Expecting some value");
            end).to.throw();
        end);
    end);
    describe("ExpectNone", function() -- Line: 108
        -- upvalues: script_Parent (copy)
        it("should fail to expect a none option", function() -- Line: 109
            -- upvalues: script_Parent (ref)
            local u8 = script_Parent.Some(10);
            expect(function() -- Line: 111
                -- upvalues: u8 (copy)
                u8:ExpectNone("Expecting some value");
            end).to.throw();
        end);
        it("should expect a none option", function() -- Line: 116
            -- upvalues: script_Parent (ref)
            local None = script_Parent.None;
            expect(function() -- Line: 118
                -- upvalues: None (copy)
                None:ExpectNone("Expecting some value");
            end).never.to.throw();
        end);
    end);
    describe("UnwrapOr", function() -- Line: 124
        -- upvalues: script_Parent (copy)
        it("should unwrap a some option", function() -- Line: 125
            -- upvalues: script_Parent (ref)
            local v9 = script_Parent.Some(10);
            expect(v9:UnwrapOr(20)).to.equal(10);
        end);
        it("should unwrap a none option", function() -- Line: 130
            -- upvalues: script_Parent (ref)
            expect(script_Parent.None:UnwrapOr(20)).to.equal(20);
        end);
    end);
    describe("UnwrapOrElse", function() -- Line: 136
        -- upvalues: script_Parent (copy)
        it("should unwrap a some option", function() -- Line: 137
            -- upvalues: script_Parent (ref)
            local v10 = script_Parent.Some(10):UnwrapOrElse(function() -- Line: 139
                return 30;
            end);
            expect(v10).to.equal(10);
        end);
        it("should unwrap a none option", function() -- Line: 145
            -- upvalues: script_Parent (ref)
            local v11 = script_Parent.None:UnwrapOrElse(function() -- Line: 147
                return 30;
            end);
            expect(v11).to.equal(30);
        end);
    end);
    describe("And", function() -- Line: 154
        -- upvalues: script_Parent (copy)
        it("should return the second option with and when both are some", function() -- Line: 155
            -- upvalues: script_Parent (ref)
            local v12 = script_Parent.Some(1);
            local v13 = script_Parent.Some(2);
            expect(v12:And(v13)).to.equal(v13);
        end);
        it("should return none when first option is some and second option is none", function() -- Line: 161
            -- upvalues: script_Parent (ref)
            local v14 = script_Parent.Some(1);
            expect(v14:And(script_Parent.None):IsNone()).to.equal(true);
        end);
        it("should return none when first option is none and second option is some", function() -- Line: 167
            -- upvalues: script_Parent (ref)
            local None = script_Parent.None;
            local v15 = script_Parent.Some(2);
            expect(None:And(v15):IsNone()).to.equal(true);
        end);
        it("should return none when both options are none", function() -- Line: 173
            -- upvalues: script_Parent (ref)
            expect(script_Parent.None:And(script_Parent.None):IsNone()).to.equal(true);
        end);
    end);
    describe("AndThen", function() -- Line: 180
        -- upvalues: script_Parent (copy)
        it("should pass the some value to the predicate", function() -- Line: 181
            -- upvalues: script_Parent (ref)
            script_Parent.Some(32):AndThen(function(p16) -- Line: 183
                -- upvalues: script_Parent (ref)
                expect(p16).to.equal(32);

                return script_Parent.None;
            end);
        end);
        it("should throw if an option is not returned from predicate", function() -- Line: 189
            -- upvalues: script_Parent (ref)
            local u17 = script_Parent.Some(32);
            expect(function() -- Line: 191
                -- upvalues: u17 (copy)
                u17:AndThen(function() -- Line: 192
                end);
            end).to.throw();
        end);
        it("should return none if the option is none", function() -- Line: 196
            -- upvalues: script_Parent (ref)
            expect(script_Parent.None:AndThen(function() -- Line: 198
                -- upvalues: script_Parent (ref)
                return script_Parent.Some(10);
            end):IsNone()).to.equal(true);
        end);
        it("should return option of predicate if option is some", function() -- Line: 203
            -- upvalues: script_Parent (ref)
            local v18 = script_Parent.Some(32):AndThen(function() -- Line: 205
                -- upvalues: script_Parent (ref)
                return script_Parent.Some(10);
            end);
            expect(v18:IsSome()).to.equal(true);
            expect(v18:Unwrap()).to.equal(10);
        end);
    end);
    describe("Or", function() -- Line: 213
        -- upvalues: script_Parent (copy)
        it("should return the first option if it is some", function() -- Line: 214
            -- upvalues: script_Parent (ref)
            local v19 = script_Parent.Some(10);
            local v20 = script_Parent.Some(20);
            expect(v19:Or(v20)).to.equal(v19);
        end);
        it("should return the second option if the first one is none", function() -- Line: 220
            -- upvalues: script_Parent (ref)
            local None = script_Parent.None;
            local v21 = script_Parent.Some(20);
            expect(None:Or(v21)).to.equal(v21);
        end);
    end);
    describe("OrElse", function() -- Line: 227
        -- upvalues: script_Parent (copy)
        it("should return the first option if it is some", function() -- Line: 228
            -- upvalues: script_Parent (ref)
            local v22 = script_Parent.Some(10);
            local u23 = script_Parent.Some(20);
            expect(v22:OrElse(function() -- Line: 231
                -- upvalues: u23 (copy)
                return u23;
            end)).to.equal(v22);
        end);
        it("should return the second option if the first one is none", function() -- Line: 236
            -- upvalues: script_Parent (ref)
            local None = script_Parent.None;
            local u24 = script_Parent.Some(20);
            expect(None:OrElse(function() -- Line: 239
                -- upvalues: u24 (copy)
                return u24;
            end)).to.equal(u24);
        end);
        it("should throw if the predicate does not return an option", function() -- Line: 244
            -- upvalues: script_Parent (ref)
            local None = script_Parent.None;
            expect(function() -- Line: 246
                -- upvalues: None (copy)
                None:OrElse(function() -- Line: 247
                end);
            end).to.throw();
        end);
    end);
    describe("XOr", function() -- Line: 252
        -- upvalues: script_Parent (copy)
        it("should return first option if first option is some and second option is none", function() -- Line: 253
            -- upvalues: script_Parent (ref)
            local v25 = script_Parent.Some(1);
            expect(v25:XOr(script_Parent.None)).to.equal(v25);
        end);
        it("should return second option if first option is none and second option is some", function() -- Line: 259
            -- upvalues: script_Parent (ref)
            local None = script_Parent.None;
            local v26 = script_Parent.Some(2);
            expect(None:XOr(v26)).to.equal(v26);
        end);
        it("should return none if first and second option are some", function() -- Line: 265
            -- upvalues: script_Parent (ref)
            local v27 = script_Parent.Some(1);
            local v28 = script_Parent.Some(2);
            expect(v27:XOr(v28)).to.equal(script_Parent.None);
        end);
        it("should return none if first and second option are none", function() -- Line: 271
            -- upvalues: script_Parent (ref)
            expect(script_Parent.None:XOr(script_Parent.None)).to.equal(script_Parent.None);
        end);
    end);
    describe("Filter", function() -- Line: 278
        -- upvalues: script_Parent (copy)
        it("should return none if option is none", function() -- Line: 279
            -- upvalues: script_Parent (ref)
            expect(script_Parent.None:Filter(function() -- Line: 281
            end)).to.equal(script_Parent.None);
        end);
        it("should return none if option is some but fails predicate", function() -- Line: 284
            -- upvalues: script_Parent (ref)
            local v29 = script_Parent.Some(10);
            expect(v29:Filter(function(p30) -- Line: 286
                return false;
            end)).to.equal(script_Parent.None);
        end);
        it("should return self if option is some and passes predicate", function() -- Line: 291
            -- upvalues: script_Parent (ref)
            local v31 = script_Parent.Some(10);
            expect(v31:Filter(function(p32) -- Line: 293
                return true;
            end)).to.equal(v31);
        end);
    end);
    describe("Contains", function() -- Line: 299
        -- upvalues: script_Parent (copy)
        it("should return true if some option contains the given value", function() -- Line: 300
            -- upvalues: script_Parent (ref)
            local v33 = script_Parent.Some(32);
            expect(v33:Contains(32)).to.equal(true);
        end);
        it("should return false if some option does not contain the given value", function() -- Line: 305
            -- upvalues: script_Parent (ref)
            local v34 = script_Parent.Some(32);
            expect(v34:Contains(64)).to.equal(false);
        end);
        it("should return false if option is none", function() -- Line: 310
            -- upvalues: script_Parent (ref)
            expect(script_Parent.None:Contains(64)).to.equal(false);
        end);
    end);
    describe("ToString", function() -- Line: 316
        -- upvalues: script_Parent (copy)
        it("should return string of none option", function() -- Line: 317
            -- upvalues: script_Parent (ref)
            expect((tostring(script_Parent.None))).to.equal("Option<None>");
        end);
        it("should return string of some option with type", function() -- Line: 322
            -- upvalues: script_Parent (ref)
            local v35 = {
                10,
                true,
                false,
                "test",
                {},

                function() -- Line: 323
                end,

                coroutine.create(function() -- Line: 323
                end),
                workspace
            };

            for _, v in ipairs(v35) do
                local v36 = ("Option<%s>"):format((typeof(v)));
                expect((tostring(script_Parent.Some(v)))).to.equal(v36);
            end;
        end);
    end);
end;