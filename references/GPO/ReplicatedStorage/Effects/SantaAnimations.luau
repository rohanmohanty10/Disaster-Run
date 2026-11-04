 

local v1 = {}
local u2 = nil
function v1.start(_, _, p3) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = workspace.NPCs:WaitForChild("Santa", 10)
    if v4 then
        local v5 = v4:WaitForChild("Humanoid", 5)
        if v5 then
            if p3 == true then
                if u2 then
                    u2:Stop()
                    u2:Destroy()
                end
                u2 = v5:LoadAnimation(script.happy)
                u2:Play()
            elseif u2 then
                u2:Stop()
                u2:Destroy()
                u2 = nil
            end
        else
            return
        end
    else
        return
    end
end
return v1