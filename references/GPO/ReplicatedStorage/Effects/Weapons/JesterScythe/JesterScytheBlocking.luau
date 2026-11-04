 

local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
return {
    ["start"] = function(_, p2, p3) --[[ Name: start, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
            local v4 = script.Folder.RightGripAttachment:Clone()
            u1.apply(v4, p2)
            v4.Parent = p2.RightHand
            repeat
                game["Run Service"].Heartbeat:Wait()
            until p3:IsDescendantOf(workspace) == false
            local v5 = v4.WorldCFrame
            v4.Scythe_rotFX.LockedToPart = false
            v4.WindFX.LockedToPart = false
            v4.Parent = workspace.Terrain
            v4.WorldCFrame = v5
            v4.Scythe_rotFX.Enabled = false
            v4.WindFX.Enabled = false
            _G.destroy(v4, 1)
        end
    end
}