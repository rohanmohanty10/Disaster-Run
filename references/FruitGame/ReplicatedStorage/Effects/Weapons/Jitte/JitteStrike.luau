 

local v1 = {}
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
function v1.start(_, p3, p4, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    while true do
        if p4 then
            p4.Velocity = p3.PrimaryPart.CFrame.LookVector * 50
        end
        local v6 = workspace:Raycast(p3.PrimaryPart.Position, p3.PrimaryPart.CFrame.LookVector * 4, u2)
        if v6 and v6.Instance then
            if p5 then
                p5:FireServer()
            end
            break
        end
        task.wait()
        if p3:GetAttribute("JitteStrikeHold") == nil then
            break
        end
    end
    p4:Destroy()
end
return v1