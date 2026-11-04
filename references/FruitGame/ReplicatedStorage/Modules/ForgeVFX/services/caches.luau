 

local u1 = require("../obj/ObjectCache")
local u2 = require("../mod/utility")
return {
    ["init"] = function(p3) --[[ Name: init, Line 7 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v4 = Instance.new("Part")
        v4.Transparency = 1
        v4.Anchored = true
        v4.CanCollide = false
        v4.CanQuery = false
        v4.Locked = true
        local u5 = Instance.new("Folder")
        u5.Name = "DO_NOT_REMOVE_ForgeSharedPartCache"
        u5.Archivable = false
        u5.Parent = workspace.Terrain
        u2.protectParent(p3, u5)
        local u8 = u1.new(v4, u5, {
            ["size"] = 150,
            ["on_free"] = function(p6) --[[ Name: on_free, Line 27 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                local v7 = p6.value
                v7.Transparency = 1
                v7.Anchored = true
                v7.CanQuery = false
                v7.CanCollide = false
                v7.CollisionGroup = "ForgeMouseIgnore"
                v7.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                v7.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                v7.Parent = u5
                v7:ClearAllChildren()
            end
        })
        local v9 = {
            ["shared_part"] = u8
        }
        local function v10() --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8:destroy()
        end
        table.insert(p3, v10)
        return v9
    end
}