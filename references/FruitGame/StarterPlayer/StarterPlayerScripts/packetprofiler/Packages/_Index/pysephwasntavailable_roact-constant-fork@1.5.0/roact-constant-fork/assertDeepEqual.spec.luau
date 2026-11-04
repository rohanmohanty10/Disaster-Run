 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.assertDeepEqual)
    it("should fail with a message when args are not equal", function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v2, v3 = pcall(u1, 1, 2)
        expect(v2).to.equal(false)
        expect(v3:find("first ~= second")).to.be.ok()
        local v4, v5 = pcall(u1, {
            ["foo"] = 1
        }, {
            ["foo"] = 2
        })
        expect(v4).to.equal(false)
        expect(v5:find("first%[foo%] ~= second%[foo%]")).to.be.ok()
    end)
    it("should compare non-table values using standard \'==\' equality", function() --[[ Line: 20 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1(1, 1)
        u1("hello", "hello")
        u1(nil, nil)
        local function v6() --[[ Line: 25 ]] end
        u1(v6, v6)
        u1({
            ["foo"] = v6
        }, {
            ["foo"] = v6
        })
    end)
    it("should fail when types differ", function() --[[ Line: 40 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v7, v8 = pcall(u1, 1, "1")
        expect(v7).to.equal(false)
        expect(v8:find("first is of type number, but second is of type string")).to.be.ok()
    end)
    it("should compare (and report about) nested tables", function() --[[ Line: 47 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v9 = {
            ["foo"] = "bar",
            ["nested"] = {
                ["foo"] = 1,
                ["bar"] = 2
            }
        }
        local v10 = {
            ["foo"] = "bar",
            ["nested"] = {
                ["foo"] = 1,
                ["bar"] = 2
            }
        }
        u1(v9, v10)
        local v11 = {
            ["foo"] = "bar",
            ["nested"] = {
                ["foo"] = 1,
                ["bar"] = 3
            }
        }
        local v12, v13 = pcall(u1, v9, v11)
        expect(v12).to.equal(false)
        expect(v13:find("first%[nested%]%[bar%] ~= second%[nested%]%[bar%]")).to.be.ok()
    end)
    it("should be commutative", function() --[[ Line: 79 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u14 = {
            ["foo"] = "bar",
            ["hello"] = "world"
        }
        local v15 = {
            ["foo"] = "bar",
            ["hello"] = "world"
        }
        u1(u14, v15)
        u1(v15, u14)
        local u16 = {
            ["foo"] = "bar"
        }
        expect(function() --[[ Line: 96 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u14
                [3] = u16
            --]]
            u1(u14, u16)
        end).to.throw()
        expect(function() --[[ Line: 99 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u16
                [3] = u14
            --]]
            u1(u16, u14)
        end).to.throw()
    end)
end