 

local v1 = require(game.ReplicatedStorage.Modules:WaitForChild("Trove", 3))
if v1 then
    local u2 = script.Parent.Parent
    local v3 = v1.new()
    local function v4() --[[ Line: 10 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if u2.Transparency >= 0.99 then
            script.Parent.Transparency = 1
        else
            script.Parent.Transparency = 0
        end
    end
    if u2.Transparency >= 0.99 then
        script.Parent.Transparency = 1
    else
        script.Parent.Transparency = 0
    end
    v3:Connect(u2:GetPropertyChangedSignal("Transparency"), v4)
else
    script:Destroy()
end