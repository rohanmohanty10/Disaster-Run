 

local v1 = {}
local function u5(p2) --[[ Line: 3 ]]
    local v3 = p2:GetChildren()
    for v4 = 1, #v3 do
        if v3[v4]:IsA("Weld") == false and (v3[v4]:IsA("ParticleEmitter") == false and v3[v4]:FindFirstChildWhichIsA("ParticleEmitter") == nil) then
            v3[v4]:Destroy()
        end
    end
end
local function u10(p6) --[[ Line: 12 ]]
    local v7 = p6:GetDescendants()
    for v8 = 1, #v7 do
        local v9 = v7[v8]
        if (v9:IsA("Attachment") or (v9:IsA("Motor6D") or v9:IsA("Vector3Value"))) and (v9:IsA("Bone") == false and v9:FindFirstChildWhichIsA("ParticleEmitter") == nil) then
            v9:Destroy()
        end
    end
end
function v1.PutOn(_, p11, p12) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u5
    --]]
    u10(p12)
    local v13 = p11:GetChildren()
    for v14 = 1, #v13 do
        if p12:FindFirstChild(v13[v14].Name) and v13[v14]:GetAttribute("preClothInvis") ~= nil then
            p11[v13[v14].Name].Transparency = 0
            p11[v13[v14].Name]:SetAttribute("preClothInvis", nil)
        end
    end
    local v15 = p12:GetChildren()
    for v16 = 1, #v15 do
        if p11:FindFirstChild(v15[v16].Name) then
            local v17 = Instance.new("Weld")
            v17.Part0 = p11[v15[v16].Name]
            v17.Part1 = v15[v16]
            v17.Parent = v15[v16]
            v17.Name = v15[v16].Name .. " Weld"
            u5(v15[v16])
            v15[v16].Transparency = 1
            if v15[v16]:GetAttribute("invisible") == nil then
                if p11[v15[v16].Name]:GetAttribute("preClothInvis") ~= nil then
                    p11[v15[v16].Name].Transparency = 0
                    p11[v15[v16].Name]:SetAttribute("preClothInvis", nil)
                end
            else
                p11[v15[v16].Name].Transparency = 1
                p11[v15[v16].Name]:SetAttribute("preClothInvis", true)
            end
        end
    end
end
return v1