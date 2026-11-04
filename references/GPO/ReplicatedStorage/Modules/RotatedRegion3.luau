 

local u1 = require(script:WaitForChild("GJK"))
local u2 = require(script:WaitForChild("Supports"))
local u3 = require(script:WaitForChild("Vertices"))
local u4 = {}
u4.__index = u4
local function u26(p5) --[[ Line: 86 ]]
    local v6 = {}
    local v7 = {}
    local v8 = {}
    for v9 = 1, #p5 do
        local v10 = p5[v9].x
        local v11 = p5[v9].y
        local v12 = p5[v9].z
        v6[v9] = v10
        v7[v9] = v11
        v8[v9] = v12
    end
    local v13 = unpack
    local v14 = math.min(v13(v6))
    local v15 = unpack
    local v16 = math.min(v15(v7))
    local v17 = unpack
    local v18 = math.min(v17(v8))
    local v19 = Vector3.new(v14, v16, v18)
    local v20 = unpack
    local v21 = math.max(v20(v6))
    local v22 = unpack
    local v23 = math.max(v22(v7))
    local v24 = unpack
    local v25 = math.max(v24(v8))
    return v19, Vector3.new(v21, v23, v25)
end
function u4.new(p27, u28) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if u28 == u28 then
        pcall(function() --[[ Line: 100 ]]
            --[[
            Upvalues:
                [1] = u28
            --]]
            if u28.X < 0 or (u28.Y < 0 or u28.Z < 0) then
                u28 = Vector3.new(0, 0, 0)
            end
        end)
        pcall(function() --[[ Line: 105 ]]
            --[[
            Upvalues:
                [1] = u28
            --]]
            if u28.Magnitude >= 6000 then
                warn("too bifg!")
                u28 = Vector3.new(10, 10, 10)
            end
        end)
        local v29 = u4
        local v30 = setmetatable({}, v29)
        v30.CFrame = p27
        v30.Size = u28
        v30.Shape = "Block"
        return v30
    end
end
u4.Block = u4.new
function u4.Wedge(p31, p32) --[[ Line: 129 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
        [4] = u26
    --]]
    local v33 = u4
    local v34 = setmetatable({}, v33)
    local v35 = u3.Block(p31, p32 / 2)
    v34.CFrame = p31
    v34.Size = p32
    v34.Shape = "Wedge"
    v34.Set = u3.Wedge(p31, p32 / 2)
    v34.Support = u2.PointCloud
    v34.Centroid = u3.GetCentroid(v34.Set)
    v34.AlignedRegion3 = Region3.new(u26(v35))
    return v34
end
function u4.CornerWedge(p36, p37) --[[ Line: 146 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
        [4] = u26
    --]]
    local v38 = u4
    local v39 = setmetatable({}, v38)
    local v40 = u3.Block(p36, p37 / 2)
    v39.CFrame = p36
    v39.Size = p37
    v39.Shape = "CornerWedge"
    v39.Set = u3.CornerWedge(p36, p37 / 2)
    v39.Support = u2.PointCloud
    v39.Centroid = u3.GetCentroid(v39.Set)
    v39.AlignedRegion3 = Region3.new(u26(v40))
    return v39
end
function u4.Cylinder(p41, u42) --[[ Line: 163 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
        [4] = u26
    --]]
    if u42 == u42 then
        pcall(function() --[[ Line: 167 ]]
            --[[
            Upvalues:
                [1] = u42
            --]]
            if u42.X < 0 or (u42.Y < 0 or u42.Z < 0) then
                u42 = Vector3.new(0, 0, 0)
            end
        end)
        local v43 = u4
        local v44 = setmetatable({}, v43)
        local v45 = u3.Block(p41, u42 / 2)
        v44.CFrame = p41
        v44.Size = u42
        v44.Shape = "Cylinder"
        v44.Set = { p41, u42 / 2 }
        v44.Support = u2.Cylinder
        v44.Centroid = p41.p
        v44.AlignedRegion3 = Region3.new(u26(v45))
        return v44
    end
