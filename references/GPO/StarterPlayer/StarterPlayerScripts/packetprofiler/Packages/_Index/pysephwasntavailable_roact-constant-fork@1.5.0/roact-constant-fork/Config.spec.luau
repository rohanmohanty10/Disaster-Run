 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Config)
    it("should accept valid configuration", function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v2 = u1.new()
        local v3 = v2.get()
        expect(v3.elementTracing).to.equal(false)
        v2.set({
            ["elementTracing"] = true
        })
        expect(v3.elementTracing).to.equal(true)
    end)
    it("should reject invalid configuration keys", function() --[[ Line: 17 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u4 = u1.new()
        local v5, v6 = pcall(function() --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            u4.set({
                ["garblegoop"] = true
            })
        end)
        expect(v5).to.equal(false)
        expect(v6:find("garblegoop")).to.be.ok()
    end)
    it("should reject invalid configuration values", function() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u7 = u1.new()
        local v8, v9 = pcall(function() --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            u7.set({
                ["elementTracing"] = "Hello there!"
            })
        end)
        expect(v8).to.equal(false)
        expect(v9:find("elementTracing")).to.be.ok()
        expect(v9:find("Hello there!")).to.be.ok()
    end)
end