 

local v1 = game:GetService("AssetService")
local v2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v4 = script.Parent
local v5 = v4.Parent
if v5:IsDescendantOf(workspace) == false then
    return
end
if v5:GetAttribute("swordLoaded") == nil then
    local v6 = tick()
    repeat
        task.wait()
    until v5:GetAttribute("swordLoaded") == true or tick() - v6 >= 3
    if tick() - v6 >= 3 then
        return
    end
end
if not script.Parent then
    return
end
if not _G._scytheEditMeshTemplate then
    _G._scytheEditMeshTemplate = v1:CreateEditableMeshAsync(script.Parent.MeshContent)
end
if not _G._scytheEditMeshTemplate then
    return
end
local v7 = v1:CreateEditableMeshAsync(Content.fromObject(_G._scytheEditMeshTemplate))
if not v7 then
    return
end
v7:GetVertices()
local v8 = v7:GetUVs()
v4:ApplyMesh(v1:CreateMeshPartAsync(Content.fromObject(v7)))
local v9 = #v8
local v10 = table.create(v9)
local v11 = table.create(v9)
local v12 = table.create(v9)
local v13 = table.create(v9)
local v14 = table.create(v9)
local v15 = table.create(v9)
local v16 = table.create(v9)
local v17 = math.sqrt
local v18 = Vector2.new
local v19 = v7.SetUV
local v20 = table.create(512)
for v21 = 0, 511 do
    local v22 = v21 / 512 * 6.283185307179586
    v20[v21] = math.sin(v22)
end
for v23 = 1, v9 do
    local v24 = v7:GetUV(v8[v23])
    v10[v23] = v24.X
    v11[v23] = v24.Y
    local v25 = v24.X - 0.5
    local v26 = v24.Y - 0.5
    v14[v23] = v17(v25 * v25 + v26 * v26) * 8
    v12[v23] = v24.Y * 6
    v13[v23] = v24.X * 4
    v16[v23] = v8[v23]
    local v27 = (v24.Y - 0.4) / 0.6
    local v28 = v27 < 0 and 0 or v27
    v15[v23] = v28 > 1 and 1 or v28
end
local v29 = v3.LocalPlayer
local v30 = workspace.CurrentCamera
local v31 = script.CharacterOwner.Value
local v32
if v31 then
    v32 = v31 == v29.Character
else
    v32 = false
end
local v33 = v9 / 3
local v34 = math.ceil(v33)
local v35 = 0
local v36 = v32 and 0.008333333333333333 or 0.2
local v37 = 0
local v38 = 0
local v39 = 0
while true do
    repeat
        v35 = v35 + v2.Heartbeat:Wait()
    until v35 >= v36
    v37 = v37 + v35
    v35 = 0
    v38 = v38 + 1
    local v40, v41
    if v32 then
        v40 = v9
        v41 = 1
        goto l39
    end
    local v42 = v30.CFrame.Position - v4.Position
    local v43 = v42.X * v42.X + v42.Y * v42.Y + v42.Z * v42.Z
    if v43 <= 22500 then
        if v43 > 14400 then
            if v38 % 8 == 0 then
                v41 = v39 * v34 + 1
                v40 = v41 + v34 - 1
                if v9 < v40 then
                    v40 = v9
                end
                v39 = (v39 + 1) % 3
                goto l39
            end
        elseif v43 > 6400 then
            if v38 % 4 == 0 then
                v41 = v39 * v34 + 1
                v40 = v41 + v34 - 1
                if v9 < v40 then
                    v40 = v9
                end
                v39 = (v39 + 1) % 3
                ::l39::
                local v44 = v37 * 0.3
                local v45 = v37 * 0.5
                local v46 = v37 * 1.5
                local v47 = v37 * 2
                local v48 = v37 * 3.7
                for v49 = v41, v40 do
                    local v50 = v15[v49]
                    local v51 = (v45 + v13[v49]) % 6.283185307179586 / 6.283185307179586 * 512
                    local v52 = math.floor(v51)
                    local v53 = v20[bit32.band(v52, 511)] * 0.025 * v50
                    local v54 = (v46 + v14[v49]) % 6.283185307179586 / 6.283185307179586 * 512
                    local v55 = math.floor(v54)
                    local v56 = v20[bit32.band(v55, 511)] * 0.02
                    local v57 = (v47 + v12[v49]) % 6.283185307179586 / 6.283185307179586 * 512
                    local v58 = math.floor(v57)
                    local v59 = v20[bit32.band(v58, 511)] * 0.02
                    local v60 = (v48 + v13[v49] * 1.5) % 6.283185307179586 / 6.283185307179586 * 512
                    local v61 = math.floor(v60)
                    local v62 = v59 + v20[bit32.band(v61, 511)] * 0.016
                    local v63 = (v47 + v13[v49]) % 6.283185307179586 / 6.283185307179586 * 512
                    local v64 = math.floor(v63)
                    local v65 = v20[bit32.band(v64, 511)] * 0.016
                    local v66 = (v48 + v12[v49] * 0.8) % 6.283185307179586 / 6.283185307179586 * 512
                    local v67 = math.floor(v66)
                    local v68 = v65 + v20[bit32.band(v67, 511)] * 0.006
                    v19(v7, v16[v49], v18(v10[v49] + v56 + v62 + v53, v11[v49] + v44 - v56 * (1 - v50 * 0.5) + v68))
                end
            end
        elseif v38 % 2 == 0 then
            v40 = v9
            v41 = 1
            goto l39
        end
    end
end