end
function u4.Ball(p46, u47) --[[ Line: 188 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if u47 == u47 then
        pcall(function() --[[ Line: 192 ]]
            --[[
            Upvalues:
                [1] = u47
            --]]
            if u47.X < 0 or (u47.Y < 0 or u47.Z < 0) then
                u47 = Vector3.new(0, 0, 0)
            end
        end)
        local v48 = u4
        local v49 = setmetatable({}, v48)
        v49.CFrame = p46
        v49.Size = u47
        v49.Shape = "Ball"
        return v49
    end
end
function u4.FromPart(p50) --[[ Line: 213 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    return u4[u3.Classify(p50)](p50.CFrame, p50.Size)
end
function u4.CastPoint(p51, p52) --[[ Line: 219 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    return u1.new(p51.Set, { p52 }, p51.Centroid, p52, p51.Support, u2.PointCloud):IsColliding()
end
function u4.CastPart(p53, p54) --[[ Line: 224 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
    --]]
    local v55 = u4.FromPart(p54)
    return u1.new(p53.Set, v55.Set, p53.Centroid, v55.Centroid, p53.Support, v55.Support):IsColliding()
end
function u4.FindPartsInRegion3(p56, p57, p58) --[[ Line: 230 ]]
    local v59 = game.Workspace:FindPartsInRegion3(p56.AlignedRegion3, p57, p58)
    local v60 = {}
    for v61 = 1, #v59 do
        if p56:CastPart(v59[v61]) then
            local v62 = v59[v61]
            table.insert(v60, v62)
        end
    end
    return v60
end
local function u71(p63) --[[ Line: 265 ]]
    local v64 = #p63
    local v65 = 1
    local v66 = {}
    local v67 = {}
    while v65 <= v64 do
        local v68 = p63[v65]
        if v68 then
            local v69 = v68:FindFirstAncestor("SeaNPC")
            if v69 then
                local v70 = v69.Parent
                if v66[v70] then
                    table.remove(p63, v65)
                    v64 = v64 - 1
                else
                    v66[v70] = v68
                    table.insert(v67, v68)
                    v65 = v65 + 1
                end
            else
                table.insert(v67, v68)
                v65 = v65 + 1
            end
        else
            table.remove(p63, v65)
            v64 = v64 - 1
        end
    end
    return v67
end
local _ = game.GameId == 2097989947
local u72 = false
function u4.FindPartsInRegion3WithIgnoreList(p73, p74, p75) --[[ Line: 302 ]]
    --[[
    Upvalues:
        [1] = u71
    --]]
    local v76 = OverlapParams.new()
    v76.FilterType = Enum.RaycastFilterType.Exclude
    v76.MaxParts = p75 or 5000
    v76.FilterDescendantsInstances = p74 or {}
    v76.CollisionGroup = "ALL"
    if p73.Shape == "Block" then
        return u71(workspace:GetPartBoundsInBox(p73.CFrame, p73.Size, v76))
    else
        return u71(workspace:GetPartBoundsInRadius(p73.CFrame, p73.Size, v76))
    end
end
function u4.FindPartsInRegion3WithWhiteList(p77, p78, p79) --[[ Line: 316 ]]
    --[[
    Upvalues:
        [1] = u72
        [2] = u71
    --]]
    local v80 = OverlapParams.new()
    v80.FilterType = Enum.RaycastFilterType.Include
    v80.FilterDescendantsInstances = p78 or {}
    v80.MaxParts = p79 or 5000
    v80.CollisionGroup = "ALL"
    if u72 == true then
        local v81 = script:FindFirstChild(p77.Shape):Clone()
        v81.CFrame = p77.CFrame
        v81.Size = p77.Size
        if game:GetService("RunService"):IsServer() then
            v81.Color = Color3.fromRGB(0, 255, 0)
        end
        v81.Parent = workspace.Effects
        _G.destroy(v81, 0.25)
    end
    if p77.Shape == "Block" then
        return u71(workspace:GetPartBoundsInBox(p77.CFrame, p77.Size, v80))
    else
        return u71(workspace:GetPartBoundsInRadius(p77.CFrame.Position, p77.Size.X / 2, v80))
    end
end
function u4.Cast(p82, p83, p84) --[[ Line: 341 ]]
    --[[
    Upvalues:
        [1] = u71
    --]]
    return u71(p82:FindPartsInRegion3WithIgnoreList(type(p83) == "table" and p83 and p83 or { p83 }, p84))
end
return u4