 

game:GetService("HttpService")
local u1 = game:GetService("CollectionService")
local u2 = require(script:WaitForChild("buildConstraints"))
local u3 = require(script:WaitForChild("buildCollisionFilters"))
local v4 = script.Dummy:GetDescendants()
local u5 = {}
local function u12(p6) --[[ Line: 24 ]]
    local v7 = {}
    for _, v8 in ipairs(p6:GetChildren()) do
        if v8:IsA("BasePart") and v8.CanQuery == true then
            for _, v9 in ipairs(v8:GetChildren()) do
                if v9:IsA("Attachment") then
                    local v10 = string.match(v9.Name, "^(.+)RigAttachment$")
                    local v11
                    if v10 then
                        v11 = v9.Parent:FindFirstChild(v10) or nil
                    else
                        v11 = nil
                    end
                    if v11 and (v11:IsA("Motor6D") and (v11.Part0 and v11.Part1)) then
                        v7[v9.Name] = {
                            ["Joint"] = v11,
                            ["Attachment0"] = v11.Part0[v9.Name],
                            ["Attachment1"] = v11.Part1[v9.Name]
                        }
                    end
                end
            end
        end
    end
    return v7
end
for v13 = 1, #v4 do
    if v4[v13]:IsA("Attachment") then
        if u5[v4[v13].Parent.Name] == nil then
            u5[v4[v13].Parent.Name] = {}
        end
        local v14 = u5[v4[v13].Parent.Name]
        local v15 = v4[v13]
        table.insert(v14, v15)
    end
end
return function(p16) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u12
        [3] = u2
        [4] = u3
        [5] = u1
    --]]
    local v17 = p16.Parent
    if not v17:FindFirstChild("RagdollConstraints") then
        p16.BreakJointsOnDeath = false
        local v18 = v17:FindFirstChild("HumanoidRootPart")
        if v18 then
            v18.CanCollide = false
        end
        for v19, v20 in pairs(u5) do
            local v21 = v17:FindFirstChild(v19)
            if v17:FindFirstChild(v19) then
                for v22 = 1, #v20 do
                    if v21 and v21:FindFirstChild(v20[v22].Name) == nil then
                        v20[v22]:Clone().Parent = v21
                    end
                end
            end
        end
        local v23 = u12(v17)
        local v24 = u2(v23)
        u3(v23, v17.PrimaryPart).Parent = v24
        v24.Parent = v17
        u1:AddTag(p16, "Ragdoll")
    end
end