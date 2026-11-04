 

local u1 = workspace.CurrentCamera
return {
    ["start"] = function(_) --[[ Name: start, Line 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.CFrame = game.Players.LocalPlayer.Character:GetPivot() * CFrame.new(0, 8.5, 5)
    end
}